import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_app/Features/settings/presentation/widgets/customprofilecard.dart';
import 'package:sports_app/core/constants/constants.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController jop = TextEditingController();
  TextEditingController country = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [icolor, Colors.white, kcolor, Colors.white, icolor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * .02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
         
              
            ],
          ),
          SizedBox(
            height: size.height * .009,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/profile.png',
                        ),
                        fit: BoxFit.cover)),
              ),
              Text(
                'Nora Mohamed',
                style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 24)),
              ),
              Text(
                'Researcher',
                style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 20)),
              ),
            ],
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomProfileCard(
                      titel: 'Name',
                      size: size,
                      icon: Icons.edit,
                      subtitel: 'Nora Mohamed',
                      controller: name,
                      input: TextInputType.name),
                  CustomProfileCard(
                      titel: 'Email',
                      size: size,
                      icon: Icons.edit,
                      subtitel: 'Nora123@gmail.com',
                      controller: email,
                      input: TextInputType.emailAddress),
                  CustomProfileCard(
                      titel: 'Mobile',
                      size: size,
                      icon: Icons.edit,
                      subtitel: '01026076471',
                      controller: mobile,
                      input: TextInputType.phone),
                  CustomProfileCard(
                      titel: 'country',
                      size: size,
                      icon: Icons.edit,
                      subtitel: 'Egypt',
                      controller: country,
                      input: TextInputType.name),
                  CustomProfileCard(
                      titel: 'data of birth',
                      size: size,
                      icon: Icons.edit,
                      subtitel: '12/12/2001',
                      controller: birth,
                      input: TextInputType.datetime),
                  CustomProfileCard(
                      titel: 'job describtion',
                      size: size,
                      icon: Icons.edit,
                      subtitel: 'Researcher',
                      controller: jop,
                      input: TextInputType.name),
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
