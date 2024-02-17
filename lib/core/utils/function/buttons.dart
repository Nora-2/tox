// ignore_for_file: camel_case_types

import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/material.dart';

class customButtonContainer extends StatelessWidget {
  const customButtonContainer({
    super.key,
    required this.size,
    required this.text,
  });

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: size.width * .8,
      decoration: BoxDecoration(
        color: kcolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(text,
            style: const TextStyle(
              fontFamily: 'sanchez',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            )),
      ),
    );
  }
}

class submit extends StatelessWidget {
  const submit({
    super.key,
    required this.size,
    required this.isDark,
  });

  final Size size;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: size.width * .95,
      decoration: BoxDecoration(
        color: isDark ? darkcolor : icolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child:const Center(
        child: Text(
          'Submit',
          style:
                   TextStyle(fontFamily: 'sanchez',fontWeight: FontWeight.w500, fontSize: 22)),
        
      ),
    );
  }
}
