// ignore_for_file: dead_code

import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/utils/function/arrowpop.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/historyCard.dart';

// ignore: camel_case_types
class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  static String id = 'HistoryScreen';
  final Stream<QuerySnapshot> historyStream = FirebaseFirestore.instance
      .collection('history')
      .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradientTop(isDark)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  arrowpop(isDark: isDark),
                  const SizedBox(
                    width: 40,
                  ),
                  const customtext60020(text: 'History'),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .01,
            ),
            StreamBuilder(
                stream: historyStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }
                  bool submit = snapshot.data!.docs.isNotEmpty ? true : false;

                  return Expanded(
                    child: SizedBox(
                        height: size.height * .98,
                        child: submit
                            ? ListView.builder(
                                padding: const EdgeInsets.only(
                                    top: 18, left: 8, right: 8),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return CustomHistoryCard(
                                    input: snapshot.data!.docs[index]['input'],
                                    output: snapshot.data!.docs[index]
                                        ['result'],
                                    date: snapshot.data!.docs[index]['date'],
                                    category: snapshot.data!.docs[index]
                                        ['category'],
                                    size: size,
                                  );
                                },
                              )
                            : Center(
                                child: Image.asset(
                                ImageConstant.history,
                                width: size.width * .9,
                                height: size.height * .8,
                              ))),
                  );
                })
          ],
        ),
      ),
    );
  }
}
