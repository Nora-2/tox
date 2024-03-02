// ignore_for_file: use_build_context_synchronously

import 'package:Toxicon/Features/Authantication/signup/view/signup.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/homeutilis.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/custtomcard.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  static String id = 'SettingScreen';
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}


class _SettingScreenState extends State<SettingScreen> {
  @override
  // void initState() {
  //   getdata();
  //    setState(() {});

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: gradientTop(isDark)),
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
                data.isNotEmpty
                    ? data.last['url'] != null
                        ? CircleAvatar(
                          backgroundColor: Colors.transparent.withOpacity(0),
                            radius: 50,
                            backgroundImage: NetworkImage(data.last['url']))
                        : CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent.withOpacity(0),
                            backgroundImage: AssetImage(
                              ImageConstant.profile,
                            ),
                          )
                    : CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent.withOpacity(0),
                        backgroundImage: AssetImage(
                          ImageConstant.profile,
                        ),
                      ),
                SizedBox(
                  width: size.width * .03,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * .4,
                      child: Text(
                        data.isNotEmpty
                            ? data.last['full_name']
                            : 'Nora Mohamed',
                        style: const TextStyle(
                            fontFamily: 'acme',
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            fontSize: 22),
                      ),
                    ),
                    Text(
                      data.isNotEmpty ? data.last['company'] : 'Bioinformatics',
                      style: const TextStyle(
                          fontFamily: 'acme',
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width * .14,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(createRouteprofile());
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
                color: isDark ? black : Colors.white,
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
                      Navigator.of(context).push(createRoutehistory());
                    },
                    child: CustomContainerCard(
                      titel: 'History',
                      icon: Icons.history,
                      size: size,
                      icontralling: Icons.arrow_forward,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        AppCubit.get(context).changemode();
                      });
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
                      Navigator.of(context).push(createRouteabout());
                    },
                    child: CustomContainerCard(
                      titel: 'Information',
                      icon: Icons.info,
                      size: size,
                      icontralling: Icons.arrow_forward,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      GoogleSignIn google = GoogleSignIn();
                      google.disconnect();
                      FacebookAuth.instance.logOut();
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignUp(),
                        ),
                      );
                    },
                    child: CustomContainerCard(
                      titel: 'Log Out',
                      icon: Icons.logout,
                      size: size,
                      icontralling: Icons.arrow_forward,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
