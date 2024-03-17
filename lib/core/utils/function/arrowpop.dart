
// ignore_for_file: camel_case_types

import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/material.dart';

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
          Icons.arrow_back_ios,
          color: isDark ? Colors.white : black,
        ));
  }
}

