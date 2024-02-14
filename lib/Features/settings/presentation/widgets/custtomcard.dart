import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Toxicon/core/constants/constants.dart';

class CustomContainerCard extends StatelessWidget {
  const CustomContainerCard(
      {super.key,
      required this.titel,
      required this.size,
      required this.icon,
      this.icontralling});
  final String titel;
  final Size size;
  final IconData icon;
  final IconData? icontralling;
  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: isDark ? darkcolor : icolor.withOpacity(.95),
        shadowColor: isDark ? Colors.grey.withOpacity(.5) :  black,
        elevation: 10,
        child: SizedBox(
          width: size.width * .90,
          height: size.height * .07,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30,
                ),
                Text(
                  titel,
                  style: GoogleFonts.acme(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 24)),
                ),
                Icon(
                  icontralling,
                  size: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
