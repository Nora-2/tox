from flask import Flask, request, jsonify, send_from_directory
from rdkit import Chem
from rdkit.Chem import AllChem
from flask_cors import CORS 
from rdkit.Chem import Draw
from rdkit.Chem.Draw import SimilarityMaps
import matplotlib.pyplot as plt
import os
from joblib import load
import numpy as np    
from rdkit.Chem import rdMolDescriptors
import tempfile
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
    #///////////// sascore/////////////
@app.route('/calculate_sa_score', methods=['POST'])
def calculate_sa_score():
    try:
        data = request.get_json()
        smiles = data.get('smiles')

        sa_score = calculate_sa_score_internal(smiles)

        if sa_score is not None:
            return jsonify({'success': True, 'sa_score':str(float(sa_score))[:5] })
        else:
            return jsonify({'success': False, 'error': 'Invalid SMILES'}), 400

    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

def calculate_sa_score_internal(smiles):
    mol = Chem.MolFromSmiles(smiles)

    if mol is None:
        return None

    sa_score = rdMolDescriptors.CalcNumRotatableBonds(mol) + rdMolDescriptors.CalcFractionCSP3(mol)
    return sa_score
#/////////////////// molmodel/////////////////
svm_model = load('svm_model.joblib')
@app.route('/predictmol', methods=['POST'])

def predictmolecule():
    try:
        data = request.get_json()
        smiles = data['smiles']
        fingerprint = generate_morgan_fingerprint(smiles)
        
        toxicity_score = (str(float(svm_model.decision_function([fingerprint])[0])) ) # Use decision function for SVM
        return jsonify({'toxicity_score': toxicity_score[:5]})

    except Exception as e:
        return jsonify({'success': False, 'error': str(e)})

def generate_morgan_fingerprint(smiles):
    mol = Chem.MolFromSmiles(smiles)
    morgan_fp = AllChem.GetMorganFingerprintAsBitVect(mol, 2, nBits=1024, useChirality=True, useBondTypes=True)
    return morgan_fp
#////////////////// sdf smile//////////
def smiles_to_sdf2d(smiles):
    # Create a molecule from the SMILES string
    mol = Chem.MolFromSmiles(smiles)

    if mol is None:
        raise ValueError(f"Invalid SMILES: {smiles}")

    # Generate 2D coordinates
    AllChem.Compute2DCoords(mol)

    # Convert molecule to SDF format
    sdf_data = Chem.MolToMolBlock(mol)

    return sdf_data

@app.route('/convert', methods=['POST'])
def convert_smiles_to_sdf2d():
    try:
        data = request.get_json(force=True)
        smiles_input = data['smiles']

        # Convert SMILES to SDF2D
        sdf2d_data = smiles_to_sdf2d(smiles_input)

        return jsonify({'sdf2d': sdf2d_data})
    except Exception as e:
        return jsonify({'error': str(e)})
# ///////////smile pdb/////////////////
def smiles_to_pdb(smiles):
    # Create a molecule from the SMILES string
    mol = Chem.MolFromSmiles(smiles)

    if mol is None:
        raise ValueError(f"Invalid SMILES: {smiles}")

    # Add explicit hydrogen atoms
    mol = Chem.AddHs(mol)

    # Generate 3D coordinates
    AllChem.EmbedMolecule(mol, randomSeed=42)

    # Write the molecule to a PDB file
    pdb_data = Chem.MolToPDBBlock(mol)
    
    return pdb_data

@app.route('/generate_pdb', methods=['POST'])
def generate_pdb():
    try:
        data = request.get_json(force=True)
        smiles_input = data['smiles']

        # Convert SMILES to PDB
        pdb_data = smiles_to_pdb(smiles_input)

        return jsonify({'pdb': pdb_data})
    except Exception as e:
        return jsonify({'error': str(e)})    
