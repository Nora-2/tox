import 'package:Toxicon/Features/Authantication/signin/login_cubit/login_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Toxicon/Features/Authantication/signin/view/sign_in_view.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});
  static String id = 'ResetPassword';
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

final formKey = GlobalKey<FormState>();

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    TextEditingController password = TextEditingController();
    TextEditingController confirmpass = TextEditingController();
    final size = MediaQuery.of(context).size;



    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
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
                        const customtext400_12(
                            text:
                                "Your new password shoule be unique from thoes previously used"),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        CustomTextfont16_700(text: 'Password'),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        CustomFormField(
                            hint: 'Enter password',
                            ispass: LoginCubit.get(context).ispassword,
                            preicon: const Icon(
                              Icons.lock,
                              size: 20,
                              color: kcolor,
                            ),
                            val: (passs) {
                              if (passs == null || passs.isEmpty) {
                                return 'Invalid Password';
                              }
                              return null;
                            },
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    LoginCubit.get(context).changepass();
                                  });
                                },
                                icon: LoginCubit.get(context).ispassword
                                    ? const Icon(
                                        Icons.visibility_off,
                                        size: 20,
                                        color: kcolor,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        size: 20,
                                        color: kcolor,
                                      )),
                            controller: password),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        CustomTextfont16_700(
                          text: 'Confirm Password',
                        ),
                        SizedBox(
                          height: size.height * .015,
                        ),
                        CustomFormField(
                            hint: 'Enter Confirmed password',
                            ispass: LoginCubit.get(context).ispassword,
                            preicon: const Icon(
                              Icons.lock,
                              size: 20,
                              color: kcolor,
                            ),
                            val: (pass) {
                              if (pass == null ||
                                  pass.isEmpty ||
                                  (password.text != confirmpass.text)) {
                                return 'Password must match';
                              }
                              return null;
                            },
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    LoginCubit.get(context).changepass();
                                  });
                                },
                                icon: LoginCubit.get(context).ispassword
                                    ? const Icon(
                                        Icons.visibility_off,
                                        size: 20,
                                        color: kcolor,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        size: 20,
                                        color: kcolor,
                                      )),
                            controller: confirmpass),
                        SizedBox(
                          height: size.height * .06,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                               
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SignIn(),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 38,
                              width: size.width * .85,
                              decoration: BoxDecoration(
                                color: kcolor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Text(
                                  'Rest Password',
                                  style: TextStyle(
                                      fontFamily: 'sanchez',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
    // Import necessary packages and Firebase
  }
}
