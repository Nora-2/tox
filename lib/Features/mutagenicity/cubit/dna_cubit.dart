import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
part 'dna_state.dart';

class DnaCubit extends Cubit<DnaState> {
  DnaCubit() : super(DnaInitial());
  static DnaCubit get(context) => BlocProvider.of(context);

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

  // // Function to handle file selection
  // void _pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     setState(() {
  //       fileName = result.files.single.name;
  //       // Perform any additional actions with the selected file if needed
  //     });
  //   }
  // }
  CollectionReference history =
      FirebaseFirestore.instance.collection('history');
  Future<void> addhistory(
      {required String dna, required String prediction, required String date}) {
    return history
        .add({
          'result': prediction,
          'input': dna,
          'date': date,
          'category': 'mutagenicity',
          'id': FirebaseAuth.instance.currentUser!.uid,
        })
        .then((value) => print("history Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  String fileName = 'mol.sdf'; // Default file name
  String resultdna = '';
  String imagePath = '';
  String atoms = '';
  String gester = '';

  Future<void> computeGasteigerCharges(String dna) async {
    String url = 'http://127.0.0.1:5000/compute_gasteiger_charges';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final String smiles = dna;

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({'smiles': smiles}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> ge = jsonDecode(response.body);

        gester = ge['result'];
        emit(gestersucssess());
      } else {
        gester = 'Error: ${response.statusCode}';
        emit(gesterfailed());
      }
    } catch (e) {
      gester = 'Error: $e';
    }
  }

  Future<void> generate3DStructure(String dna) async {
    String apiUrl = 'http://127.0.0.1:5000/generate_3d_structure';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': dna}),
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
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Error: ${response.reasonPhrase}')),
        // );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> processSmiles(String dna) async {
    String url =
        'http://127.0.0.1:5000/process_smiles'; // Update with your server URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': dna}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        resultdna = '${data['bonds']}';
        atoms = '${data['atoms']}';
        emit(atomsucssess());
      } else {
        resultdna = 'Error: ${response.statusCode}';
        emit(atomfailed());
      }
    } catch (e) {
      resultdna = 'Error: $e';
    }
  }

  int predictiondna = 0;

  Future<void> makePrediction(String dna) async {
    const String apiUrl = 'http://127.0.0.1:5000/predictmutagenicity';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': dna}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        predictiondna = data['prediction'];
        emit(predictsucssess());
      } else {
         emit(predictfailed());
        throw Exception('Failed to connect to the server');
       
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
