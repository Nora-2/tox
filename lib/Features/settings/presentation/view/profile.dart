// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:Toxicon/Features/settings/presentation/view/editprofile.dart';
import 'package:Toxicon/core/Data/Models/user/user.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/customprofilecard.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  static String id = 'ProfileScreen';
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                  child: user2.image != null
                      ? CircleAvatar(
                          radius: 100, backgroundImage: MemoryImage(user2.image!))
                      : CircleAvatar(
                          backgroundColor: Colors.transparent.withOpacity(0),
                          backgroundImage: AssetImage(
                            ImageConstant.profile,
                          ),
                        ),
                ),
              ),
              Text(
                user2.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'acme',
                    fontSize: 24),
              ),
              Text(user2.jop!,
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
                    titel: 'Name',
                    size: size,
                    subtitel: user2.name,
                  ),
                  CustomProfileCard(
                    titel: 'Email',
                    size: size,
                    subtitel: user2.email,
                  ),
                  CustomProfileCard(
                    titel: 'Mobile',
                    size: size,
                    subtitel: user2.phone!,
                  ),
                  CustomProfileCard(
                    titel: 'country',
                    size: size,
                    subtitel: user2.country!,
                  ),
                  CustomProfileCard(
                    titel: 'data of birth',
                    size: size,
                    subtitel: '12/12/2001',
                  ),
                  CustomProfileCard(
                    titel: 'job describtion',
                    size: size,
                    subtitel: user2.jop!,
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
