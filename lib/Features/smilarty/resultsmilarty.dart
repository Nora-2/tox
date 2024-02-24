// ignore_for_file: camel_case_types
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';

class resultsimilarty extends StatelessWidget {
  const resultsimilarty({
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
        SizedBox(height: size.height * .04),
        CustomTextfont24_600(text: 'SimilarityMapForFingerprint'),
        SizedBox(height: size.height * .02),
        Center(
            child: Image.asset(
          ImageConstant.finger,
          width: size.width * .9,
          height: size.height * .4,
        )),
        SizedBox(height: size.height * .04),
        CustomTextfont24_600(text: 'count-based fingerprints'),
        SizedBox(height: size.height * .02),
        Center(
            child: Image.asset(
          ImageConstant.count,
          width: size.width * .9,
          height: size.height * .4,
        )),
      ],
    );
  }
}
