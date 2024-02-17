// ignore_for_file: file_names

import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/material.dart';

dynamic gradientTop(isDark) {
  return LinearGradient(colors: [
    isDark ? darkcolor : icolor,
    isDark ? darkcolor : icolor,
    isDark ? darkcolor : Colors.white,
    isDark ? darkcolor : kcolor,
    isDark ? darkcolor : icolor,
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);
}