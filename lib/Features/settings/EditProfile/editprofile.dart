// ignore_for_file: non_constant_identifier_names, avoid_print, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, avoid_web_libraries_in_flutter, unused_import
import 'dart:io';
import 'package:Toxicon/Features/settings/EditProfile/cubit/profile_cubit.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/custom%20textfield.dart';
import 'package:Toxicon/core/config/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/constants/image_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;

// flutter run -d chrome --web-renderer=html

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static String id = 'editprofile';
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

final Key = GlobalKey<FormState>();

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController jop = TextEditingController();
  TextEditingController country = TextEditingController();

  final Stream<QuerySnapshot> documentStream = FirebaseFirestore.instance
      .collection('users')
      .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return BlocProvider(
        create: (context) => ProfileCubit(),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            return StreamBuilder(
                stream: documentStream,
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
                  CollectionReference users =
                      FirebaseFirestore.instance.collection('users');

                  Future<void>? addUser() {
                    return users
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set(
                          {
                            'full_name': name.text == ''
                                ? snapshot.data!.docs.isNotEmpty
                                    ? snapshot.data!.docs.last['full_name']
                                    : name.text
                                : name.text,
                            'phone': mobile.text == ''
                                ? snapshot.data!.docs.isNotEmpty
                                    ? snapshot.data!.docs.last['phone']
                                    : mobile.text
                                : mobile.text,
                            'company': jop.text == ''
                                ? snapshot.data!.docs.isNotEmpty
                                    ? snapshot.data!.docs.last['company']
                                    : jop.text
                                : jop.text, // Stokes and Sons
                            'country': country.text == ''
                                ? snapshot.data!.docs.isNotEmpty
                                    ? snapshot.data!.docs.last['country']
                                    : country.text
                                : country.text,
                            'birth': birth.text == ''
                                ? snapshot.data!.docs.isNotEmpty
                                    ? snapshot.data!.docs.last['birth']
                                    : birth.text
                                : birth.text,
                            'email': email.text == ''
                                ? snapshot.data!.docs.isNotEmpty
                                    ? snapshot.data!.docs.last['email']
                                    : FirebaseAuth.instance.currentUser!.email
                                : email.text,
                            'id': FirebaseAuth.instance.currentUser!.uid,
                            'url': ProfileCubit.get(context).url ??
                                (snapshot.data!.docs.isNotEmpty
                                    ? snapshot.data!.docs.last['url']
                                    : ''),
                          },
                          SetOptions(merge: true),
                        )
                        .then((value) => print(
                            "'full_name' & 'age' merged with existing data!"))
                        .catchError(
                            (error) => print("Failed to merge data: $error"));
                  }

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
                          padding: const EdgeInsets.only(left: 4.0, right: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                child: Stack(
                                  fit: StackFit.expand,
                                  clipBehavior: Clip.none,
                                  children: [
                                    snapshot.data!.docs.isNotEmpty
                                        ? snapshot.data!.docs.last['url'] !=
                                                null
                                            ? CircleAvatar(
                                                backgroundColor: Colors
                                                    .transparent
                                                    .withOpacity(0),
                                                radius: 50,
                                                backgroundImage: NetworkImage(
                                                    snapshot.data!.docs
                                                        .last['url']),
                                              )
                                            : CircleAvatar(
                                                radius: 50,
                                                backgroundColor: Colors
                                                    .transparent
                                                    .withOpacity(0),
                                                backgroundImage: AssetImage(
                                                  ImageConstant.profile,
                                                ),
                                              )
                                        : Container(),
                                    Positioned(
                                      right: 10,
                                      bottom: 10,
                                      child: GestureDetector(
                                        onTap: () {
                                          ProfileCubit.get(context)
                                              .showImagePickerOption(context);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  blurRadius: 0.3,
                                                )
                                              ],
                                            ),
                                            height: 30,
                                            width: 30,
                                            child: const Icon(
                                              Icons.camera_alt_rounded,
                                              color: Colors.black,
                                              size: 20,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              snapshot.data!.docs.isNotEmpty
                                  ? snapshot.data!.docs.last['full_name']
                                  : FirebaseAuth
                                      .instance.currentUser!.displayName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'acme',
                                  fontSize: 24),
                            ),
                            Text(
                                snapshot.data!.docs.isNotEmpty
                                    ? snapshot.data!.docs.last['company']
                                    : 'Engineer',
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
                            child: Form(
                              key: Key,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: size.height * .01,
                                    ),
                                    CustomTextField(
                                        controller: name,
                                        input: TextInputType.name,
                                        icon: Icons.edit,
                                        label: const Text('Name'),
                                        subtitel: snapshot.data!.docs.isNotEmpty
                                            ? snapshot
                                                .data!.docs.last['full_name']
                                            : FirebaseAuth.instance.currentUser!
                                                .displayName),
                                    SizedBox(
                                      height: size.height * .03,
                                    ),
                                    CustomTextField(
                                        controller: email,
                                        input: TextInputType.emailAddress,
                                        icon: Icons.edit,
                                        label: const Text('Email'),
                                        subtitel: snapshot.data!.docs.isNotEmpty
                                            ? snapshot.data!.docs.last['email']
                                            : FirebaseAuth.instance.currentUser!
                                                .displayName),
                                    SizedBox(
                                      height: size.height * .03,
                                    ),
                                    CustomTextField(
                                        controller: mobile,
                                        input: TextInputType.phone,
                                        icon: Icons.edit,
                                        label: const Text('Mobile'),
                                        subtitel: snapshot.data!.docs.isNotEmpty
                                            ? snapshot.data!.docs.last['phone']
                                            : ''),
                                    SizedBox(
                                      height: size.height * .03,
                                    ),
                                    CustomTextField(
                                        controller: country,
                                        input: TextInputType.text,
                                        icon: Icons.edit,
                                        label: const Text('Country'),
                                        subtitel: snapshot.data!.docs.isNotEmpty
                                            ? snapshot
                                                .data!.docs.last['country']
                                            : ''),
                                    SizedBox(
                                      height: size.height * .03,
                                    ),
                                    CustomTextField(
                                        controller: birth,
                                        input: TextInputType.datetime,
                                        icon: Icons.edit,
                                        label: const Text('Birth'),
                                        subtitel: snapshot.data!.docs.isNotEmpty
                                            ? snapshot.data!.docs.last['birth']
                                            : ''),
                                    SizedBox(
                                      height: size.height * .03,
                                    ),
                                    CustomTextField(
                                        controller: jop,
                                        input: TextInputType.text,
                                        icon: Icons.edit,
                                        label: const Text('Jop'),
                                        subtitel: snapshot.data!.docs.isNotEmpty
                                            ? snapshot
                                                .data!.docs.last['company']
                                            : ''),
                                    SizedBox(
                                      height: size.height * .03,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        String? uploadedImageUrl =
                                            await ProfileCubit.get(context)
                                                .uploadImageToFirebase();
                                        if (uploadedImageUrl != null) {
                                          // setState(() {
                                          //   url = uploadedImageUrl;
                                          // });
                                          addUser();
                                        }
                                      },
                                      child: save(size: size, isDark: isDark),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
                });
          },
        ));
  }
}
