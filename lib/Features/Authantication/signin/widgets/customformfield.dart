
import 'package:flutter/material.dart';
import 'package:Toxicon/core/constants/constants.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    required this.hint,
    required this.preicon,
    this.text,
    this.sign,
    this.massege,
    this.suffix,
    required this.controller,
    super.key,
  });
  final String hint;
  final Widget preicon;
  final TextInputType? text;
  final String? sign;
  final String? massege;
  final Widget? suffix;
  final TextEditingController? controller;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      
      child: TextFormField(
        maxLines: 1,
        
        controller: widget.controller,
        decoration: InputDecoration(
          
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          prefixIcon: widget.preicon,
          suffixIcon: widget.suffix,
          enabledBorder: OutlineInputBorder(
          
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey)),
          border: OutlineInputBorder(
            
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              // color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color:  kcolor,
            ),
          ),
        ),
        keyboardType: widget.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
