import 'package:Toxicon/Features/settings/presentation/view/history.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Toxicon/Features/settings/presentation/view/aboutus.dart';
import 'package:Toxicon/Features/settings/presentation/view/profile.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/custtomcard.dart';
import 'package:Toxicon/core/constants/constants.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          icolor,
          icolor,
          isDark ? icolor : Colors.white,
          kcolor,
          icolor
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * .02,
          ),
          SizedBox(
            height: size.height * .07,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/profile.png',
                          ),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: size.width * .03,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nora Mohamed',
                      style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              // color: Color(0xff0D0D0D),
                              fontSize: 24)),
                    ),
                    Text(
                      'Researcher',
                      style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              // color: Color(0xff0D0D0D),
                              fontSize: 20)),
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width * .22,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProfileScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 30,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .07,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ?const Color(0xff0D0D0D) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 9,
                    offset: const Offset(0, -8),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HistoryScreen(),
                        ),
                      );
                    },
                    child: CustomContainerCard(
                      titel: 'History',
                      icon: Icons.history,
                      size: size,
                      icontralling: Icons.arrow_forward,
                    ),
                  ),
                  CustomContainerCard(
                    titel: 'language',
                    icon: Icons.language,
                    size: size,
                    icontralling: Icons.arrow_forward,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppCubit.get(context).changemode();
                    },
                    child: CustomContainerCard(
                      titel: 'Dark Mode',
                      icon: Icons.dark_mode,
                      size: size,
                      icontralling: Icons.arrow_forward,
                    ),
                  ),
                  CustomContainerCard(
                    titel: 'Help Center',
                    icon: Icons.help,
                    size: size,
                    icontralling: Icons.arrow_forward,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const InfoScreen(),
                        ),
                      );
                    },
                    child: CustomContainerCard(
                      titel: 'About Us',
                      icon: Icons.info,
                      size: size,
                      icontralling: Icons.arrow_forward,
                    ),
                  ),
                  CustomContainerCard(
                    titel: 'Log Out',
                    icon: Icons.logout,
                    size: size,
                    icontralling: Icons.arrow_forward,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
