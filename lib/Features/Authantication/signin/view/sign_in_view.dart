// ignore_for_file: camel_case_types, dead_code, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers

import 'package:Toxicon/Features/Authantication/checker.dart';
import 'package:Toxicon/Features/Authantication/signin/login_cubit/login_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Toxicon/Features/Authantication/changepass/view/forgetpass.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';
import 'package:Toxicon/Features/Authantication/signup/view/signup.dart';
import 'package:Toxicon/core/components/homelayout.dart';
import 'package:Toxicon/core/constants/constants.dart';

// ignore: must_be_immutable
class SignIn extends StatefulWidget {
  SignIn({super.key});
static String id = 'SignIn';
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    final size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {},
          builder: (context, state) {
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
                    Form(
                      key: _formKey,
                      child: Card(
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
                                  hint: 'Enter password',
                                  ispass: LoginCubit.get(context).ispassword,
                                  preicon: const Icon(
                                    Icons.lock,
                                    size: 20,
                                    color: kcolor,
                                  ),
                                  val: (pass) {
                                    if (pass == null ||
                                        pass.isEmpty ||
                                        !Checker.checkPassword(pass)) {
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
                                              color: icolor,
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                              size: 20,
                                              color: icolor,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ForgetPassword(),
                                ),
                              );
                            }
                          },
                          child: const customtext50014(
                            text: 'forgot password?',
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
                        
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomeLayout(),
                              ),
                            );
                          } 
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
                          text: "Don't have an account?",
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
                            child: CustomTextfont12_700(
                              text: 'sign up',
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }


}
