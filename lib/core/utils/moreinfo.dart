// ignore_for_file: camel_case_types

import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class showdiloginfo extends StatelessWidget {
  const showdiloginfo({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [icolor, Colors.white, kcolor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 5),
        child: SingleChildScrollView(
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
                          color: isDark ? Colors.white :const Color(0xff0D0D0D),
                        )),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Text(
                '2D Structer',
                style: GoogleFonts.sanchez(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0D0D0D),
                        fontSize: 24)),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Center(
                child: Container(
                  width: 200,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                      'assets/images/wepik-export-20240131050749OHmR.png'),
                ),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Text(
                'Atomic Number',
                style: GoogleFonts.sanchez(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0D0D0D),
                        fontSize: 24)),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Text(
                'Atom Symbol: C ,AtomicNum: 6\nAtom Symbol: C ,AtomicNum: 6\nAtom Symbol: C ,AtomicNum: 6\nAtom Symbol: C ,AtomicNum: 6\nAtom Symbol: C ,AtomicNum: 6\nAtom Symbol: C ,AtomicNum: 6\nAtom Symbol: C ,AtomicNum: 6',
                style: GoogleFonts.sanchez(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff0D0D0D),
                        fontSize: 20)),
              ),
              SizedBox(height: size.height * .02),
              Text(
                'Bond Type',
                style: GoogleFonts.sanchez(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0D0D0D),
                        fontSize: 24)),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Text(
                "Bond between atoms 0 and 1\nBond Type: SINGLE\nBond between atoms 1,and 2\nBond Type: AROMATIC\nBond between atoms 2 and 3\nBond Type: AROMATIC\nBond between atoms 3 and 4\nBond Type: AROMATIC\nBond between atoms 4 and 5\nBond Type: AROMATIC\nBond between atoms 5 and 6\nBond Type: AROMATIC\nBond between atoms 6 and 1 \nBond Type: AROMATIC",
                style: GoogleFonts.sanchez(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff0D0D0D),
                        fontSize: 20)),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Text(
                'Gasteiger charges',
                style: GoogleFonts.sanchez(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0D0D0D),
                        fontSize: 24)),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Text(
                "Atom Index: 0, Symbol: C,\nGasteiger Charge: -0.039774526323627504\nAtom Index: 1, Symbol: C\nGasteiger Charge: -0.05113326481434698\nAtom Index: 2, Symbol: C\nGasteiger Charge: -0.059326411981218706\nAtom Index: 3, Symbol: C\nGasteiger Charge: -0.06200472120721145\nAtom Index: 4, Symbol: C\nGasteiger Charge: -0.06224908578199481\nAtom Index: 5, Symbol: C\nGasteiger Charge: -0.06200472120721145\nAtom Index: 6, Symbol: C\nGasteiger Charge: -0.059326411981218706",
                style: GoogleFonts.sanchez(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff0D0D0D),
                        fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    )));
  }
}
