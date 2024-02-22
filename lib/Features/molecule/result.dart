// ignore_for_file: camel_case_types
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/molcircularviewer.dart';
import 'package:Toxicon/core/utils/function/moreunfo.dart';
import 'package:Toxicon/core/utils/function/resultcontainer.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';

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
                molcircularviewer(isDark: isDark,Value: 10,color: seccolor,),
                SizedBox(height: size.height * .02),
                CustomTextfont24_600(text: 'Tox score')
              ],
            ),
            Column(
              children: [
               molcircularviewer(isDark: isDark,Value: 20,color: icolor,),
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
            morinformation(size: size, isDark: isDark)
          ],
        ),
        SizedBox(height: size.height * .04),
      ],
    );
  }
}
