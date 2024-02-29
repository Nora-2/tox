
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:Toxicon/Features/Authantication/changepass/view/resetpass.dart';

class OtpVerify extends StatelessWidget {
  const OtpVerify({super.key});
  static String id = 'OtpVerify';
// Function to send OTP to email
  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .12,
              ),
              Center(
                  child: Image.asset(
                ImageConstant.otp,
                width: 300,
                height: 300,
              )),
              SizedBox(
                height: size.height * .05,
              ),
              CustomTextfont24_900(text: 'Code Verification'),
              SizedBox(
                height: size.height * .005,
              ),
              const customtext400_12(
                  text:
                      "Enter your verification code we just sent on your email address"),
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
                disabledBorderColor: black,
                focusedBorderColor: isDark ? darkcolor : icolor,
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
                      
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ResetPassword(),
                        ),
                      );
                    },
                    child: customButtonContainer(size: size, text: 'Verify')),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const customtext50014(
                    text: "Did't recived code?",
                  ),
                  SizedBox(
                    width: size.width * .009,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: CustomTextfont12_700(
                        text: 'Resend',
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
