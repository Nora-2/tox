// ignore_for_file: camel_case_types
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class resultsimilarty extends StatelessWidget {
   resultsimilarty({
    super.key,
    required this.size,
    required this.result,
    required this.isDark,
   required this.imagepath
  });

  final Size size;
  final bool result;
  final bool isDark;
  String imagepath;
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
          child: (imagepath.isNotEmpty)
              ? Image.network(imagepath,height: size.height * .4,
                  width: size.width * .9)
              : const Text('No similarity map generated yet'),
        ),
        SizedBox(height: size.height * .04),
       
      ],
    );
  }
}
