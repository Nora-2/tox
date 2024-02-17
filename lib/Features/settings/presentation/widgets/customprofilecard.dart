import 'package:Toxicon/Features/settings/presentation/widgets/custom%20textfield.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomProfileCard extends StatelessWidget {
  CustomProfileCard({
    super.key,
    required this.titel,
    required this.size,
    required this.icon,
    required this.subtitel,
    required this.controller,
    required this.input,
  });
  final String titel;
  final Size size;
  final IconData icon;
  final String subtitel;
  TextEditingController controller;
  TextInputType input;
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
        shadowColor: isDark ? Colors.grey :  black,
        elevation: 10,
        child: SizedBox(
          width: size.width * .95,
          height: size.height * .095,
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8, top: 1, bottom: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: Text(
                      titel,
                      style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'acme',
                              fontSize: 16),
                    ),
                  ),
                  CustomTextField(
                      controller: controller,
                      input: input,
                      icon: icon,
                      subtitel: subtitel)
                ],
              )),
        ),
      ),
    );
  }
}
