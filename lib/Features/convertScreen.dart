// ignore_for_file: avoid_print, unused_field, avoid_web_libraries_in_flutter

import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class convertScreen extends StatefulWidget {
  const convertScreen({super.key});

  @override
  State<convertScreen> createState() => _convertScreenState();
}

class _convertScreenState extends State<convertScreen> {
  final TextEditingController _smilesController = TextEditingController();
  String _pdbData = '';
  bool _isLoading = false;
    String _sdf2dData = '';

  Future<void> _convertAndDownloadpdb() async {
    setState(() {
      _isLoading = true;
    });

    const String apiUrl = 'http://127.0.0.1:5000/generate_pdb';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': _smilesController.text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final pdbData = data['pdb'];

//         // Save the SDF2D data to a file using dart:html
        final blob = html.Blob([pdbData]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'webSaveLink'
          ..download = 'molecule.pdb';
        html.document.body?.append(anchor);
        anchor.click();
        html.Url.revokeObjectUrl(url);

        // Revoke the object URL after triggering the download
        html.Url.revokeObjectUrl(url);

        setState(() {
          _pdbData = 'Molecule data saved to molecule.pdb';
          _isLoading = false;
        });
      } else {
        setState(() {
          print('Error: ${response.statusCode}');
          _pdbData = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        print('Error: $e');
        _pdbData = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradientTop(isDark)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            
                
                Image.asset(
                  ImageConstant.converttop,
                  width: 190,
                  height: 100,
                )
              ],
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? black : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 10, right: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextfont24_600(text: 'Input'),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        CustomFormField(
                            ispass: false,
                            hint: 'Enter your Smile',
                            preicon: const Icon(
                              Icons.edit,
                              size: 19,
                              color: kcolor,
                            ),
                            controller: _smilesController),
                        SizedBox(
                          height: size.height * .04,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isLoading ? null : _convertAndDownloadpdb();
                              });
                            },
                            child: customButtonContainer(size: size, text: 'Convert and Download PDB')
                          ),
                        ),
                        SizedBox(height: size.height * .04),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                             _isLoading ? null : _convertAndDownload();
                              });
                            },
                            child: customButtonContainer(size: size, text: 'Convert and Download SDF')
                          ),
                        ),
                        SizedBox(height: size.height * .02),
                        Center(
                            child: Image.asset(
                          ImageConstant.converthome,
                          width: size.width * .9,
                          height: size.height * .4,
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
    Future<void> _convertAndDownload() async {
    setState(() {
      _isLoading = true;
    });

    const String apiUrl = 'http://127.0.0.1:5000/convert';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': _smilesController.text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final sdf2dData = data['sdf2d'];
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

        setState(() {
          _sdf2dData = 'Molecule data saved successfully';
          _isLoading = false;
        });
      } else {
        setState(() {
          print('Error: ${response.statusCode}');
          _sdf2dData = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        print('Error: $e');
        _sdf2dData = 'Error: $e';
        _isLoading = false;
      });
    }
  }
}
