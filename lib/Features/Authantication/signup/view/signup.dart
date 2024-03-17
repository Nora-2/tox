// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:Toxicon/core/utils/checker.dart';
import 'package:Toxicon/Features/Authantication/signin/login_cubit/login_cubit.dart';
import 'package:Toxicon/Features/Authantication/signup/registercubit/register_cubit.dart';
import 'package:Toxicon/core/config/helper/cachhelper.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/constants/constants.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/function/custom_snack_bar.dart';
import 'package:Toxicon/core/constants/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Toxicon/Features/Authantication/signin/view/sign_in_view.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';
import 'package:Toxicon/core/config/layout/homelayout.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  SignUp({super.key});
  static String id = 'SignUp';
  @override
  State<SignUp> createState() => _SignUpState();
}

final formKey = GlobalKey<FormState>();

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  String? Email, Password, name;

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is Registerloading) {
            } else if (state is Registersucsess) {
              FirebaseAuth.instance.currentUser != null &&
                      FirebaseAuth.instance.currentUser!.emailVerified
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeLayout(),
                      ),
                      (route) => false)
                  : Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>  SignIn(),
                      ),
                      (route) => false);
                      // CacheHelper.getdataHistory() ?? '';
                   CacheHelper.getdata() ?? '';
            } else if (state is Registerfailure) {
              customSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * .07,
                      ),
                      Center(
                          child: Image.asset(
                        ImageConstant.signup,
                        width: 270,
                        height: 170,
                      )),
                      SizedBox(
                        height: size.height * .001,
                      ),
                      CustomTextfont24_900(text: 'Sign Up'),
                      SizedBox(
                        height: size.height * .003,
                      ),
                      Form(
                        key: formKey,
                        child: Card(
                          shadowColor: isDark ? Colors.white : black,
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextfont16_500(text: 'UserName'),
                                SizedBox(
                                  height: size.height * .015,
                                ),
                                CustomFormField(
                                    onChanged: (data) {
                                      name = data;
                                    },
                                    ispass: false,
                                    val: (name) {
                                      if (name == null ||
                                          name.isEmpty ||
                                          !Checker.checkName(name)) {
                                        return 'Invalid Name';
                                      }
                                      return null;
                                    },
                                    hint: 'Enter your Name',
                                    preicon: const Icon(
                                      Icons.person,
                                      size: 24,
                                      color: kcolor,
                                    ),
                                    controller: username),
                                SizedBox(
                                  height: size.height * .02,
                                ),
                                CustomTextfont16_500(
                                  text: 'Email',
                                ),
                                SizedBox(
                                  height: size.height * .015,
                                ),
                                CustomFormField(
                                    onChanged: (data) {
                                      Email = data;
                                    },
                                    ispass: false,
                                    hint: 'Enter your Email',
                                    preicon: const Icon(
                                      Icons.email,
                                      size: 20,
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
                                  height: size.height * .02,
                                ),
                                CustomTextfont16_500(
                                  text: 'Password',
                                ),
                                SizedBox(
                                  height: size.height * .015,
                                ),
                                CustomFormField(
                                    onChanged: (data) {
                                      Password = data;
                                    },
                                    hint: 'Enter password',
                                    ispass:
                                        RegisterCubit.get(context).ispassword,
                                    preicon: const Icon(
                                      Icons.lock,
                                      size: 20,
                                      color: kcolor,
                                    ),
                                    val: (pass) {
                                      if (pass == null || pass.isEmpty) {
                                        return 'Invalid Password';
                                      }
                                      return null;
                                    },
                                    suffix: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            RegisterCubit.get(context)
                                                .changepass();
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      Center(
                        child: GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(context)
                                    .registerUser(
                                        email: Email!,
                                        password: Password!,
                                        displayName: name!);
                              } else {}
                            },
                            child: customButtonContainer(
                                size: size, text: 'Sign Up')),
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      seprator(size: size),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      socialmedia(size: size),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const customtext50014(
                            text: "Already have an account?",
                          ),
                          SizedBox(
                            width: size.width * .009,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SignIn(),
                                  ),
                                );
                              },
                              child: CustomTextfont12_700(
                                text: 'sign In',
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
