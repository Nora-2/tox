// ignore_for_file: camel_case_types
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
        CustomTextfont24_600(text: 'Result'),
        SizedBox(height: size.height * .04),
        
        
      ],
    );
  }
}
