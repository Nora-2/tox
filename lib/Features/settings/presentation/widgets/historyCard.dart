// ignore_for_file: file_names

import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHistoryCard extends StatelessWidget {
  const CustomHistoryCard(
      {super.key,
      required this.input,
      required this.size,
      required this.output,
      required this.category,
      required this.date});
  final String input;
  final String output;
  final String date;
  final String category;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: isDark ? darkcolor : Colors.white,
        shadowColor: isDark ? black : Colors.white,
        elevation: 10,
        child: SizedBox(
          width: size.width * .95,
          height: size.height * .24,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Input',
                      style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              // color:  isDark?Colors.white70:black,
                              fontSize: 24)),
                    ),
                    SizedBox(
                      width: size.width * .09,
                    ),
                    Text(
                      input,
                      style: GoogleFonts.acme(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? Colors.white70
                                  : black,
                              fontSize: 20)),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Section',
                      style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              // color:  isDark?black:Colors.white,
                              fontSize: 20)),
                    ),
                    SizedBox(
                      width: size.width * .09,
                    ),
                    Text(
                      category,
                      style: GoogleFonts.acme(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? Colors.white70
                                  : black,
                              fontSize: 20)),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              // color:  isDark?black:Colors.white,
                              fontSize: 26)),
                    ),
                    SizedBox(
                      width: size.width * .09,
                    ),
                    Text(
                      date,
                      style: GoogleFonts.acme(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? Colors.white70
                                  : black,
                              fontSize: 20)),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Result',
                      style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              // color: black,
                              fontSize: 24)),
                    ),
                    SizedBox(
                      width: size.width * .09,
                    ),
                    Text(
                      output,
                      style: GoogleFonts.acme(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? Colors.white70
                                  : black,
                              fontSize: 20)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
