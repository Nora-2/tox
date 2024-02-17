// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:Toxicon/Features/Authantication/checker.dart';
import 'package:Toxicon/Features/Authantication/signin/login_cubit/login_cubit.dart';
import 'package:Toxicon/Features/Authantication/signup/registercubit/register_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/constants/constants.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Toxicon/Features/Authantication/signin/view/sign_in_view.dart';
import 'package:Toxicon/Features/Authantication/signin/widgets/customformfield.dart';
import 'package:Toxicon/core/components/homelayout.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  SignUp({super.key});
static String id = 'SignUp';
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
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
                                    size: 19,
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
                                  ispass: RegisterCubit.get(context).ispassword,
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
                                          RegisterCubit.get(context)
                                              .changepass();
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
                    Center(
                      child: GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeLayout(),
                                ),
                              );
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
            );
          },
        ));
  }
}
