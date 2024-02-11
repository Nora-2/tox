// ignore_for_file: camel_case_types

import 'package:Toxicon/core/constants/constants.dart';
import 'package:Toxicon/core/utils/moreinfo.dart';
import 'package:circular/circular.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class resultmolecule extends StatelessWidget {
  const resultmolecule({
    super.key,
    required this.size,
    required this.result,
    required this.isDark,
  });

  final Size size;
  final bool result;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Result',
          style: GoogleFonts.sanchez(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
        ),
        SizedBox(height: size.height * .024),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 42,
              width: size.width * .44,
              decoration: BoxDecoration(
                border: Border.all(
                    color:icolor, width: 2),
                color: result
                    ? icolor
                    : isDark
                        ?const Color(0xff0D0D0D)
                        : Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Toxic',
                  style: GoogleFonts.sanchez(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20)),
                ),
              ),
            ),
            Container(
              height: 42,
              width: size.width * .4,
              decoration: BoxDecoration(
                border: Border.all(
                    color:  icolor, width: 2),
                color: !result
                    ? icolor
                    : isDark
                        ? const Color(0xff0D0D0D)
                        : Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Non-Toxic',
                  style: GoogleFonts.sanchez(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * .04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CircularViewer(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(-5, -5),
                            color: isDark ?const Color(0xff0D0D0D) : Colors.white,
                            blurRadius: 20,
                            spreadRadius: 1),
                        const BoxShadow(
                            offset: Offset(5, 5),
                            color: Color.fromARGB(255, 158, 158, 158),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ]),
                  value: 20,
                  maxValue: 50,
                  radius: 90,
                  textStyle: const TextStyle(fontSize: 30),
                  color: const Color(0xffEEEEEE),
                  sliderColor: seccolor,
                  unSelectedColor: const Color(0xffD7DEE7),
                ),
                SizedBox(height: size.height * .02),
                Text(
                  'Tox score',
                  style: GoogleFonts.sanchez(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 24)),
                ),
              ],
            ),
            Column(
              children: [
                CircularViewer(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(-5, -5),
                            color: isDark ? const Color(0xff0D0D0D) : Colors.white,
                            blurRadius: 20,
                            spreadRadius: 1),
                        const BoxShadow(
                            offset: Offset(5, 5),
                            color: Color.fromARGB(255, 158, 158, 158),
                            blurRadius: 20,
                            spreadRadius: 1)
                      ]),
                  value: 10,
                  maxValue: 50,
                  radius: 90,
                  textStyle: const TextStyle(fontSize: 30),
                  color: const Color(0xffEEEEEE),
                  sliderColor: icolor,
                  unSelectedColor: const Color(0xffD7DEE7),
                ),
                SizedBox(height: size.height * .02),
                Text(
                  'SA score',
                  style: GoogleFonts.sanchez(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 24)),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: size.height * .1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'More Info',
              style: GoogleFonts.sanchez(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 24)),
            ),
            GestureDetector(
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
                  color: isDark ? Colors.white :const Color(0xff0D0D0D),
                  size: 30,
                ))
          ],
        )
      ],
    );
  }
}
