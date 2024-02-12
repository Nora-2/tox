import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Toxicon/Features/Authantication/signin/view/sign_in_view.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';
import 'package:Toxicon/core/constants/constants.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController password = TextEditingController();
    TextEditingController confirmpass = TextEditingController();
    final size = MediaQuery.of(context).size;
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
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
              'assets/images/resetpassword.png',
              width: 300,
              height: 300,
            )),
            SizedBox(
              height: size.height * .03,
            ),
            CustomTextfont24_900(text: 'Creat new password'),
            SizedBox(
              height: size.height * .005,
            ),
            const customtext400_12(text: "Your new password shoule be unique from thoes previously used"),
            SizedBox(
              height: size.height * .02,
            ),
           CustomTextfont16_700(text: 'Password'),
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
            SizedBox(
              height: size.height * .015,
            ),
            CustomTextfont16_700(text: 'Confirm Password',)
            ,
            SizedBox(
              height: size.height * .015,
            ),
            CustomFormField(
                hint: 'Enter Confirmed password',
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
                controller: confirmpass),
            SizedBox(
              height: size.height * .06,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SignIn(),
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
                      'Rest Password',
                      style: GoogleFonts.sanchez(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDark ? black : Colors.white,
                              fontSize: 18)),
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
