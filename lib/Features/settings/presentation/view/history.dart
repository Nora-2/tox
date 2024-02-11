// ignore_for_file: dead_code

import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/historyCard.dart';

// ignore: camel_case_types
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    bool submit = false;
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    final size = MediaQuery.of(context).size;
    List widgets = [
      CustomHistoryCard(
        input: 'CCCC(CCC)C(O)=O',
        output: 'Positive',
        date: '12/1/2024',
        category: 'Liver Toxcity',
        size: size,
      ),
      CustomHistoryCard(
        input: 'CCCC(CCC)C(O)=O',
        output: 'Positive',
        date: '12/1/2024',
        category: 'Liver Toxcity',
        size: size,
      ),
    ];
    return Scaffold(
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                  isDark ?const Color(0xff0D0D0D) :  icolor,
                   isDark ?const Color(0xff0D0D0D) : icolor,
                    isDark ?const Color(0xff0D0D0D) : Colors.white,
                  isDark ?const Color(0xff0D0D0D) :  kcolor,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color:
                                    isDark ? Colors.white :const Color(0xff0D0D0D),
                              )),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            'History',
                            style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    // color: Color(0xff0D0D0D),
                                    fontSize: 20)),
                          ),
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
                                  itemCount: widgets.length,
                                  itemBuilder: (context, index) {
                                    return widgets[index];
                                  },
                                )
                              : Center(
                                  child: Image.asset(
                                  'assets/images/history.png',
                                  width: size.width * .9,
                                  height: size.height * .8,
                                ))),
                    ),
                  ],
                ))));
  }
}
