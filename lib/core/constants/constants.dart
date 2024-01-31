import 'package:flutter/material.dart';

import '../Data/Models/OnboardModel/onboard_model.dart';

const kBackgroundColor = Colors.white;
const seccolor = Color(0xffB5A1B7);
const kcolor = Color(0xff6FA9CB);
const icolor = Color.fromARGB(222, 164, 215, 244);

List<OnboardModel> screens = <OnboardModel>[
  OnboardModel(
    lottieBuilder: 'assets/images/dna.png',
    text: "Mutagenicity",
    desc:
        'You can easily know some molecule\nmay make mutation or not.',
         bg: kBackgroundColor,
 
  ),
  OnboardModel(
    lottieBuilder: 'assets/images/liver.png',
    text:
        "Liver toxicity",
    desc:
        'You can easily know some molecule\naffects badly on liver or not.',
    bg: kBackgroundColor,
   
  ),
  OnboardModel(
    lottieBuilder: 'assets/images/chemical.png',
    text: "Toxicity of molecules",
    desc: 'You can easily know toxicity of a molecule\n using a smile or an image.',
    bg: kBackgroundColor,

  ),
];

