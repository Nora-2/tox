// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:Toxicon/core/constants/constants.dart';
// class CustomBottomNavBar extends StatefulWidget {
//   const CustomBottomNavBar({
//     super.key,
//   });

//   @override
//   State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//      final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
// bool isDark = brightnessValue == Brightness.dark;
//     return BlocConsumer<HomecubitCubit, HomecubitState>(
//       builder: (context, state) => Container(
//         decoration: const BoxDecoration(
//           color:icolor,
          
//           boxShadow:  [
//             BoxShadow(
//               color: Colors.grey,
//               spreadRadius: 1,
//               blurRadius: 10,
//               offset: Offset(0, 5),
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           currentIndex: HomecubitCubit.get(context).indexBottomNavBar,
//           showUnselectedLabels: true,
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor:kcolor,
//           unselectedItemColor: Colors.grey,
//           unselectedLabelStyle:
//               const TextStyle(color: Colors.grey, fontSize: 10),
//           selectedLabelStyle:
//                TextStyle(
//               color:  isDark?Color(0xff0D0D0D):Color.fromARGB(179, 204, 122, 0),
//                fontSize: 12),
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'setting',
//             ),
//           ],
//           onTap: (value) {
//             HomecubitCubit.get(context).changeIndexBottom(value);
//           },
//         ),
//       ),
//       listener: (BuildContext context, HomecubitState state) {},
//     );
//   }
// }

class BottomNavyBar extends StatelessWidget {
  BottomNavyBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.shadowColor = icolor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.blurRadius = 10,
    this.spreadRadius = 3,
    this.borderRadius,
    this.shadowOffset = Offset.zero,
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
        color: icolor,
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
          color:isDark?const Color(0xff0D0D0D):icolor ,
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
                  backgroundColor:isDark?const Color(0xff0D0D0D):icolor,
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
     final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
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
          color: 
              isSelected ? isDark?const Color(0xff0D0D0D):Colors.white: item.activeColor?.withOpacity(0.01),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
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
                    color: isSelected
                        ? isDark?const Color(0xff0D0D0D):kcolor
                        : item.inactiveColor
                  ),
                  child: item.icon,
                ),
                if (isSelected)
                  Expanded(
                    child: Container(
                      padding: itemPadding,
                      child: DefaultTextStyle.merge(
                        style: TextStyle(

                          color: isDark?const Color(0xff0D0D0D):kcolor,
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
    this.activeColor ,
    this.textAlign,
    this.inactiveColor,
  });
 final Widget icon;
 final Widget title;
 final Color ?activeColor;
 final Color? inactiveColor;
 final TextAlign? textAlign;
}
