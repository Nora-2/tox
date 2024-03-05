from flask import Flask, request, jsonify, send_from_directory
from rdkit import Chem
from rdkit.Chem import AllChem
from flask_cors import CORS  # Import the CORS extension
from rdkit.Chem import Draw
from rdkit.Chem.Draw import SimilarityMaps
import matplotlib.pyplot as plt
import os
from joblib import load
app = Flask(__name__)
CORS(app) 

#////////////////////////////bond//////////////////
def process_smiles(smiles):
    molecule = Chem.MolFromSmiles(smiles)

    if molecule is None:
        return {'error': 'Invalid SMILES representation.'}
    atom_info_list=[]
    for atom in molecule.GetAtoms():
         atom_info_list.append(f"Atom Symbol {atom.GetSymbol()},Atomic Number{ atom.GetAtomicNum()}") 

    bond_info_list = []
    for bond in molecule.GetBonds():
        start_atom = bond.GetBeginAtom().GetIdx()
        end_atom = bond.GetEndAtom().GetIdx()
        bond_type = str(bond.GetBondType())
        bond_info_list.append(f"Bond between atom {start_atom} and {end_atom}: {bond_type}\n")
    output_stringatom = '\n'.join(atom_info_list)
    output_stringbond = '\n'.join(bond_info_list)
    return {'atoms': output_stringatom, 'bonds': output_stringbond}

@app.route('/process_smiles', methods=['POST'])
def process_smiles_route():
    data = request.get_json()

    if 'smiles' not in data:
        return jsonify({'error': 'SMILES not provided'}), 400

    smiles = data['smiles']
    result = process_smiles(smiles)

    return jsonify(result)
# ///////////////////image/////////////////////////
def smiles_to_3d_structure(smiles):
    molecule = Chem.MolFromSmiles(smiles)

    if molecule is None:
        print("Invalid SMILES representation.")
        return None

    molecule = Chem.AddHs(molecule)
    AllChem.EmbedMolecule(molecule)

    return molecule

def visualize_3d_structure(molecule, output_filename):
    img = Draw.MolToImage(molecule, size=(300, 300))
    img.save(output_filename, "PNG")

@app.route('/generate_3d_structure', methods=['POST'])
def generate_3d_structure():
    data = request.get_json()
    smiles = data['smiles']
    output_filename = 'static/molecule_3d.png'

    molecule = smiles_to_3d_structure(smiles)
    if molecule:
        visualize_3d_structure(molecule, output_filename)
        return jsonify({'success': True, 'message': '3D structure generated successfully', 'image_path': output_filename})
    else:
        return jsonify({'success': False, 'message': 'Invalid SMILES representation'})

@app.route('/static/<path:filename>')
def serve_image(filename):
    return send_from_directory('static', filename)
# ////////////gester charge///////////
@app.route('/compute_gasteiger_charges', methods=['POST'])
def compute_gasteiger_charges():
    data = request.get_json()
    smiles = data.get('smiles', '')
    molecule = Chem.MolFromSmiles(smiles)
    AllChem.ComputeGasteigerCharges(molecule)
    output_lines = []
    for atom in molecule.GetAtoms():
        atom_index = atom.GetIdx()
        symbol = atom.GetSymbol()
        gasteiger_charge = atom.GetDoubleProp('_GasteigerCharge')
        output_line = f"Atom Index: {atom_index}, Symbol: {symbol}, Gasteiger Charge: {gasteiger_charge}"
        output_lines.append(output_line)

    # Join the list of lines into a single string with newline characters
    output_string = '\n'.join(output_lines)

    return jsonify({"result": output_string})


# //////////////////////////dili///////////////////////
loaded_model = load('dili.joblib')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    smiles = data['smiles']
    fingerprint = generate_morgan_fingerprint(smiles)
    prediction = int(loaded_model.predict([fingerprint])[0])  # Convert to Python integer
    return jsonify({'prediction': prediction})

def generate_morgan_fingerprint(smiles):
    mol = Chem.MolFromSmiles(smiles)
    morgan_fp = AllChem.GetMorganFingerprintAsBitVect(mol, 2, nBits=1024, useChirality=True, useBondTypes=True)
    return morgan_fp


# ////////////////similarity map///////////////////

@app.route('/generate_similarity_map', methods=['POST'])
def generate_similarity_map():
    try:
        data = request.get_json()
        mol_smiles = data.get('mol_smiles')
        refmol_smiles = data.get('refmol_smiles')

        mol = Chem.MolFromSmiles(mol_smiles)
        refmol = Chem.MolFromSmiles(refmol_smiles)

        if mol is None or refmol is None:
            raise ValueError('Invalid SMILES input.')

        fp = SimilarityMaps.GetMorganFingerprint(mol, fpType='bv')
        fig, maxweight = SimilarityMaps.GetSimilarityMapForFingerprint(refmol, mol, SimilarityMaps.GetMorganFingerprint)

        # Save the figure
        output_filename = 'static/similarity_map.png'
        plt.savefig(output_filename, bbox_inches='tight')

        return jsonify({'success': True, 'image_path': output_filename})

    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})
@app.route('/')
def index():
    return 'Welcome to the Toxikon API!'

if __name__ == '__main__':
    os.makedirs('static', exist_ok=True)
    app.run(debug=True)

