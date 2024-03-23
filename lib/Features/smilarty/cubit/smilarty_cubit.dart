// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'smilarty_state.dart';

class SmilartyCubit extends Cubit<SmilartyState> {
  SmilartyCubit() : super(SmilartyInitial());
  static SmilartyCubit get(context) => BlocProvider.of(context);

  bool issubmit = false;
  viewResult() {
    issubmit = !issubmit;
    emit(changemodestate());
  }

  String imagePath = '';
  Future<void> generateSimilarityMap(
      {required String smile1, required String smile2}) async {
    const apiUrl = 'http://127.0.0.1:5000/generate_similarity_map';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'mol_smiles': smile1,
        'refmol_smiles': smile2,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        imagePath = data['image_path'];
        emit(smisuccess());
      } else {
        print(data['error']);
        emit(smifailed());
      }
    } else {
      print(response.reasonPhrase!);
    }
  }
}
