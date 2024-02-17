import 'package:Toxicon/Features/settings/presentation/view/history.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:Toxicon/Features/settings/presentation/view/aboutus.dart';
import 'package:Toxicon/Features/settings/presentation/view/profile.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/custtomcard.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
static String id = 'SettingScreen';
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
        gradient: gradientTop(isDark)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          SizedBox(
            height: size.height * .09,
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
                      image:  DecorationImage(
                          image: AssetImage(
                           ImageConstant.profile,
                          ),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: size.width * .03,
                ),
              const  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nora Mohamed',
                      style:   TextStyle(
                            fontFamily: 'acme',
                              fontWeight: FontWeight.w400,
                              fontSize: 24),
                    ),
                    Text(
                      'Researcher',
                      style:   TextStyle(
                            fontFamily: 'acme',
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
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
                color: isDark ?  black : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 9,
                    offset: const Offset(0, -2),
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
                      icon: Icons.brightness_4,
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
