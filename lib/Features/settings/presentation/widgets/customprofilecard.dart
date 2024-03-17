import 'package:Toxicon/core/config/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomProfileCard extends StatefulWidget {
 const CustomProfileCard({
    super.key,
    required this.icon,
    required this.size,
    required this.subtitel,
  });
  final IconData icon;
  final Size size;

  final String subtitel;

  @override
  State<CustomProfileCard> createState() => _CustomProfileCardState();
}

class _CustomProfileCardState extends State<CustomProfileCard> {
  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: isDark ? darkcolor : icolor.withOpacity(.95),
        shadowColor: isDark ? Colors.grey : black,
        elevation: 10,
        child: SizedBox(
          width: widget.size.width * .95,
          height: widget.size.height * .09,
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 8, top: 1, bottom: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 2), child: Icon(widget.icon,size: 25,)),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 4),
                    child: Text(
                      widget.subtitel,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'acme',
                          fontSize: 18),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
