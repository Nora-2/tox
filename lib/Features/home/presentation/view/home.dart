import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/homeutilis.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});
  static String id = 'homeScreen';

  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    final size = MediaQuery.of(context).size;
    List widgets = [
      homewidgetliver(
        size: size,
      ),
      homewidgetmol(size: size),
      homewidgetdna(size: size),
      homewidgetsimilarty(
        size: size,
      )
    ];
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not signed in. Show a login screen or a message to the user.
      return const Scaffold(
        body: Center(
          child: Text('Please sign in to continue.'),
        ),
      );
    }
    final Stream<QuerySnapshot> documentStream = FirebaseFirestore.instance
        .collection('users')
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: gradientTop(isDark)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customsizebox(
            size: size,
            height: .08,
          ),
          StreamBuilder(
              stream: documentStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text:
                                'Hi,${snapshot.data!.docs.isNotEmpty ? snapshot.data!.docs.last['full_name'] : FirebaseAuth.instance.currentUser!.displayName}!',
                            style: Styles.textStyleacme30,
                          ),
                          customsizebox(
                            size: size,
                            height: .01,
                          ),
                          CustomText(
                            text: "Find out your desierd answer ",
                            style: Styles.textStyphilosopher17,
                          ),
                        ],
                      ),
                    ),
                    robot(size: size)
                  ],
                );
              }),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? black : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, -2),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: ListView.builder(
                padding:
                    const EdgeInsets.only(top: 3, left: 8, right: 8, bottom: 3),
                itemCount: widgets.length,
                itemBuilder: (context, index) {
                  return widgets[index];
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}
