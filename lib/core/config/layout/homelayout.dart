
import 'package:Toxicon/Features/home/cubit_home/homecubit_cubit.dart';
import 'package:Toxicon/core/config/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Toxicon/core/utils/custom_bottom_navbar.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});
  static String id = 'HomeLayout';

  @override
  Widget build(BuildContext context) {
  
     final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return BlocProvider(
      create: (context) => HomecubitCubit(),
      child: BlocConsumer<HomecubitCubit, HomecubitState>(
        builder: (context, state) => Scaffold(
          backgroundColor:isDark?darkcolor:icolor,
                  
            body: HomecubitCubit.get(context)
                .Screens[HomecubitCubit.get(context).indexBottomNavBar],
            bottomNavigationBar: BottomNavyBar(
              backgroundColor:isDark?darkcolor:icolor,
              curve: Curves.easeInOutCirc,
              selectedIndex:
                  HomecubitCubit.get(context).indexBottomNavBar,
              showElevation: true,
              onItemSelected: (index) =>
                  HomecubitCubit.get(context).changeIndexBottom(index),
              items: [
          
                    BottomNavyBarItem(
                  
                    icon: const Icon(
                      CupertinoIcons.home,
                    ),
                    title:  Text(
                      'Home',style: TextStyle(
                    fontFamily: 'acme',
                      fontWeight: FontWeight.w400,
                      color: isDark?darkcolor:kcolor,
                      fontSize: 20)
                    ),
                    activeColor: isDark?Colors.black:Colors.white,
                    inactiveColor: Colors.white
                    ),
                        BottomNavyBarItem(
                    icon: const Icon(Icons.settings),
                    title:  Text('Settings',style:
                   TextStyle(
                    fontFamily: 'acme',
                      fontWeight: FontWeight.w400,
                      color:isDark?darkcolor:kcolor,
                      fontSize: 20)
            ),
                    activeColor: isDark?Colors.black:Colors.white,
                    inactiveColor:Colors.white,
                    ),
                          BottomNavyBarItem(
                  
                    icon: const Icon(
                      Icons.file_copy,
                    ),
                    title:  Text(
                      'Converter',style: TextStyle(
                    fontFamily: 'acme',
                      fontWeight: FontWeight.w400,
                      color: isDark?darkcolor:kcolor,
                      fontSize: 20)
                    ),
                    activeColor: isDark?Colors.black:Colors.white,
                    inactiveColor: Colors.white
                    ),
              ], shadowColor: isDark?Colors.grey.withOpacity(0.4):icolor,
            )),
        listener: (context, state) {},
      ),
    );
  }
}
