// ignore_for_file: dead_code, prefer_interpolation_to_compose_strings, use_build_context_synchronously, avoid_print
import 'package:Toxicon/Features/liver/cubit/livercubit_cubit.dart';
import 'package:Toxicon/Features/liver/resultliver.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/arrowpop.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';

DateTime dateToday = DateTime.now();
String date = dateToday.toString().substring(0, 10);

// ignore: must_be_immutable
class LiverScreen extends StatefulWidget {
  const LiverScreen({super.key});
  static String id = 'LiverScreen';
  @override
  State<LiverScreen> createState() => _LiverScreenState();
}

class _LiverScreenState extends State<LiverScreen> {
  TextEditingController liver = TextEditingController();
  String _result = '';
  String _imagePath = '';
  String atoms = '';
  String gester = '';
  int _prediction = 0;

 
    @override
  Widget build(BuildContext context) {
    CollectionReference history =
        FirebaseFirestore.instance.collection('history');
    String prediction=(_prediction == 0||_prediction<0) ? 'Negative' : 'Positive';

    Future<void> addhistory() {
      return history
          .add({
            'result':prediction,
            'input': liver.text,
            'date': date,
            'category': 'Liver Toxicity',
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
      create: (context) => LivercubitCubit(),
      child: BlocConsumer<LivercubitCubit, LivercubitState>(
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
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      arrowpop(isDark: isDark),
                      SizedBox(
                        width: size.width * .2,
                      ),
                      Image.asset(
                        ImageConstant.liverhome,
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
                                  controller: liver),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _predict();
                                      computeGasteigerCharges();
                                      _generate3DStructure();
                                      _processSmiles();
                                      addhistory();
                                      LivercubitCubit.get(context).viewResult();
                                    });
                                  },
                                  child: submit(size: size, isDark: isDark),
                                ),
                              ),
                              SizedBox(height: size.height * .04),
                              LivercubitCubit.get(context).issubmit
                                  ? resultliver(
                                      gester: gester,
                                      bond: _result,
                                      atom: atoms,
                                      size: size,
                                      imagepath: _imagePath,
                                      result: (_prediction==0||_prediction<0)?false:true,
                                      isDark: isDark)
                                  : Center(
                                      child: Image.asset(
                                      ImageConstant.liverbefor,
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
            ),
          );
        },
      ),
    );
  }
   Future<void> _predict() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/predict'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'smiles': liver.text}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final prediction =
          responseData['prediction']; // Convert to String
      setState(() {
        _prediction = prediction;
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> computeGasteigerCharges() async {
    String url = 'http://127.0.0.1:5000/compute_gasteiger_charges';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final String smiles = liver.text;

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({'smiles': smiles}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> gestere = jsonDecode(response.body);
        setState(() {
          gester = gestere['result'];
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
        body: jsonEncode({'smiles': liver.text}),
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
        body: jsonEncode({'smiles': liver.text}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
         
        setState(() {
          _result = '${data['bonds']}';
          atoms = '${data['atoms']}';
        });
      } else {
        setState(() {
          _result = response.statusCode as String;
        });
      }
    } catch (e) {
      setState(() {
        print(e);
      });
    }
  }
}
