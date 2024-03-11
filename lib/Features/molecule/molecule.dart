// ignore_for_file: dead_code, avoid_print, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:Toxicon/Features/molecule/cubit/molecule_cubit.dart';
import 'package:Toxicon/Features/molecule/result.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';
import '../../core/utils/function/arrowpop.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

DateTime dateToday = DateTime.now();
String date = dateToday.toString().substring(0, 10);

// ignore: must_be_immutable
class MoleculeScreen extends StatefulWidget {
  const MoleculeScreen({super.key});
  static String id = 'MoleculeScreen';
  @override
  State<MoleculeScreen> createState() => _MoleculeScreenState();
}

class _MoleculeScreenState extends State<MoleculeScreen> {
  TextEditingController mol = TextEditingController();
  String _result = '';
  String _imagePath = '';
  String atoms = '';
  String gester = '';
  double _saScore = 0.0;
  double toxicityScore = 0.0;

  Future<void> predictToxicity() async {
    const apiUrl =
        'http://127.0.0.1:5000/predictmol'; // Update with your Flask API endpoint
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'smiles': mol.text}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      setState(() {
        toxicityScore = double.parse(result['toxicity_score'].toString());
        print('sasccore========$toxicityScore');
      });
    } else {
      setState(() {
        // toxicityScore = 'Error: ${response.statusCode}';
      });
    }
  }

  Future<void> _calculateSaScore() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/calculate_sa_score'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'smiles': mol.text}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      setState(() {
        _saScore = double.parse(result['sa_score'].toString());
        print('sasccore========${_saScore}');
      });
    } else {
      // Handle errors
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> computeGasteigerCharges() async {
    String url = 'http://127.0.0.1:5000/compute_gasteiger_charges';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final String smiles = mol.text;

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({'smiles': smiles}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> gest = jsonDecode(response.body);
        setState(() {
          gester = gest['result'];
        });
      } else {
        setState(() {
          gester = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        gester = 'Error: $e';
      });
    }
  }

  Future<void> _generate3DStructure() async {
    String apiUrl = 'http://127.0.0.1:5000/generate_3d_structure';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': mol.text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            _imagePath = 'http://127.0.0.1:5000/' + data['image_path'];
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${data['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _processSmiles() async {
    const String url =
        'http://127.0.0.1:5000/process_smiles'; // Update with your server URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': mol.text}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _result = '${data['bonds']}';
          atoms = '${data['atoms']}';
        });
      } else {
        setState(() {
          _result = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference history =
        FirebaseFirestore.instance.collection('history');
    bool result = toxicityScore  > 1 || toxicityScore  == 1
        ? true
        : false;

    Future<void> addhistory() {
      // Call the user's CollectionReference to add a new user
      return history
          .add({
            'result':  toxicityScore  > 1 || toxicityScore  == 1?'toxic':'non-toxic',
            'input': mol.text,
            'date': date,
            'category': 'molecule Toxicity',
            'id': FirebaseAuth.instance.currentUser!.uid,
          })
          .then((value) => print("history Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;

    final size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) => MoleculeCubit(),
        child: BlocConsumer<MoleculeCubit, MoleculeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                body: Container(
              decoration: BoxDecoration(gradient: gradientTop(isDark)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * .03,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        arrowpop(isDark: isDark),
                        SizedBox(
                          width: size.width * .2,
                        ),
                        Image.asset(
                          ImageConstant.molresult,
                          width: 190,
                          height: 100,
                        )
                      ],
                    ),
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
                            blurRadius: 9,
                            offset: const Offset(0, -2),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 10, right: 10),
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
                                  controller: mol),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    print(_saScore);
                                    print(toxicityScore);
                                    setState(() {
                                      predictToxicity();
                                      _calculateSaScore();
                                      computeGasteigerCharges();
                                      _generate3DStructure();
                                      _processSmiles();
                                      addhistory();
                                      MoleculeCubit.get(context).viewResult();
                                    });
                                  },
                                  child: submit(size: size, isDark: isDark),
                                ),
                              ),
                              SizedBox(height: size.height * .02),
                              MoleculeCubit.get(context).issubmit
                                  ? resultmolecule(
                                      atom: atoms,
                                      gester: gester,
                                      size: size,
                                      sascore: _saScore,
                                      toxscore: toxicityScore,
                                      imagepath: _imagePath,
                                      bond: _result,
                                      result: result,
                                      isDark: isDark)
                                  : Center(
                                      child: Image.asset(
                                      ImageConstant.molbefor,
                                      width: size.width * .9,
                                      height: size.height * .5,
                                    ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
          },
        ));
  }
}
