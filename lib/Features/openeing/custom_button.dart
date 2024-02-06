import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Toxicon/core/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  const CustomButton({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.end, children: [
        Text(
          "Skip",
          style: GoogleFonts.acme(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w500, color: kcolor, fontSize: 24)),
        ),
      ]),
    );
  }
}
