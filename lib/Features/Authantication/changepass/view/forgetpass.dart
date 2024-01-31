import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Features/Authantication/changepass/view/otp.dart';
import 'package:sports_app/Features/Authantication/signin/widgets/customformfield.dart';
import 'package:sports_app/core/constants/constants.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .09,
            ),
            Center(
                child: Image.asset(
              'assets/images/Forgot password-amico.png',
              width: 300,
              height: 300,
            )),
            SizedBox(
              height: size.height * .15,
            ),
            Text(
              'Forget Password?',
              style: GoogleFonts.sanchez(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 24)),
            ),
            SizedBox(
              height: size.height * .003,
            ),
            Text(
              "Don't worry! it occurs.please enter the email address\nlinked with your account",
              style: GoogleFonts.sanchez(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 12)),
            ),
            SizedBox(
              height: size.height * .018,
            ),
            Text(
              'Email',
              style: GoogleFonts.sanchez(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
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
              height: size.height * .06,
            ),
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 38,
                  width: size.width * .85,
                  decoration: BoxDecoration(
                    color:  kcolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OtpVerify(),
                          ),
                        );
                      },
                      child: Text(
                        'Send Code',
                        style: GoogleFonts.sanchez(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 18)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
