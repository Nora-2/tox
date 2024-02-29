// ignore_for_file: non_constant_identifier_names, camel_case_types
import 'package:Toxicon/core/components/homelayout.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Data/Models/OnboardModel/onboard_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

List<OnboardModel> screens = <OnboardModel>[
  OnboardModel(
    lottieBuilder: 'assets/images/dna.png',
    text: "Mutagenicity",
    desc: 'You can easily know some molecule\nmay make mutation or not.',
    bg: kBackgroundColor,
  ),
  OnboardModel(
    lottieBuilder: 'assets/images/liver.png',
    text: "Liver toxicity",
    desc: 'You can easily know some molecule\naffects badly on liver or not.',
    bg: kBackgroundColor,
  ),
  OnboardModel(
    lottieBuilder: 'assets/images/chemical.png',
    text: "Toxicity of molecules",
    desc:
        'You can easily know toxicity of a molecule\n using a smile or an image.',
    bg: kBackgroundColor,
  ),
];

class AppMessage {
  AppMessage._();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      customSnackBar(
          {required BuildContext context,
          required String content,
          Color backgroundColor = icolor}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class socialmedia extends StatelessWidget {
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  // Future signInWithFacebook() async {
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken.token);
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
  Future signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Handle any errors that occur during the sign-in process
      print('Error signing in with Google: $e');
      // You can also show a message to the user or navigate to an error page
      // AppMessage.customSnackBar(
      //   context: context,
      //   content: 'An error occurred while signing in with Google. Please try again.',
      // );
      rethrow;
    }
  }

  socialmedia({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // signInWithFacebook();
          },
          child: Image.asset(
            ImageConstant.facebook,
            width: 35,
            height: 35,
          ),
        ),
        SizedBox(
          width: size.width * .09,
        ),
        GestureDetector(
          onTap: () async{
            signInWithGoogle()
                .then((user) => print(user))
                .catchError((e) => print(e));
                AppMessage.customSnackBar(
        context: context,
        content: 'An error occurred while signing in with Google. Please try again.',
      );
            await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomeLayout(),
                ),
                (route) => false);

          },
          child: Image.asset(
            ImageConstant.google,
            width: 35,
            height: 35,
          ),
        ),
        SizedBox(
          width: size.width * .09,
        ),
        Image.asset(
          ImageConstant.twitter,
          width: 35,
          height: 35,
        )
      ],
    );
  }
}

class seprator extends StatelessWidget {
  const seprator({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 1,
          width: size.width * .4,
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
        ),
        const Text('or',
            style: TextStyle(
                fontFamily: 'sanchez',
                fontWeight: FontWeight.w500,
                fontSize: 16)),
        Container(
          height: 1,
          width: size.width * .4,
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
