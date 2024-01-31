import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/core/constants/constants.dart';


class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  const CustomButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
        decoration: BoxDecoration(
           border: Border.all(
      color: Colors.white,
      width: 2.0, // Set the thickness of the border here
    ),
         
            
            borderRadius: BorderRadius.circular(10.0)),
        child:  Row(mainAxisSize: MainAxisSize.min, children: [
          Text(
            "Skip",
            style:  GoogleFonts.lakkiReddy(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: kcolor,
                          fontSize: 20)),
          ),
          
        
        ]),
      ),
    );
  }
}
