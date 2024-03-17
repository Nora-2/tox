// ignore_for_file: non_constant_identifier_names, camel_case_types, avoid_print
import 'package:Toxicon/core/config/layout/homelayout.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/constants/image_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/OnboardModel/onboard_model.dart';
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

static List<Map<String, String>> infodata = [
  {
    'titel': 'How can users utilize the program to research drug toxicity ?',
    'subtitel':
        'Users can input drug information via SMILES or images to investigate its toxicity'
 
  },
   {
    'titel':
            'How are the toxicity results presented to users, and what specific information do they receive ?',
        
        'subtitel':
            'Results are displayed, indicating whether the drug is toxic or non-toxic, along with SA Score and Tox Score.',
  }, {
    'titel':
            'How does the program handle the Mutagenicity analysis, and what are the expected results?',
        'subtitel':
            'The Mutagenicity analysis processes SMILES input and provides information on whether the substance is mutagenic or not.',
     
  }, {
    'titel':
            'How can the user check if the drug induces liver injury (DILI) ,and what are the expected results?',
        'subtitel':
            'Users can input SMILES to check its ability to induce liver injury, and the program outputs either positive or negative results',
     
  }, {
     'titel':
            "What is the significance and usage of SA Score and Tox Score in the program's results?",
        'subtitel':
            "SA Score and Tox Score provide insights into the drug's safety ,helping users interpret drug potential toxicity and its probability to be synthesized",
    
  }, {
      'titel':
            "Is Toxikon available to the general public, or is it targeted towards a specific group of researchers or specialists?",
        'subtitel':
            "Toxikon is accessible to both the general public and specific groups of researchers or specialists.",
     
  }
  , {
      'titel':
            "What technologies or methods does Toxikon use in drug toxicity research?",
        'subtitel':
            "Toxikon employs advanced technologies and methods for comprehensive drug toxicity research.",
    
  }
];
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

// ignore: must_be_immutable
class socialmedia extends StatelessWidget {
  // final GoogleSignIn googleSignIn = new GoogleSignIn();

 
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
    
      rethrow;
    }
  }
 const socialmedia({
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
