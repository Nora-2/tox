// ignore_for_file: must_be_immutable, camel_case_types

import 'package:Toxicon/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Styles {
  static const textStyle18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static const textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  static const textStyle30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    // fontFamily: kGtSectraFine,
    letterSpacing: 1.2,
  );
  static const textStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const textStyle16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static final textStyleacme30 = GoogleFonts.acme(
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30));
  static final textStyphilosopher17 = GoogleFonts.philosopher(
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17));
}

dynamic gradientTop(isDark) {
  return LinearGradient(colors: [
    isDark ? black : icolor,
    isDark ? black : icolor,
    isDark ? black : Colors.white,
    isDark ? black : kcolor,
    isDark ? black : icolor,
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);
}


class CustomText extends StatelessWidget {
  CustomText({
    required this.text,
    required this.style,
    super.key,
  });
  String text;
  dynamic style;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}

class CustomTextfont24_600 extends StatelessWidget {
  CustomTextfont24_600({
    required this.text,
    super.key,
  });
  String text;
  dynamic style;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sanchez(
          textStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
    );
  }
}


class CustomTextfont24_900 extends StatelessWidget {
  CustomTextfont24_900({
    required this.text,
    super.key,
  });
  String text;
  dynamic style;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sanchez(
          textStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
    );
  }
}

class CustomTextfont16_700 extends StatelessWidget {
  CustomTextfont16_700({
    required this.text,
    super.key,
  });
  String text;
  dynamic style;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sanchez(
          textStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
    );
  }
}

class customtext60020 extends StatelessWidget {
  const customtext60020({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.acme(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              // color: black,
              fontSize: 20)),
    );
  }
}

class customtext400_12 extends StatelessWidget {
  const customtext400_12({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
     text,
      style: GoogleFonts.sanchez(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 12)),
    );
  }
}

class CustomTextfont16_500 extends StatelessWidget {
  CustomTextfont16_500({
    required this.text,
    super.key,
  });
  String text;
  dynamic style;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sanchez(
          textStyle:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
    );
  }
}
class CustomTextfont12_700 extends StatelessWidget {
  CustomTextfont12_700({
    required this.text,
    super.key,
  });
  String text;
  dynamic style;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.sanchez(
          textStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }
}
class customsizebox extends StatelessWidget {
  const customsizebox({
    super.key,
    required this.size,
    required this.height,
  });

  final Size size;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * height,
    );
  }
}

class customsizeboxwidth extends StatelessWidget {
  const customsizeboxwidth({
    super.key,
    required this.size,
    required this.width,
  });

  final Size size;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * width,
    );
  }
}
