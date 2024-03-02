// ignore_for_file: dead_code

import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/utils/function/arrowpop.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:Toxicon/main.dart';
import 'package:flutter/material.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/historyCard.dart';

// ignore: camel_case_types
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
   static String id = 'HistoryScreen';
  @override
  Widget build(BuildContext context) {
    bool submit = History.isNotEmpty ?true:false;
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    final size = MediaQuery.of(context).size;
  
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(gradient: gradientTop(isDark)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .03,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0,top: 11),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      arrowpop(isDark: isDark),
                      const SizedBox(
                        width: 40,
                      ),
                     const customtext60020(text:'History'),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Expanded(
                  child: SizedBox(
                      height: size.height * .98,
                      child: submit
                          ? ListView.builder(
                              padding: const EdgeInsets.only(
                                  top: 18, left: 8, right: 8),
                              itemCount: History.length,
                              itemBuilder: (context, index) {
                                return CustomHistoryCard(
        input: History[index]['input'],
        output: History[index]['result'],
        date: History[index]['date'],
        category: History[index]['category'],
        size: size,
      );
                              },
                            )
                          : Center(
                              child: Image.asset(
                              ImageConstant.history,
                              width: size.width * .9,
                              height: size.height * .8,
                            ))),
                ),
              ],
            )));
  }
}
