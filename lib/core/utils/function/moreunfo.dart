// ignore_for_file: camel_case_types, must_be_immutable

import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/moreinfo.dart';
import 'package:flutter/material.dart';

class morinformation extends StatelessWidget {
  morinformation({
    super.key,
    required this.size,
    required this.isDark,
    required this.bond,
    required this.gester,
    required this.imagepath,
    required this.atom,
  });

  final Size size;
  final bool isDark;
  String atom;
  String bond;
  String imagepath;
  String gester;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: showdiloginfo(
                  gester:gester,
                  imagepath: imagepath,
                  size: size,
                  bond: bond,
                  atom:atom
                ),
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
