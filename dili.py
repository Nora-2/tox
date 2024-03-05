# from flask import Flask, request, jsonify, send_from_directory
# from rdkit import Chem
# from rdkit.Chem import AllChem
# from flask_cors import CORS  # Import the CORS extension
# from rdkit.Chem import Draw
# from rdkit.Chem.Draw import SimilarityMaps
# import matplotlib.pyplot as plt
# import os
# from joblib import load
# app = Flask(__name__)
# CORS(app) 
# @app.route('/generate_similarity_map', methods=['OPTIONS'])
# def handle_options():
#     response = jsonify({'success': True})
#     response.headers.add('Access-Control-Allow-Origin', '*')
#     response.headers.add('Access-Control-Allow-Headers', 'Content-Type')
#     response.headers.add('Access-Control-Allow-Methods', 'POST')
#     return response

# # ////////////////similarity map///////////////////
# @app.route('/generate_similarity_map', methods=['POST'])
# def generate_similarity_map():
#     try:
#         data = request.get_json()
#         mol_smiles = data.get('mol_smiles')
#         refmol_smiles = data.get('refmol_smiles')

#         mol = Chem.MolFromSmiles(mol_smiles)
#         refmol = Chem.MolFromSmiles(refmol_smiles)

#         if mol is None or refmol is None:
#             raise ValueError('Invalid SMILES input.')

#         fp = SimilarityMaps.GetMorganFingerprint(mol, fpType='bv')
#         fig, maxweight = SimilarityMaps.GetSimilarityMapForFingerprint(refmol, mol, SimilarityMaps.GetMorganFingerprint)

#         # Save the figure
#         output_filename = 'static/similarity_map.png'
#         plt.savefig(output_filename, bbox_inches='tight')

#         return jsonify({'success': True, 'image_path': output_filename})

#     except Exception as e:
#         return jsonify({'success': False, 'error': str(e)})


# # //////////////////////////dili///////////////////////
# loaded_model = load('dili.joblib')

# @app.route('/predict', methods=['POST'])
# def predict():
#     data = request.get_json()
#     smiles = data['smiles']
#     fingerprint = generate_morgan_fingerprint(smiles)
#     prediction = int(loaded_model.predict([fingerprint])[0])  # Convert to Python integer
#     return jsonify({'prediction': prediction})

# def generate_morgan_fingerprint(smiles):
#     mol = Chem.MolFromSmiles(smiles)
#     morgan_fp = AllChem.GetMorganFingerprintAsBitVect(mol, 2, nBits=1024, useChirality=True, useBondTypes=True)
#     return morgan_fp
# if __name__ == '__main__':
#     os.makedirs('static', exist_ok=True)
#     app.run(debug=True)
