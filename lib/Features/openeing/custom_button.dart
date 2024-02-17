import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  const CustomButton({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Row(crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.end, children: [
        Text(
          "Skip",
          style:   TextStyle(
                fontFamily: 'acme',
                  fontWeight: FontWeight.w500, color: kcolor, fontSize: 24)),
        
      ]),
    );
  }
}
