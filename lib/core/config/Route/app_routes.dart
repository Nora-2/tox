import 'package:Toxicon/Features/Authantication/changepass/view/forgetpass.dart';
import 'package:Toxicon/Features/Authantication/changepass/view/otp.dart';
import 'package:Toxicon/Features/Authantication/changepass/view/resetpass.dart';
import 'package:Toxicon/Features/Authantication/signin/view/sign_in_view.dart';
import 'package:Toxicon/Features/Authantication/signup/view/signup.dart';
import 'package:Toxicon/Features/chat/chatscreen.dart';
import 'package:Toxicon/Features/home/presentation/view/home.dart';
import 'package:Toxicon/Features/liver/presentation/view/liver.dart';
import 'package:Toxicon/Features/molecule/presentation/view/molecule.dart';
import 'package:Toxicon/Features/mutagenicity/presentation/view/mutagencity.dart';
import 'package:Toxicon/Features/openeing/presentaion/view/onboarding_screen.dart';
import 'package:Toxicon/Features/openeing/presentaion/view/splash_screen.dart';
import 'package:Toxicon/Features/settings/presentation/view/aboutus.dart';
import 'package:Toxicon/Features/settings/EditProfile/editprofile.dart';
import 'package:Toxicon/Features/settings/presentation/view/history.dart';
import 'package:Toxicon/Features/settings/presentation/view/profile.dart';
import 'package:Toxicon/Features/settings/presentation/view/setting.dart';
import 'package:Toxicon/Features/smilarty/presentation/view/smilarty.dart';
import 'package:Toxicon/core/config/layout/homelayout.dart';
import 'package:flutter/material.dart';

bool isAuth = false;

class AppRoutes {
  AppRoutes._();

  static String? get initialRoute {
    if (!isAuth) {
      return SplashScreen.id;
    } else {
      return HomeLayout.id;
    }
  }

  static final routes = {
    HomeLayout.id: (context) => const HomeLayout(),
    SplashScreen.id: (context) => const SplashScreen(),
    SignIn.id: (context) =>  SignIn(),
    SignUp.id: (context) =>  SignUp(),
    EditProfileScreen.id: (context) => const EditProfileScreen(),
    homeScreen.id: (context) => const homeScreen(),
    LiverScreen.id: (context) => const LiverScreen(),
    MoleculeScreen.id:(context)=>const MoleculeScreen(),
    MutagencityScreen.id:(context)=>const MutagencityScreen(),
    OnBoardingScreen.id:(context)=>const OnBoardingScreen(),
    ChatScreen.id: (context) => const ChatScreen(),
    smilartyScreen.id: (context) => const smilartyScreen(),
    ForgetPassword.id:(context)=>const ForgetPassword(),
    OtpVerify.id:(context)=>const OtpVerify(),
    ResetPassword.id:(context)=>const ResetPassword(),
    InfoScreen.id: (context) => const InfoScreen(),
    HistoryScreen.id:(context)=> HistoryScreen(),
    ProfileScreen.id:(context)=> ProfileScreen(),
    SettingScreen.id:(context)=>const SettingScreen(),
    
  };

  static void pushReplaceSignIn(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, SignIn.id, (r) => false);

    // Navigator.pushReplacementNamed(context, SignInScreen.id);
  }

  static void pushReplaceSignUp(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, SignUp.id, (r) => false);

    Navigator.of(context).pushReplacementNamed(SignUp.id);
  }

  static void pushReplaceHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, HomeLayout.id, (r) => false);

  }


}
