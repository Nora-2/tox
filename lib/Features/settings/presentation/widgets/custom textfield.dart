import 'package:flutter/material.dart';
import 'package:Toxicon/core/constants/constants.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      required this.controller,
      required this.input,
      required this.icon,
      this.reedonly = true,
      required this.subtitel});
  TextEditingController controller;

  final IconData icon;
  bool reedonly = true;
  final String subtitel;
  final TextInputType input;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
         final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
bool isDark = brightnessValue == Brightness.dark;
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.input,
      readOnly: widget.reedonly,
      cursorColor: icolor,
      decoration: InputDecoration(
        iconColor: icolor,
        hintText: widget.subtitel,
        hintStyle:  TextStyle(
           color: isDark?Colors.white:Colors.black,
           fontSize: 20),
        suffixIcon: IconButton(
           color: isDark?Colors.white:Colors.black,
            onPressed: () {
              
              setState(() {
                widget.reedonly = false;
                
              });
            },

            icon: Icon(widget.icon)),
        enabledBorder: OutlineInputBorder(
            gapPadding: 2,
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: icolor.withOpacity(0.95),
            )),
        border: OutlineInputBorder(
          gapPadding: 2,
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(
           color: isDark?Colors.white:Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 2,
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: icolor.withOpacity(0.95),
          ),
        ),
      ),
    );
  }
}
