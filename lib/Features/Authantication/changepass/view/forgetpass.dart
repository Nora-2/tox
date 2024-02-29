// ignore_for_file: unused_local_variable, non_constant_identifier_names
import 'package:Toxicon/Features/Authantication/changepass/view/resetpass.dart';
import 'package:Toxicon/Features/Authantication/checker.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';

final FormKey = GlobalKey<FormState>();

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  static String id = 'ForgetPassword';

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

TextEditingController email = TextEditingController();

class _ForgetPasswordState extends State<ForgetPassword> {
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
          child: Form(
            key: FormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .09,
                ),
                Center(
                    child: Image.asset(
                  ImageConstant.forgetpass,
                  width: 300,
                  height: 300,
                )),
                SizedBox(
                  height: size.height * .15,
                ),
                CustomTextfont24_900(text: 'Forget Password?'),
                SizedBox(
                  height: size.height * .003,
                ),
                const customtext400_12(
                    text:
                        "Don't worry! it occurs.please enter the email address\nlinked with your account"),
                SizedBox(
                  height: size.height * .018,
                ),
                CustomTextfont16_700(
                  text: 'Email',
                ),
                SizedBox(
                  height: size.height * .015,
                ),
                CustomFormField(
                    ispass: false,
                    hint: 'Enter your Email',
                    preicon: const Icon(
                      Icons.email,
                      size: 19,
                      color: kcolor,
                    ),
                    val: (email) {
                      if (email == null ||
                          email.isEmpty ||
                          !Checker.checkEmail(email)) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    controller: email),
                SizedBox(
                  height: size.height * .06,
                ),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        if (FormKey.currentState!.validate()) {
                          FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ResetPassword(),
                            ),
                          );
                        }
                      },
                      child:
                          customButtonContainer(size: size, text: 'Send Code')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
