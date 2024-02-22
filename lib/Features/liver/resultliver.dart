// ignore_for_file: camel_case_types
import 'package:Toxicon/core/utils/function/moreunfo.dart';
import 'package:Toxicon/core/utils/function/resultcontainer.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';

class resultliver extends StatelessWidget {
  const resultliver({
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
        SizedBox(height: size.height * .04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            resultwidgetcontainer(
              size: size,
              isDark: isDark,
              result: result,
              text: 'Positive',
            ),
            resultwidgetcontainer(
              size: size,
              isDark: isDark,
              result: !result,
              text: 'Negative',
            ),
          ],
        ),
        SizedBox(height: size.height * .04),
        result
            ? Image.asset(
                ImageConstant.liverhelp,
                width: 500,
                height: 300,
              )
            : Image.asset(
                ImageConstant.livergood,
                width: 500,
                height: 300,
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
