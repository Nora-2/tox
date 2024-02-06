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
     final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
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
              'assets/images/login.png',
              width: 250,
              height: 210,
            )),
            SizedBox(
              height: size.height * .001,
            ),
            Text(
              'Sign In',
              style: GoogleFonts.sanchez(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w900,
                      // color: Colors.black,
                      fontSize: 24)),
            ),
            SizedBox(
              height: size.height * .001,
            ),
            Card(
              shadowColor: isDark?Colors.white:Colors.black,
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: GoogleFonts.sanchez(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              // color: Colors.black,
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
                              fontWeight: FontWeight.w700,
                              // color: Colors.black,
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
                  child: Text(
                    'forgot password?',
                    style: GoogleFonts.sanchez(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 14)),
                  ),
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
                child: Container(
                  height: 38,
                  width: size.width * .8,
                  decoration: BoxDecoration(
                    color:  kcolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.sanchez(
                          textStyle:  TextStyle(
                              fontWeight: FontWeight.w500,
                              color:isDark?Colors.white:Colors.black,
                              fontSize: 18)),
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
                          // color: Colors.black,
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
                  "Don't have an account?",
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignUp(),
                      ),
                    );
                  },
                  child: Text(
                    'sign up',
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
