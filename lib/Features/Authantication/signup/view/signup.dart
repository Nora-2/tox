import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Toxicon/Features/Authantication/signin/view/sign_in_view.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';

import 'package:Toxicon/core/components/homelayout.dart';
import 'package:Toxicon/core/constants/constants.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  SignUp({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Image.asset(
              'assets/images/Sign up-pana.png',
              width: 270,
              height: 170,
            )),
            SizedBox(
              height: size.height * .001,
            ),
            Text(
              'Sign Up',
              style: GoogleFonts.sanchez(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w900,
                      // color: Color(0xff0D0D0D),
                      fontSize: 24)),
            ),
            SizedBox(
              height: size.height * .003,
            ),
            Card(
              shadowColor: isDark ? Colors.white :const Color(0xff0D0D0D),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UserName',
                      style: GoogleFonts.sanchez(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              // color: Color(0xff0D0D0D),
                              fontSize: 16)),
                    ),
                    SizedBox(
                      height: size.height * .015,
                    ),
                    CustomFormField(
                        hint: 'Enter your Name',
                        preicon: const Icon(
                          Icons.person,
                          size: 19,
                          color: kcolor,
                        ),
                        controller: username),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Text(
                      'Email',
                      style: GoogleFonts.sanchez(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              // color: Color(0xff0D0D0D),
                              fontSize: 16)),
                    ),
                    SizedBox(
                      height: size.height * .015,
                    ),
                    CustomFormField(
                        hint: 'Enter your Email',
                        preicon: const Icon(
                          Icons.email,
                          size: 19,
                          color: kcolor,
                        ),
                        controller: email),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Text(
                      'Password',
                      style: GoogleFonts.sanchez(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              // color: Color(0xff0D0D0D),
                              fontSize: 16)),
                    ),
                    SizedBox(
                      height: size.height * .015,
                    ),
                    CustomFormField(
                        hint: 'Enter password',
                        preicon: const Icon(
                          Icons.lock,
                          size: 19,
                          color: kcolor,
                        ),
                        suffix: const Icon(
                          Icons.remove_red_eye,
                          size: 19,
                          color: kcolor,
                        ),
                        controller: email),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeLayout(),
                    ),
                  );
                },
                child: Container(
                  height: 38,
                  width: size.width * .8,
                  decoration: BoxDecoration(
                    color: kcolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.sanchez(
                          textStyle: const TextStyle(
                            color: Colors.white,
                              fontWeight: FontWeight.w500, fontSize: 18)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  width: size.width * .4,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'or',
                  style: GoogleFonts.sanchez(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          // color: Color(0xff0D0D0D),
                          fontSize: 16)),
                ),
                Container(
                  height: 1,
                  width: size.width * .4,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/facebook.png',
                  width: 35,
                  height: 35,
                ),
                SizedBox(
                  width: size.width * .09,
                ),
                Image.asset(
                  'assets/images/google.png',
                  width: 35,
                  height: 35,
                ),
                SizedBox(
                  width: size.width * .09,
                ),
                Image.asset(
                  'assets/images/twitter.png',
                  width: 35,
                  height: 35,
                )
              ],
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: GoogleFonts.sanchez(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 14)),
                ),
                SizedBox(
                  width: size.width * .009,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignIn(),
                      ),
                    );
                  },
                  child: Text(
                    'sign In',
                    style: GoogleFonts.sanchez(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: kcolor,
                            fontSize: 12)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
