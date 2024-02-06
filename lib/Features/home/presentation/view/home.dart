import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:Toxicon/Features/chat/chatscreen.dart';
import 'package:Toxicon/Features/home/presentation/widgets/categoy.dart';
import 'package:Toxicon/Features/liver/liver.dart';
import 'package:Toxicon/Features/molecule/molecule.dart';
import 'package:Toxicon/Features/mutagenicity/mutagencity.dart';
import 'package:Toxicon/core/constants/constants.dart';

// ignore: camel_case_types
class homeScreen extends StatelessWidget {
  
  const homeScreen({super.key});
  @override
  Widget build(BuildContext context) {
     final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
bool isDark = brightnessValue == Brightness.dark;
    final size = MediaQuery.of(context).size;
    List widgets = [
      GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LiverScreen(),
              ),
            );
          },
          child: CustomContainerCtegory(
            size: size,
            image: 'assets/images/liverhome.png',
            titel: 'Liver Toxicity',
          )),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MoleculeScreen(),
            ),
          );
        },
        child: CustomContainerCtegory(
            titel: 'Toxicity\nof molecules',
            size: size,
            image: 'assets/images/molechome.png'),
      ),
      GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MutagencityScreen(),
              ),
            );
          },
          child: CustomContainerCtegory(
              titel: 'Mutagenicity',
              size: size,
              image: 'assets/images/wepik-export-20240127181104M5Ff.png'))
    ];
    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [icolor,icolor, Colors.white, kcolor,  icolor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * .08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi,Nora!',
                      style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              // color: Colors.black,
                              fontSize: 30)),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Text(
                      "Find out your desierd answer ",
                      style: GoogleFonts.philosopher(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              // color: Colors.black,
                              fontSize: 17)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
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
              )
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                 color: isDark?Colors.black:Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 9,
                    offset: const Offset(0, -8),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 18, left: 8, right: 8),
                itemCount: widgets.length,
                itemBuilder: (context, index) {
                  return widgets[index];
                },
              ),
            ),
          )
        ],
      ),
    )));
  }
}
