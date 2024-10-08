// ignore_for_file: camel_case_types
import 'package:Toxicon/core/utils/function/moreunfo.dart';
import 'package:Toxicon/core/utils/function/resultcontainer.dart';
import 'package:Toxicon/core/constants/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class dnaresult extends StatelessWidget {
  dnaresult(
      {super.key,
      required this.size,
      required this.result,
      required this.isDark,
      required this.bond,
      required this.gester,
      required this.atom,
      required this.imagepath});

  final Size size;
  final bool result;
  final bool isDark;
  String imagepath;
  String gester;
  String bond;
  String atom;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextfont24_600(text: 'Result'),
        SizedBox(height: size.height * .04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            resultwidgetcontainer(
              size: size,
              isDark: isDark,
              result: result,
              text: 'Mutagenic',
            ),
            resultwidgetcontainer(
              size: size,
              isDark: isDark,
              result: !result,
              text: 'Non-Mutagenic',
            ),
          ],
        ),
        SizedBox(height: size.height * .04),
        result
            ? Center(
                child: Image.asset(
                ImageConstant.dnasad,
                width: 200,
                height: 300,
                fit: BoxFit.cover,
              ))
            : Center(
                child: Image.asset(
                ImageConstant.dnahappy,
                width: 200,
                height: 300,
                fit: BoxFit.cover,
              )),
        SizedBox(height: size.height * .04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextfont24_600(text: 'More Info'),
            morinformation(
                gester: gester,
                atom: atom,
                size: size,
                isDark: isDark,
                bond: bond,
                imagepath: imagepath)
          ],
        ),
        SizedBox(height: size.height * .04),
      ],
    );
  }
}
