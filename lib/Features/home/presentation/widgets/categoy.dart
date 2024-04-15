import 'package:Toxicon/core/config/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/material.dart';

class CustomContainerCtegory extends StatelessWidget {
  const CustomContainerCtegory(
      {super.key,
      required this.titel,
      required this.size,
      required this.image});
  final String titel;
  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: isDark ? darkcolor : Colors.white,
        shadowColor: isDark ? Colors.grey.withOpacity(.6) : const Color(0xfff1f3f4).withOpacity(.48),
        elevation: 10,
        child: SizedBox(
          width: size.width * .89,
          height: size.height * .149,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  titel,
                  // lakkiReddy
                  style: const TextStyle(
                        fontFamily:'Poppins Regular',
                          fontWeight: FontWeight.w900,
                          fontSize: 23),
                ),
                Image(
                  image: AssetImage(
                    image,
                  ),
                  width: size.width * .5,
                  height: size.width * .44,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
