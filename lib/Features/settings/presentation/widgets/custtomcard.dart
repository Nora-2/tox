import 'package:Toxicon/core/config/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/material.dart';


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
        color: isDark ? darkcolor :Colors.white,
        shadowColor: isDark ? Colors.grey.withOpacity(.5) :  const Color(0xfff1f3f4).withOpacity(.48),
        elevation: 10,
        child: SizedBox(
          width: size.width * .95,
          height: size.height * .1,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4,top:5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color:isDark?Colors.white: darkcolor,
                ),
                Text(
                  titel,
                  style:  const TextStyle(
                    fontFamily: 'acme',
                          fontWeight: FontWeight.w400, fontSize: 24)),
                
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
