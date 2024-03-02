// ignore_for_file: dead_code

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
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';
 DateTime dateToday =new DateTime.now(); 
  String date = dateToday.toString().substring(0,10);
// ignore: must_be_immutable
class LiverScreen extends StatefulWidget {
  const LiverScreen({super.key});
  static String id = 'LiverScreen';
  @override
  State<LiverScreen> createState() => _LiverScreenState();
}

class _LiverScreenState extends State<LiverScreen> {
  TextEditingController liver = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference history =
        FirebaseFirestore.instance.collection('history');

    Future<void> addhistory() {
      // Call the user's CollectionReference to add a new user
      return history
          .add({
            'result': 'positive',
            'input': liver.text,
            'date':date,
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
                                      size: size,
                                      result: LivercubitCubit().result,
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
}
