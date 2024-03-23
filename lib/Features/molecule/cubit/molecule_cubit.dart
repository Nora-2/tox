// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
part 'molecule_state.dart';

class MoleculeCubit extends Cubit<MoleculeState> {
  MoleculeCubit() : super(MoleculeInitial());
  static MoleculeCubit get(context) => BlocProvider.of(context);

  bool result = false;
  void changeresult() {
    result = !result;
    emit(changeresultstate());
  }

  bool issubmit = false;
  void viewResult() {
    issubmit = !issubmit;
    emit(changemodestate());
  }

  String resultmol = '';
  String imagePath = '';
  String atoms = '';
  String gester = '';
  double saScore = 0.0;
  double toxicityScore = 0.0;

  Future<void> predictToxicity(String mol) async {
    const apiUrl =
        'http://127.0.0.1:5000/predictmol'; // Update with your Flask API endpoint
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'smiles': mol}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      toxicityScore = double.parse(result['toxicity_score'].toString());
      emit(predictsucssess());
      print('sasccore========$toxicityScore');
    } else {}
  }

  Future<void> calculateSaScore(String mol) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/calculate_sa_score'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'smiles': mol}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      saScore = double.parse(result['sa_score'].toString());
      emit(sasucssess());
    } else {
      // Handle errors
      print('Error: ${response.statusCode}');
      emit(safailed());
    }
  }

  Future<void> computeGasteigerCharges(String mol) async {
    String url = 'http://127.0.0.1:5000/compute_gasteiger_charges';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final String smiles = mol;

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({'smiles': smiles}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> gest = jsonDecode(response.body);

        gester = gest['result'];
        emit(gestersucssess());
      } else {
        gester = 'Error: ${response.statusCode}';
        emit(gesterfailed());
      }
    } catch (e) {
      gester = 'Error: $e';
    }
  }

  Future<void> generate3DStructure(String mol) async {
    String apiUrl = 'http://127.0.0.1:5000/generate_3d_structure';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': mol}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          imagePath = 'http://127.0.0.1:5000/' + data['image_path'];
          emit(d2sucssess());
        } else {
          print('Error: ${data['message']}');
          emit(d2failed());
        }
      } else {
        //  'Error: ${response.reasonPhrase};
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> processSmiles(String mol) async {
    const String url =
        'http://127.0.0.1:5000/process_smiles'; // Update with your server URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': mol}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        resultmol = '${data['bonds']}';
        atoms = '${data['atoms']}';
        emit(atomsucssess());
      } else {
        resultmol = 'Error: ${response.statusCode}';
        emit(atomfailed());
      }
    } catch (e) {
      resultmol = 'Error: $e';
    }
  }
    CollectionReference history =
      FirebaseFirestore.instance.collection('history');
  Future<void> addhistory({required String mol, required String prediction, required String date}) {
    return history
        .add({
          'result': prediction,
          'input': mol,
          'date': date,
          'category': 'molecule Toxicity',
          'id': FirebaseAuth.instance.currentUser!.uid,
        })
        .then((value) => print("history Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
