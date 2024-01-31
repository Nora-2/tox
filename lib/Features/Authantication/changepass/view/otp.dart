import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Features/Authantication/changepass/view/resetpass.dart';
import 'package:sports_app/core/constants/constants.dart';

class OtpVerify extends StatelessWidget {
  const OtpVerify({super.key});

  @override
  Widget build(BuildContext context) {
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
              'assets/images/Enter OTP-rafiki.png',
              width: 300,
              height: 300,
            )),
            SizedBox(
              height: size.height * .05,
            ),
            Text(
              'Code Verification',
              style: GoogleFonts.sanchez(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 24)),
            ),
            SizedBox(
              height: size.height * .005,
            ),
            Text(
              "Enter your verification code we just sent on your email address",
              style: GoogleFonts.sanchez(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 12)),
            ),
            SizedBox(
              height: size.height * .04,
            ),
            OtpTextField(
              numberOfFields: 5,
              fieldWidth: 50,
fillColor: Colors.grey.withOpacity(.2),
              borderColor: kcolor,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              enabledBorderColor: kcolor,
              disabledBorderColor: Colors.black,
              focusedBorderColor: icolor,
              showFieldAsBox: true,
              borderRadius: BorderRadius.circular(15),
              onCodeChanged: (String code) {},

              onSubmit: (String verificationCode) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    });
              }, 
            ),
            SizedBox(
              height: size.height * .04,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ResetPassword(),
                    ),
                  );
                },
                child: Container(
                  height: 38,
                  width: size.width * .85,
                  decoration: BoxDecoration(
                    color: kcolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Verify',
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
            SizedBox(
              height: size.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Did't recived code?",
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
                  onTap: () {},
                  child: Text(
                    'Resend',
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
