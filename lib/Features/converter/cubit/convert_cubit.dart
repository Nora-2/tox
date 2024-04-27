// ignore_for_file: use_build_context_synchronously, avoid_web_libraries_in_flutter, depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:html' show AnchorElement, Blob, Url;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

part 'convert_state.dart';

class ConvertCubit extends Cubit<ConvertState> {
  ConvertCubit() : super(ConvertInitial());
  static ConvertCubit get(context) => BlocProvider.of(context);
  String pdbData = '';
  String sdf2dData = '';
  Future<void> convertAndDownload(String convert) async {
    const String apiUrl = 'http://127.0.0.1:5000/convert';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': convert}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        sdf2dData = data['sdf2d'];
        emit(sdfsucsses());
        print('...........$sdf2dData');

        // Save the SDF2D data to a file using dart:html
        final blob = html.Blob([sdf2dData]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'webSaveLink'
          ..download = 'molecule.sdf';
        html.document.body?.append(anchor);
        anchor.click();
        html.Url.revokeObjectUrl(url);
        sdf2dData = 'Molecule data saved successfully';
        emit(sdfsucssessave());
      } else {
        print('Error: ${response.statusCode}');
        sdf2dData = 'Error: ${response.statusCode}';
        emit(sdffailed());
      }
    } catch (e) {
      print('Error: $e');
      sdf2dData = 'Error: $e';
      emit(sdffailedsave());
    }
  }

  Future<void> convertAndDownloadpdb(String convert) async {
    const String apiUrl = 'http://127.0.0.1:5000/generate_pdb';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': convert}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        pdbData = data['pdb'];
        emit(pdbsucsess());
        final blob = html.Blob([pdbData]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'webSaveLink'
          ..download = 'molecule.pdb';
        html.document.body?.append(anchor);
        anchor.click();
        html.Url.revokeObjectUrl(url);
        pdbData = 'Molecule data saved to molecule.pdb';
        emit(pdbsucsesssave());
      } else {
        print('Error: ${response.statusCode}');
        pdbData = 'Error: ${response.statusCode}';
        emit(pdpfailed());
      }
    } catch (e) {
      print('Error: $e');
      pdbData = 'Error: $e';
      emit(pdpfailedsave());
    }
  }

  PlatformFile? selectedFile;
  Future<void> uploadFile(BuildContext context) async {
    if (selectedFile == null) {
      // Handle case when no file is selected
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://127.0.0.1:5000/converttosmile'), // Update URL accordingly
      );
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          selectedFile!.bytes!,
          filename: selectedFile!.name,
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful conversion
        if (kIsWeb) {
          // For web, create a Blob URL and initiate download
          Uint8List content = await response.stream.toBytes();
          final blob = Blob([content]);
          final url = Url.createObjectUrlFromBlob(blob);
          AnchorElement(href: url)
            ..setAttribute("download", "smiles.smi")
            ..click();
          Url.revokeObjectUrl(url);
          emit(sdfsmilesucssess());
        } else {
          // For other platforms, show a SnackBar with download message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File downloaded successfully'),
            ),
          );
        }
      } else {
        // Handle other status codes
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

}
