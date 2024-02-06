// ignore_for_file: dead_code

import 'package:flutter/material.dart';
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
     final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
bool isDark = brightnessValue == Brightness.dark;
    final size = MediaQuery.of(context).size;
    bool result = false;
    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration:  const BoxDecoration(
        gradient: LinearGradient(
            colors: [icolor,icolor,  kcolor, Colors.white ,icolor], 
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
                
                 color: isDark?Colors.black:Colors.white,
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
                padding: const EdgeInsets.only(top:30.0,left: 10,right: 10),
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
                        onTap: () {},
                        child: Container(
                          height: 44,
                          width: size.width * .95,
                          decoration: BoxDecoration(
                            color: icolor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {},
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
                    ),
                    SizedBox(height: size.height * .04),
                    Text(
                      'Result',
                      style: GoogleFonts.sanchez(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 24)),
                    ),
                     SizedBox(height: size.height * .04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Container(
                      
                          height: 42,
                          width: size.width * .44,
                          decoration: BoxDecoration(
                            border: Border.all(color:icolor,width: 2 ),
                            
                            color: result?icolor:isDark?Colors.black:Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'Positive',
                              style: GoogleFonts.sanchez(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 20)),
                            ),
                          ),
                        ),Container(
                          height: 42,
                          width: size.width * .4,
                          decoration: BoxDecoration(
                            border: Border.all(color:icolor,width: 2 ),
                            color:!result?icolor:isDark?Colors.black:Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              'Negative',
                              style: GoogleFonts.sanchez(
                                  textStyle: const  TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 20)),
                            ),
                          ),
                        ),],),
                         SizedBox(height: size.height * .04),
                        result?Image.asset('assets/images/help-liver-2705065-2252541.png'):Image.asset('assets/images/good.png')
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
