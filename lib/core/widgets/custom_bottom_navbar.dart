// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/material.dart';

class BottomNavyBar extends StatelessWidget {
  BottomNavyBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    required this.shadowColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.blurRadius = 10,
    this.spreadRadius = 3,
    this.borderRadius,
    this.shadowOffset = const Offset(0, -2),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 4),
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);
  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final Color shadowColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final double blurRadius;
  final double spreadRadius;
  final Offset shadowOffset;
  final BorderRadius? borderRadius;
  final EdgeInsets itemPadding;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? black : icolor,
        boxShadow: [
          if (showElevation)
            BoxShadow(
              color: shadowColor,
              blurRadius: blurRadius,
              spreadRadius: spreadRadius,
              offset: shadowOffset,
            ),
        ],
        // borderRadius: BorderRadius.circular(itemCornerRadius),
      ),
      child: SafeArea(
        child: Container(
          color: isDark ? darkcolor : icolor,
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: isDark ? black : icolor,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  itemPadding: itemPadding,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final EdgeInsets itemPadding;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.iconSize,
    required this.isSelected,
    required this.item,
    required this.backgroundColor,
    required this.itemCornerRadius,
    required this.animationDuration,
    required this.itemPadding,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? 130 : 50,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color: isSelected
              ? isDark
                  ? black
                  : Colors.white
              : item.activeColor?.withOpacity(0.01),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color:
                  isSelected ? Colors.white : Colors.transparent.withOpacity(0),
              borderRadius: BorderRadius.circular(10),
            ),
            width: isSelected ? 130 : 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected ? kcolor : item.inactiveColor),
                  child: item.icon,
                ),
                if (isSelected)
                  Expanded(
                    child: Container(
                      padding: itemPadding,
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          color: isSelected ? kcolor : item.inactiveColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        textAlign: item.textAlign,
                        child: item.title,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The [BottomNavyBar.items] definition.
class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor,
    this.textAlign,
    this.inactiveColor,
  });
  final Widget icon;
  final Widget title;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
}
