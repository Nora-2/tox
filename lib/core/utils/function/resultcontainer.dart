
// ignore_for_file: camel_case_types

import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/material.dart';


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
          style:
                  const TextStyle( fontFamily: 'sanchez',fontWeight: FontWeight.w500, fontSize: 20)),
        
      ),
    );
  }
}