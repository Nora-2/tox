
// ignore_for_file: camel_case_types

import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/moreinfo.dart';
import 'package:flutter/material.dart';

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