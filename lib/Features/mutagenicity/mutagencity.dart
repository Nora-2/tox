// ignore_for_file: dead_code, use_build_context_synchronously, prefer_interpolation_to_compose_strings, avoid_print
import 'package:Toxicon/Features/mutagenicity/cubit/dna_cubit.dart';
import 'package:Toxicon/Features/mutagenicity/mutresult.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/arrowpop.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

DateTime dateToday = DateTime.now();
String date = dateToday.toString().substring(0, 10);

// ignore: must_be_immutable
class MutagencityScreen extends StatefulWidget {
  const MutagencityScreen({super.key});
  static String id = 'MutagencityScreen';
  @override
  State<MutagencityScreen> createState() => _MutagencityScreenState();
}

class _MutagencityScreenState extends State<MutagencityScreen> {
  TextEditingController dna = TextEditingController();
  String fileName = 'mol.sdf'; // Default file name
  String _result = '';
  String _imagePath = '';
  String atoms = '';
  String gester = '';

  Future<void> computeGasteigerCharges() async {
    String url = 'http://127.0.0.1:5000/compute_gasteiger_charges';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final String smiles = dna.text;

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({'smiles': smiles}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> ge = jsonDecode(response.body);
        setState(() {
          gester = ge['result'];
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
        body: jsonEncode({'smiles': dna.text}),
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
    String url =
        'http://127.0.0.1:5000/process_smiles'; // Update with your server URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': dna.text}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        // Assuming the data structure is {'atoms': [], 'bonds': []}
        // Update the code according to the actual structure of your response
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

  int _prediction = 0;

  Future<void> _makePrediction() async {
    const String apiUrl = 'http://127.0.0.1:5000/predictmutagenicity';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': dna.text}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _prediction = data['prediction'];
        });
      } else {
        throw Exception('Failed to connect to the server');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Function to handle file selection
  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
        // Perform any additional actions with the selected file if needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference history =
        FirebaseFirestore.instance.collection('history');
String prediction=(_prediction == 0||_prediction<0) ? 'non mutagenic' : 'mutagenic';

    Future<void> addhistory() {
      return history
          .add({
            'result': prediction,
            'input': dna.text,
            'date': date,
            'File_Sdf': fileName,
            'category': 'mutagenicity',
            'id': FirebaseAuth.instance.currentUser!.uid,
          })
          .then((value) => print("history Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    final size = MediaQuery.of(context).size;
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return BlocProvider(
        create: (context) => DnaCubit(),
        child: BlocConsumer<DnaCubit, DnaState>(
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
                          ImageConstant.dnaresult,
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
                              SizedBox(
                                height: size.height * .055,
                                child: CustomFormField(
                                    ispass: false,
                                    hint: 'Enter your Smile',
                                    preicon: const Icon(
                                      Icons.edit,
                                      size: 19,
                                      color: kcolor,
                                    ),
                                    controller: dna),
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Container(
                                height: size.height * .055,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey.withOpacity(.8)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        fileName,
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.grey),
                                      ),
                                      IconButton(
                                          onPressed: _pickFile,
                                          icon: const Icon(
                                            Icons.upload_file,
                                            color: kcolor,
                                            size: 28,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              Center(
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _makePrediction();
                                          computeGasteigerCharges();
                                          _generate3DStructure();
                                          _processSmiles();
                                          addhistory();
                                          DnaCubit.get(context).viewResult();
                                        });
                                      },
                                      child:
                                          submit(size: size, isDark: isDark))),
                              SizedBox(height: size.height * .04),
                              DnaCubit.get(context).issubmit
                                  ? dnaresult(
                                      atom: atoms,
                                      gester: gester,
                                      bond: _result,
                                      imagepath: _imagePath,
                                      size: size,
                                      result: (_prediction==0||_prediction<0)?false:true,
                                      isDark: isDark)
                                  : Center(
                                      child: Image.asset(
                                      ImageConstant.dnabefor,
                                      width: size.width * .9,
                                      height: size.height * .45,
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
