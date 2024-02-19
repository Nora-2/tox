import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Toxicon/main.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
static String id = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Stack(
        children: [
         
          
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
            ),
            alignment: Alignment.center,
            child: AnimatedSplashScreen(
              splashIconSize: 400,
              backgroundColor: Colors.transparent,
              pageTransitionType: PageTransitionType.rightToLeft,
              splashTransition: SplashTransition.fadeTransition,
              splash: Image.asset(
                "assets/images/logo.png",
                height: 120,
                width: 120,
              ),
              nextScreen: isViewed == 0 || isViewed == null
                  ? const OnBoardingScreen()
                  : const OnBoardingScreen(),
              animationDuration: const Duration(seconds: 2),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.width * 0.01,
              bottom: MediaQuery.of(context).size.width * 0.7, //
            ),
            alignment: Alignment.bottomCenter,
            child: TextAnimator('TOXIKON',
                initialDelay: const Duration(seconds: 1),
                characterDelay: const Duration(milliseconds: 250),
                incomingEffect: WidgetTransitionEffects.incomingScaleDown(),
                atRestEffect: WidgetRestingEffects.bounce(),
                outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
                style:  const TextStyle(
                      fontFamily: 'sanchez',
                        fontWeight: FontWeight.w900,
                        color: Color(0xffB5A1B7),
                        fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
