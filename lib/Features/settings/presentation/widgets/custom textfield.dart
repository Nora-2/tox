// ignore_for_file: file_names

import 'package:Toxicon/core/config/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      required this.controller,
      required this.input,
      required this.icon,
      required this.label,
    
      required this.subtitel});
  TextEditingController controller;
  final IconData icon;
  final String subtitel;
  final TextInputType input;
  final Text label;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.input,
        
        cursorColor: Colors.white,
        decoration: InputDecoration(
          label: widget.label,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: TextStyle(color: isDark ? darkcolor : icolor,fontSize: 19 ),
    
          iconColor: isDark ? darkcolor : icolor,
          hintText: widget.subtitel,
          hintStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          suffixIcon: IconButton(
              color: isDark ? Colors.white : black,
              onPressed: () {
               
              },
              icon: Icon(widget.icon)),
          disabledBorder: OutlineInputBorder(
              gapPadding: 2,
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isDark ? icolor : icolor.withOpacity(.95),
              )),
          enabledBorder: OutlineInputBorder(
              gapPadding: 2,
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isDark ? icolor : icolor.withOpacity(.95),
              )),
          border: OutlineInputBorder(
            gapPadding: 2,
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: isDark ? icolor :  black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 2,
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: isDark ? icolor: icolor.withOpacity(.95),
            ),
          ),
        ),
      ),
    );
  }
}
