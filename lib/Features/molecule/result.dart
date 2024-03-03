// ignore_for_file: camel_case_types
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/molcircularviewer.dart';
import 'package:Toxicon/core/utils/function/moreunfo.dart';
import 'package:Toxicon/core/utils/function/resultcontainer.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class resultmolecule extends StatelessWidget {
  resultmolecule(
      {super.key,
      required this.size,
      required this.result,
      required this.isDark,
      required this.bond,
      required this.atom,
      required this.gester,
      required this.imagepath});

  final Size size;
  final bool result;
  String bond;
  final bool isDark;
  String imagepath;
  String atom;
  String gester;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextfont24_600(text: 'Result'),
        SizedBox(height: size.height * .024),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            resultwidgetcontainer(
              size: size,
              isDark: isDark,
              result: result,
              text: 'Toxic',
            ),
            resultwidgetcontainer(
              size: size,
              isDark: isDark,
              result: !result,
              text: 'Non-Toxic',
            ),
          ],
        ),
        SizedBox(height: size.height * .04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                molcircularviewer(
                  isDark: isDark,
                  Value: 10,
                  color: seccolor,
                ),
                SizedBox(height: size.height * .02),
                CustomTextfont24_600(text: 'Tox score')
              ],
            ),
            Column(
              children: [
                molcircularviewer(
                  isDark: isDark,
                  Value: 20,
                  color: icolor,
                ),
                SizedBox(height: size.height * .02),
                CustomTextfont24_600(text: 'SA score')
              ],
            )
          ],
        ),
        SizedBox(height: size.height * .04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextfont24_600(text: 'More Info'),
            morinformation(
              gester: gester ,
              atom:atom ,
              size: size,
              isDark: isDark,
              bond: bond,
              imagepath: imagepath,
            )
          ],
        ),
        SizedBox(height: size.height * .04),
      ],
    );
  }
}
