
// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:circular/circular.dart';
import 'package:flutter/material.dart';

class molcircularviewer extends StatelessWidget {
  const molcircularviewer (
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
      textStyle: const TextStyle(fontSize: 30,color: Colors.black),
      color: const Color(0xffEEEEEE),
      sliderColor: color,
      unSelectedColor: const Color(0xffD7DEE7),
    );
  }
}
