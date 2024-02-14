import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/constants.dart';
import 'package:Toxicon/core/utils/homeutilis.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    final size = MediaQuery.of(context).size;
    List widgets = [
      homewidgetliver(size:size,),
      homewidgetmol(size: size),
      homewidgetdna(size: size)
    ];
    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration: BoxDecoration(gradient: gradientTop(isDark)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customsizebox(
            size: size,
            height: .08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Hi,Nora!',
                      style: Styles.textStyleacme30,
                    ),
                    customsizebox(
                      size: size,
                      height: .01,
                    ),
                    CustomText(
                      text: "Find out your desierd answer ",
                      style: Styles.textStyphilosopher17,
                    ),
                  ],
                ),
              ),
              robot(size: size)
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ?black: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, -2),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 18, left: 8, right: 8),
                itemCount: widgets.length,
                itemBuilder: (context, index) {
                  return widgets[index];
                },
              ),
            ),
          )
        ],
      ),
    )));
  }
}
