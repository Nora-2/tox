// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sports_app/Features/Authantication/signup/view/signup.dart';
import 'package:sports_app/Features/openeing/custom_button.dart';
import '../../core/constants/constants.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentIndex < 2) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }

      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index % screens.length;
                    });
                  },
                  itemBuilder: (_, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomButton(onTap: () async {
                                        SharedPreferences perfs = await SharedPreferences.getInstance();
                                        await perfs.setInt('onBoard', 1);
                                    
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) =>  SignUp() ));
                                            
                                      }),
                        ),
                         SizedBox(height: MediaQuery.of(context).size.height * 0.003,),
                        
                       Image.asset(
                            screens[index % screens.length].lottieBuilder,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height:MediaQuery.of(context).size.height * 0.7),
             
                        
                        Text(
                          screens[index % screens.length].text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 29.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          screens[index % screens.length].desc,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            const SizedBox(height:12),
            SmoothPageIndicator(
              controller: _pageController,
              count: screens.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 5,
                dotWidth: 5,
                activeDotColor: Colors.black,
                dotColor: Colors.grey,
              ),
            ),
              const SizedBox(height: 10,),
            
          ],
        ),
      ),
    );
  }
}
