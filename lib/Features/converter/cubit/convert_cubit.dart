import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
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
}
