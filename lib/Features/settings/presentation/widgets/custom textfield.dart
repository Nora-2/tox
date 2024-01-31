import 'package:flutter/material.dart';
import 'package:sports_app/core/constants/constants.dart';

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
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.input,
      readOnly: widget.reedonly,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        iconColor: Colors.black,
        hintText: widget.subtitel,
        hintStyle: const TextStyle(color: Colors.black, fontSize: 20),
        suffixIcon: IconButton(
          color: Colors.black,
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
          borderSide: const BorderSide(
            color: Colors.black,
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