#//////////// mutagenicity smile////////////////
# Load the trained model
model = load('mutagenicitycsv.joblib')
# Endpoint to handle predictions
@app.route('/predictmutagenicity', methods=['POST'])
def predictmutagenicity():
    try:
        # Get the SMILES string from the request
        smiles = request.json['smiles']

        # Generate Morgan fingerprint for the input SMILES
        morgan_fp = generate_morgan_fingerprint(smiles)

        # Make predictions using the pre-trained model
        prediction = int(model.predict([morgan_fp])[0])

        # Return the prediction as JSON
        return jsonify({'prediction': prediction})

    except Exception as e:
        print(f"Error: {e}")
        return jsonify({'error': str(e)}), 500

# Generate Morgan fingerprints for each SMILES string
def generate_morgan_fingerprint(smiles):
    mol = Chem.MolFromSmiles(smiles)
    morgan_fp = AllChem.GetMorganFingerprintAsBitVect(mol, 2, nBits=1024)  # Radius 2
    return morgan_fp
# sdf to smile 
@app.route('/converttosmile', methods=['POST'])
def convert_sdf_to_smiles():
    try:
        # Receive SDF file from Flutter app
        sdf_file = request.files['file']
        sdf_file.save('temp.sdf')  # Save the uploaded file temporarily
        
        # Load the saved SDF file using RDKit
        sdf_supplier = Chem.SDMolSupplier('temp.sdf')
        
        # Convert each molecule to SMILES
        smiles_list = [Chem.MolToSmiles(mol) for mol in sdf_supplier if mol]
        
        # Save SMILES to a file
        with open('smiles.smi', 'w') as f:
            for smi in smiles_list:
                f.write("{}\n".format(smi))
        
        # Return success response
        return jsonify({"message": "Conversion successful"}), 200
    except Exception as e:
        print("Error:", e)  # Print the error message to console
        return jsonify({"error": str(e)}), 500
    #//////////// sdfmutagenicity//////////////
model = load('mutagenicitysdf.joblib')
temp_dir = tempfile.gettempdir()
@app.route('/predictsdfmutagenicity', methods=['POST'])
def predictsdfmuta():
    try:
        sdf_file = request.files['sdf_file']
        temp_sdf_path = os.path.join(temp_dir, 'temp.sdf')
        sdf_file.save(temp_sdf_path)
        supplier = Chem.SDMolSupplier(temp_sdf_path)
        smiles_list = [Chem.MolToSmiles(mol) for mol in supplier if mol is not None]
        molecules = [Chem.MolFromSmiles(smiles) for smiles in smiles_list]
        fingerprints = [AllChem.GetMorganFingerprintAsBitVect(mol, 3, nBits=2048) for mol in molecules]
        fingerprints_np = np.array(fingerprints)
        predictions = model.predict(fingerprints_np)
        return jsonify({'predictions': predictions.tolist()[0]})

    except Exception as e:
        print(f"Error: {e}")
        return jsonify({'error': str(e)}), 500
    
    # sdf to smile string
@app.route('/converttosmile2', methods=['POST'])
def convert_sdf_to_smiles2():
    try:
        # Receive SDF file from Flutter app
        sdf_file = request.files['file']
        sdf_file.save('temp.sdf')  # Save the uploaded file temporarily
        
        # Load the saved SDF file using RDKit
        sdf_supplier = Chem.SDMolSupplier('temp.sdf')
        
        # Convert each molecule to SMILES and concatenate into a single string
        smiles_str = '\n'.join([Chem.MolToSmiles(mol) for mol in sdf_supplier if mol])
        
        # Return the converted SMILES string
        return smiles_str, 200
    except Exception as e:
        print("Error:", e)  # Print the error message to console
        return jsonify({'error': str(e)}), 500
    
@app.route('/')
def index():
    return 'Welcome to the Toxikon API!'

if __name__ == '__main__':
    os.makedirs('static', exist_ok=True)
    app.run(debug=True)

