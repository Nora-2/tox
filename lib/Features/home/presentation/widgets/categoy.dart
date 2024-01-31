import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/core/constants/constants.dart';

class CustomContainerCtegory extends StatelessWidget {
  const CustomContainerCtegory({
    super.key,
    required this.titel,
    required this.size,
    required this.image
  });
  final String titel;
  final Size size;
  final   String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: icolor.withOpacity(0.95),
        shadowColor: Colors.black,
        elevation: 10,
        child: SizedBox(
          width: size.width * .89,
          height: size.height * .17,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  titel,
                  style: GoogleFonts.lakkiReddy(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 24)),
                ),
                Image(
                  image:  AssetImage(
                    image,
                  ),
                  width: size.width * .5,
                  height: size.width * .5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
