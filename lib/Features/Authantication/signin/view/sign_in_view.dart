// ignore_for_file: camel_case_types

import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Toxicon/Features/Authantication/changepass/view/forgetpass.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';
import 'package:Toxicon/Features/Authantication/signup/view/signup.dart';
import 'package:Toxicon/core/components/homelayout.dart';
import 'package:Toxicon/core/constants/constants.dart';

// ignore: must_be_immutable
class SignIn extends StatelessWidget {
  SignIn({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
              ImageConstant.signin,
              width: 250,
              height: 210,
            )),
            SizedBox(
              height: size.height * .001,
            ),
            CustomTextfont24_900(
              text: 'Sign In',
            ),
            SizedBox(
              height: size.height * .001,
            ),
            Card(
              shadowColor: isDark ? Colors.white : black,
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextfont16_500(
                      text: 'Email',
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
                    CustomTextfont16_500(
                      text: 'Password',
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
                        controller: password),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForgetPassword(),
                      ),
                    );
                  },
                  child:const customtext50014(text:  'forgot password?',),
                ),
              ],
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
                child: customButtonContainer(
                  size: size,
                  text: 'Sign In',
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
                          fontWeight: FontWeight.w500, fontSize: 16)),
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
                  ImageConstant.facebook,
                  width: 35,
                  height: 35,
                ),
                SizedBox(
                  width: size.width * .09,
                ),
                Image.asset(
                  ImageConstant.google,
                  width: 35,
                  height: 35,
                ),
                SizedBox(
                  width: size.width * .09,
                ),
                Image.asset(
                  ImageConstant.twitter,
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
              const customtext50014(text: "Don't have an account?",),
                SizedBox(
                  width: size.width * .009,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignUp(),
                        ),
                      );
                    },
                    child: CustomTextfont12_700(
                      text: 'sign up',
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class customtext50014 extends StatelessWidget {
  const customtext50014({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
     text,
      style: GoogleFonts.sanchez(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 14)),
    );
  }
}
