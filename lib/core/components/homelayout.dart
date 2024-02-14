
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Toxicon/core/constants/constants.dart';
import 'package:Toxicon/core/cubit_home/homecubit_cubit.dart';
import 'package:Toxicon/core/widgets/custom_bottom_navbar.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);
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
          backgroundColor:isDark?Colors.transparent.withOpacity(0):Colors.white,
                  
            body: HomecubitCubit.get(context)
                .Screens[HomecubitCubit.get(context).indexBottomNavBar],
            bottomNavigationBar: BottomNavyBar(
              backgroundColor:isDark?black:icolor,
              curve: Curves.easeIn,
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
                      'Home',style: GoogleFonts.acme(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                      fontSize: 20)),
                    ),
                    activeColor: isDark?Colors.black:Colors.white,
                    inactiveColor: Colors.white
                    ),
                        BottomNavyBarItem(
                    icon: const Icon(Icons.settings),
                    title:  Text('Settings',style: GoogleFonts.acme(
              textStyle:const  TextStyle(
                  fontWeight: FontWeight.w400,
                    fontSize: 20)),
            ),
                    activeColor: isDark?Colors.black:Colors.white,
                    inactiveColor:Colors.white,
                    ),
              ], shadowColor: isDark?Colors.grey.withOpacity(0.4):icolor,
            )),
        listener: (context, state) {},
      ),
    );
  }
}
