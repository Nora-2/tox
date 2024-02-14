// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:Toxicon/Features/Authantication/checker.dart';
import 'package:Toxicon/core/utils/moreinfo.dart';
import 'package:circular/circular.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Data/Models/OnboardModel/onboard_model.dart';

const kBackgroundColor = Colors.white;
const seccolor = Color(0xffB5A1B7);
const kcolor = Color(0xff6FA9CB);
const icolor = Color.fromARGB(222, 164, 215, 244);
final darkcolor = kcolor.withAlpha(200);
const blackcolor = Color(0xff0D0D0D);
final black =  Colors.black54.withOpacity(.4);
List<OnboardModel> screens = <OnboardModel>[
  OnboardModel(
    lottieBuilder: 'assets/images/dna.png',
    text: "Mutagenicity",
    desc: 'You can easily know some molecule\nmay make mutation or not.',
    bg: kBackgroundColor,
  ),
  OnboardModel(
    lottieBuilder: 'assets/images/liver.png',
    text: "Liver toxicity",
    desc: 'You can easily know some molecule\naffects badly on liver or not.',
    bg: kBackgroundColor,
  ),
  OnboardModel(
    lottieBuilder: 'assets/images/chemical.png',
    text: "Toxicity of molecules",
    desc:
        'You can easily know toxicity of a molecule\n using a smile or an image.',
    bg: kBackgroundColor,
  ),
];

class arrowpop extends StatelessWidget {
  const arrowpop({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: isDark ? Colors.white : black,
        ));
  }
}

class submit extends StatelessWidget {
  const submit({
    super.key,
    required this.size,
    required this.isDark,
  });

  final Size size;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: size.width * .95,
      decoration: BoxDecoration(
        color: isDark ? darkcolor : icolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          'Submit',
          style: GoogleFonts.sanchez(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 22)),
        ),
      ),
    );
  }
}

class morinformation extends StatelessWidget {
  const morinformation({
    super.key,
    required this.size,
    required this.isDark,
  });

  final Size size;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: showdiloginfo(size: size),
              );
            },
          );
        },
        child: Icon(
          Icons.arrow_drop_down,
          color: isDark ? Colors.white : black,
          size: 30,
        ));
  }
}

class resultwidgetcontainer extends StatelessWidget {
  const resultwidgetcontainer(
      {super.key,
      required this.size,
      required this.isDark,
      required this.result,
      required this.text});


  final Size size;
  final bool isDark;
  final bool result;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: size.width * .44,
      decoration: BoxDecoration(
        border: Border.all(color: isDark ? darkcolor : icolor, width: 2),
        color: result
            ? isDark
                ? darkcolor
                : icolor
            : isDark
                ? Colors.transparent.withOpacity(0)
                : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.sanchez(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
        ),
      ),
    );
  }
}

class molcircularviewer extends StatelessWidget {
  const molcircularviewer(
      {super.key, required this.isDark, required this.Value,required this.color});

  final bool isDark;
  final double Value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return CircularViewer(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(200), boxShadow: [
        BoxShadow(
            offset: const Offset(-5, -5),
            color: isDark ? black : Colors.white,
            blurRadius: 20,
            spreadRadius: 1),
        const BoxShadow(
            offset: Offset(5, 5),
            color: Color.fromARGB(255, 158, 158, 158),
            blurRadius: 10,
            spreadRadius: 1)
      ]),
      value: Value,
      maxValue: 50,
      radius: 90,
      textStyle: const TextStyle(fontSize: 30),
      color: const Color(0xffEEEEEE),
      sliderColor: color,
      unSelectedColor: const Color(0xffD7DEE7),
    );
  }
}

class customButtonContainer extends StatelessWidget {
  const customButtonContainer({
    super.key,
    required this.size,
    required this.text,
  });

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: size.width * .8,
      decoration: BoxDecoration(
        color: kcolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.sanchez(
              color: Colors.white,
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        ),
      ),
    );
  }
}


class customtext50014 extends StatelessWidget {
  const customtext50014({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sanchez(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 14)),
    );
  }
}
bool _validate(
          String name, String email, String password, String rePassword) =>
      Checker.checkName(name) &&
      Checker.checkEmail(email) &&
      Checker.checkPassword(password) &&
      password == rePassword;

  void _wrongCase(BuildContext context, String name, String email,
      String password, String rePassword) {
    if (!Checker.checkName(name) || name.isEmpty) {
      AppMessage.customSnackBar(context: context, content: "Invalid name");
    } else if (!Checker.checkEmail(email) || email.isEmpty) {
      AppMessage.customSnackBar(context: context, content: "Invalid email");
    } else if (!Checker.checkPassword(password) || password.isEmpty) {
      AppMessage.customSnackBar(context: context, content: "Invalid password");
    } else if (!(password == rePassword) || rePassword.isEmpty) {
      AppMessage.customSnackBar(
          context: context, content: "Password must match");
    }
  }


class AppMessage {
  AppMessage._();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      customSnackBar(
          {required BuildContext context,
          required String content,
          Color backgroundColor = Colors.blue}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
