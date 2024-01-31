
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/core/constants/constants.dart';
import 'package:sports_app/core/cubit_home/homecubit_cubit.dart';
import 'package:sports_app/core/widgets/custom_bottom_navbar.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);
  static String id = 'HomeLayout';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomecubitCubit(),
      child: BlocConsumer<HomecubitCubit, HomecubitState>(
        builder: (context, state) => Scaffold(
            backgroundColor: Colors.white,
            body: HomecubitCubit.get(context)
                .Screens[HomecubitCubit.get(context).indexBottomNavBar],
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom:8.0),
              child: ClipRRect(
                borderRadius:const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                   ),
                child: BottomNavyBar(
                  backgroundColor: icolor,
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
                      color: Colors.black,
                      fontSize: 20)),
                        ),
                        activeColor: Colors.white,
                        inactiveColor: Colors.white),
                    BottomNavyBarItem(
                        icon: const Icon(Icons.settings),
                        title:  Text('Settings',style: GoogleFonts.acme(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 20)),
            ),
                        activeColor: Colors.white,
                        inactiveColor: Colors.white),
                  ],
                ),
              ),
            )),
        listener: (context, state) {},
      ),
    );
  }
}
