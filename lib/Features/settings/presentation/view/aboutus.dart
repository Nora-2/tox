import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/constants/constants.dart';
import 'package:Toxicon/core/utils/function/arrowpop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/Customaboutcard.dart';



// ignore: camel_case_types
class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});
  static String id = 'InfoScreen';
  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    final size = MediaQuery.of(context).size; 
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: isDark ? black : Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * .03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, top: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                arrowpop(isDark: isDark),
                const SizedBox(
                  width: 40,
                ),
                const customtext60020(text: 'Information')
              ],
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ), Center(
          child: Image.asset(
        ImageConstant.information,
        width: size.width * .9,
        height: size.height * .25,
      )),
          Expanded(
            child: SizedBox(
              height: size.height * .98,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 18, left: 8, right: 8),
                itemCount:AppMessage.infodata.length,
                itemBuilder: (context, index) {
                  return CustomInfoCard(
        titel: AppMessage.infodata[index]['titel']?? '',
        subtitel:
            AppMessage.infodata[index]['subtitel'] ?? '',
        size: size,
      );
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
