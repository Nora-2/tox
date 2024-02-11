// ignore_for_file: camel_case_types

import 'package:Toxicon/core/constants/constants.dart';
import 'package:Toxicon/core/utils/moreinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        Text(
          'Result',
          style: GoogleFonts.sanchez(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
        ),
        SizedBox(height: size.height * .04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 42,
              width: size.width * .44,
              decoration: BoxDecoration(
                border: Border.all(
                    color:  icolor, width: 2),
                color: result
                    ? icolor
                    : isDark
                        ?const Color(0xff0D0D0D)
                        : Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Positive',
                  style: GoogleFonts.sanchez(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20)),
                ),
              ),
            ),
            Container(
              height: 42,
              width: size.width * .4,
              decoration: BoxDecoration(
                border: Border.all(
                    color:  icolor, width: 2),
                color: !result
                    ? icolor
                    : isDark
                        ? const Color(0xff0D0D0D)
                        : Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Negative',
                  style: GoogleFonts.sanchez(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * .04),
        result
            ? Image.asset('assets/images/help-liver-2705065-2252541.png')
            : Image.asset('assets/images/good.png'),
        SizedBox(height: size.height * .04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'More Info',
              style: GoogleFonts.sanchez(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 24)),
            ),
            GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: showdiloginfo(size: size),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.arrow_drop_down,
                  color: isDark ? Colors.white :const Color(0xff0D0D0D),
                  size: 30,
                ))
          ],
        )
      ],
    );
  }
}
