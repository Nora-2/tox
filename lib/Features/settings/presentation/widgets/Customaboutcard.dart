// ignore_for_file: file_names

import 'package:Toxicon/core/config/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/material.dart';


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
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: isDark ? darkcolor : Colors.white,
        shadowColor: isDark ? Colors.grey :  const Color(0xfff1f3f4).withOpacity(.48),
        elevation: 10,
        child: SizedBox(
          width: size.width * .90,
          height: size.height * .18,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  titel,
                  style:  const TextStyle(
                          fontWeight: FontWeight.w600,
                        fontFamily: 'acme',
                          fontSize: 18)),
                
                SizedBox(
                  height: size.height * .015,
                ),
                Text(
                  subtitel,
                  style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'acme',
                          fontSize: 16)),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
