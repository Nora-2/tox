// ignore_for_file: camel_case_types

import 'package:Toxicon/Features/Authantication/signup/view/signup.dart';
import 'package:Toxicon/Features/chat/chatscreen.dart';
import 'package:Toxicon/Features/home/presentation/widgets/categoy.dart';
import 'package:Toxicon/Features/liver/liver.dart';
import 'package:Toxicon/Features/molecule/molecule.dart';
import 'package:Toxicon/Features/mutagenicity/mutagencity.dart';
import 'package:Toxicon/Features/settings/presentation/view/aboutus.dart';
import 'package:Toxicon/Features/settings/presentation/view/history.dart';
import 'package:Toxicon/Features/settings/presentation/view/profile.dart';
import 'package:Toxicon/Features/smilarty/smilarty.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class homewidgetliver extends StatelessWidget {
  const homewidgetliver({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(createRoutehomeliver());
        },
        child: CustomContainerCtegory(
          size: size,
          image: 'assets/images/liverhome.png',
          titel: 'Liver Toxicity',
        ));
  }
}

class homewidgetdna extends StatelessWidget {
  const homewidgetdna({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(createRoutehomedna());
        },
        child: CustomContainerCtegory(
            titel: 'Mutagenicity',
            size: size,
            image: 'assets/images/wepik-export-20240127181104M5Ff.png'));
  }
}

class homewidgetsimilarty extends StatelessWidget {
  const homewidgetsimilarty({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
         Navigator.of(context).push(createRoutehomesmi());
        },
        child: CustomContainerCtegory(
          size: size,
          image: ImageConstant.similartyresult,
          titel: 'Similarity\n  Map',
        ));
  }
}

class homewidgetmol extends StatelessWidget {
  const homewidgetmol({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(createRoutehomemol());
      },
      child: CustomContainerCtegory(
          titel: 'Toxicity\nof molecules',
          size: size,
          image: 'assets/images/molechome.png'),
    );
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
        Navigator.of(context).push(_createRoute());
      },
      child: LottieBuilder.asset(
        'assets/images/1.json',
        width: size.width * .35,
        height: size.width * .4,
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const ChatScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route createRoutehomesmi() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const smilartyScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.linearToEaseOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route createRoutehomedna() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const MutagencityScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.linearToEaseOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route createRoutehomemol() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const MoleculeScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.linearToEaseOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route createRoutehomeliver() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const LiverScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.linearToEaseOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route signin() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignUp(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.bounceIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
Route createRouteprofile() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
         ProfileScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.linearToEaseOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
Route createRouteabout() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const InfoScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}Route createRoutehistory() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const HistoryScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}