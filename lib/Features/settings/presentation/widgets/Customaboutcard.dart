import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Toxicon/core/constants/constants.dart';

class CustomInfoCard extends StatelessWidget {
  const CustomInfoCard({
    super.key,
    required this.titel,
    required this.subtitel,
    required this.size,
  });
  final String titel;
  final String subtitel;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: icolor.withOpacity(0.95),
        shadowColor: isDark ? Colors.white :const Color(0xff0D0D0D),
        elevation: 10,
        child: SizedBox(
          width: size.width * .90,
          height: size.height * .16,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  titel,
                  style: GoogleFonts.acme(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          // color: Color(0xff0D0D0D),
                          fontSize: 18)),
                ),
                SizedBox(
                  height: size.height * .015,
                ),
                Text(
                  subtitel,
                  style: GoogleFonts.acme(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          // color: Color(0xff0D0D0D),
                          fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
