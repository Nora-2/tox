// ignore_for_file: dead_code

import 'package:Toxicon/Features/liver/cubit/livercubit_cubit.dart';
import 'package:Toxicon/Features/liver/resultliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';
import 'package:Toxicon/core/constants/constants.dart';

// ignore: must_be_immutable
class LiverScreen extends StatefulWidget {
  const LiverScreen({super.key});

  @override
  State<LiverScreen> createState() => _LiverScreenState();
}

class _LiverScreenState extends State<LiverScreen> {
  TextEditingController liver = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    final size = MediaQuery.of(context).size;
    bool result = false;

    return BlocProvider(
        create: (context) => LivercubitCubit(),
        child: BlocConsumer<LivercubitCubit, LivercubitState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                body: SafeArea(
                    child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [icolor, icolor, kcolor, Colors.white, icolor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            // color: Colors.black,
                          )),
                      SizedBox(
                        width: size.width * .2,
                      ),
                      Image.asset(
                        'assets/images/liverhome.png',
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
                        color: isDark ? Colors.black : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 9,
                            offset: const Offset(0, -8),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Input',
                              style: GoogleFonts.sanchez(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 24)),
                            ),
                            SizedBox(
                              height: size.height * .015,
                            ),
                            CustomFormField(
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
                                    LivercubitCubit.get(context).changemode();
                                  });
                                },
                                child: Container(
                                  height: 44,
                                  width: size.width * .95,
                                  decoration: BoxDecoration(
                                    color: icolor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Submit',
                                      style: GoogleFonts.sanchez(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 22)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * .04),
                            LivercubitCubit.get(context).issubmit?
                                 resultliver(
                                    size: size, result: result, isDark: isDark)
                                : Center(
                                    child: Image.asset(
                                    'assets/images/befor lever.png',
                                    width: size.width * .9,
                                    height: size.height * .5,
                                  ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
          },
        ));
  }
}
