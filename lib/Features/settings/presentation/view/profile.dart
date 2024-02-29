// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:Toxicon/Features/settings/presentation/view/editprofile.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/customprofilecard.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  static String id = 'ProfileScreen';
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

List data = [];

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getdata();
    setState(() {});

    super.initState();
  }

  getdata() async {
    QuerySnapshot quarysnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(quarysnapshot.docs);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return Scaffold(
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
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: isDark ? Colors.white : black,
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProfileScreen(),
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
                    child: data.isNotEmpty
                        ? data.last['url'] != null
                            ? CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(data.last['url']))
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
                data.isNotEmpty
                    ? data.last['full_name']
                    : 'Nora Mohamed',
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'acme',
                    fontSize: 24),
              ),
              Text(data.isNotEmpty ? data.last['company'] : 'Engineer',
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
                    subtitel: data.isNotEmpty
                        ? data.last['full_name']
                        : '',
                  ),
                  CustomProfileCard(
                    icon: Icons.email,
                    size: size,
                    subtitel: data.isNotEmpty
                        ? data.last['email']
                        : '',
                  ),
                  CustomProfileCard(
                    icon: Icons.phone,
                    size: size,
                    subtitel: data.isNotEmpty ? data.last['phone'] : '',
                  ),
                  CustomProfileCard(
                    icon: Icons.place,
                    size: size,
                    subtitel: data.isNotEmpty ? data.last['country'] : '',
                  ),
                  CustomProfileCard(
                    icon: Icons.date_range,
                    size: size,
                    subtitel: data.isNotEmpty ? data.last['birth'] : '',
                  ),
                  CustomProfileCard(
                    icon: Icons.work_rounded,
                    size: size,
                    subtitel: data.isNotEmpty ? data.last['company'] : '',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
