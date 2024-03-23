// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:Toxicon/Features/settings/EditProfile/editprofile.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/customprofilecard.dart';
import 'package:Toxicon/core/config/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/arrowpop.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/constants/image_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  static String id = 'ProfileScreen';
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

 final Stream<QuerySnapshot> documentStream = FirebaseFirestore.instance.collection('users')
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return StreamBuilder(stream: documentStream, builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
        return  const  Center( child: CircularProgressIndicator(color:Colors.black),);
          }return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: gradientTop(isDark)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * .03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               arrowpop(isDark: isDark),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>const EditProfileScreen(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      color: isDark ? Colors.white : black,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .009,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: snapshot.data!.docs.isNotEmpty
                        ? snapshot.data!.docs.last['url'] != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.transparent.withOpacity(0),
                                backgroundImage: NetworkImage(snapshot.data!.docs.last['url']))
                            : CircleAvatar(
                                backgroundColor:
                                    Colors.transparent.withOpacity(0),
                                backgroundImage: AssetImage(
                                  ImageConstant.profile,
                                ),
                              )
                        : CircleAvatar(
                            backgroundColor: Colors.transparent.withOpacity(0),
                            backgroundImage: AssetImage(
                              ImageConstant.profile,
                            ),
                          )),
              ),
              Text(
                snapshot.data!.docs.isNotEmpty
                    ? snapshot.data!.docs.last['full_name']
                    : FirebaseAuth.instance.currentUser!.displayName,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'acme',
                    fontSize: 24),
              ),
              Text(snapshot.data!.docs.isNotEmpty ? snapshot.data!.docs.last['company'] : 'Engineer',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'acme',
                      fontSize: 20)),
            ],
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? black : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 9,
                    offset: const Offset(0, -2),
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
                    icon: Icons.person_2,
                    size: size,
                    subtitel: snapshot.data!.docs.isNotEmpty
                        ? snapshot.data!.docs.last['full_name']
                        :FirebaseAuth.instance.currentUser!.displayName ,
                  ),
                  CustomProfileCard(
                    icon: Icons.email,
                    size: size,
                    subtitel: snapshot.data!.docs.isNotEmpty
                        ? snapshot.data!.docs.last['email']
                        : FirebaseAuth.instance.currentUser!.email,
                  ),
                  CustomProfileCard(
                    icon: Icons.phone,
                    size: size,
                    subtitel: snapshot.data!.docs.isNotEmpty ? snapshot.data!.docs.last['phone'] : '010**********',
                  ),
                  CustomProfileCard(
                    icon: Icons.place,
                    size: size,
                    subtitel: snapshot.data!.docs.isNotEmpty ? snapshot.data!.docs.last['country'] : 'Your Country',
                  ),
                  CustomProfileCard(
                    icon: Icons.date_range,
                    size: size,
                    subtitel: snapshot.data!.docs.isNotEmpty ? snapshot.data!.docs.last['birth'] : 'Date Of Birth',
                  ),
                  CustomProfileCard(
                    icon: Icons.work_rounded,
                    size: size,
                    subtitel: snapshot.data!.docs.isNotEmpty ? snapshot.data!.docs.last['company'] : 'Company',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));});
  }
}
