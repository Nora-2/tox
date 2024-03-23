// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'livercubit_state.dart';

class LivercubitCubit extends Cubit<LivercubitState> {
  LivercubitCubit() : super(LivercubitInitial());
  static LivercubitCubit get(context) => BlocProvider.of(context);

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

  String gester = '';
  String imagePath = '';
  String atoms = '';
  int prediction = 0;

  Future<void> computeGasteigerCharges(String liver) async {
    String url = 'http://127.0.0.1:5000/compute_gasteiger_charges';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final String smiles = liver;
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({'smiles': smiles}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> gestere = jsonDecode(response.body);
        gester = gestere['result'];
        emit(gestersucssess());
      } else {
        gester = 'Error: ${response.statusCode}';
        emit(gesterfailed());
      }
    } catch (e) {
      gester = 'Error: $e';
    }
  }

  Future<void> predict(String liver) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/predict'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'smiles': liver}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final predictions = responseData['prediction']; // Convert to String

      prediction = predictions;
      emit(predictsucssess());
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
      emit(predictfailed());
    }
  }

  Future<void> generate3DStructure(String liver) async {
    String apiUrl = 'http://127.0.0.1:5000/generate_3d_structure';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': liver}),
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
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String resultsmile = '';
  Future<void> processSmiles(String liver) async {
    String url =
        'http://127.0.0.1:5000/process_smiles'; // Update with your server URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': liver}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        resultsmile = '${data['bonds']}';
        atoms = '${data['atoms']}';
        emit(atomsucssess());
      } else {
        resultsmile = response.statusCode as String;
        emit(atomfailed());
      }
    } catch (e) {
      print(e);
    }
  }

  CollectionReference history =
      FirebaseFirestore.instance.collection('history');
  Future<void> addhistory({required String liver, required String prediction, required String date}) {
    return history
        .add({
          'result': prediction,
          'input': liver,
          'date': date,
          'category': 'Liver Toxicity',
          'id': FirebaseAuth.instance.currentUser!.uid,
        })
        .then((value) => print("history Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
