import 'package:Toxicon/core/components/cubit/app_cubit.dart';
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
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.input,
      readOnly: widget.reedonly,
      cursorColor: icolor,
      decoration: InputDecoration(
        iconColor: icolor,
        hintText: widget.subtitel,
        hintStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        suffixIcon: IconButton(
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
          borderSide: BorderSide(
            color: isDark ? Colors.white :const Color(0xff0D0D0D),
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
