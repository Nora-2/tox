
// ignore_for_file: camel_case_types

import 'package:Toxicon/Features/chat/chatscreen.dart';
import 'package:Toxicon/Features/home/presentation/widgets/categoy.dart';
import 'package:Toxicon/Features/liver/liver.dart';
import 'package:Toxicon/Features/molecule/molecule.dart';
import 'package:Toxicon/Features/mutagenicity/mutagencity.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class homewidgetliver extends StatelessWidget {
  const homewidgetliver({super.key, required this.size,});

  final Size size;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const LiverScreen() ,
            ),
          );
        },
        child: CustomContainerCtegory(
          size: size,
          image: 'assets/images/liverhome.png',
          titel: 'Liver Toxicity',
        ));
  }
}

class homewidgetdna extends StatelessWidget {
  const homewidgetdna({super.key, required this.size,});

  final Size size;

 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MutagencityScreen() ,
            ),
          );
        },
        child:CustomContainerCtegory(
              titel: 'Mutagenicity',
              size: size,
              image: 'assets/images/wepik-export-20240127181104M5Ff.png') );
  }
}

class homewidgetmol extends StatelessWidget {
  const homewidgetmol({super.key, required this.size,});

  final Size size;

 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MoleculeScreen() ,
            ),
          );
        },
        child:CustomContainerCtegory(
            titel: 'Toxicity\nof molecules',
            size: size,
            image: 'assets/images/molechome.png'), );
  }
}


class robot extends StatelessWidget {
  const robot({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ChatScreen(),
          ),
        );
      },
      child: LottieBuilder.asset(
        'assets/images/Animation - 1706420444089.json',
        width: size.width * .35,
        height: size.width * .4,
      ),
    );
  }
}
