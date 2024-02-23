// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'dart:io';

import 'package:Toxicon/Features/settings/presentation/widgets/custom%20textfield.dart';
import 'package:Toxicon/core/Data/Models/user/user.dart';
import 'package:Toxicon/core/Data/Models/user/usermodel.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});
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

  Uint8List? _image;
  File? selectedIMage;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    User user2 = usersList.last;
    String Email = email.text.trim();
    String Name = name.text.trim();
    String Phone = mobile.text.trim();
    String Birth = birth.text.trim();
    String Jop = jop.text.trim();
    String Country = country.text.trim();
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
                      _image != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage: MemoryImage(_image!))
                          : CircleAvatar(
                              backgroundColor:
                                  Colors.transparent.withOpacity(0),
                              backgroundImage: AssetImage(
                                ImageConstant.profile,
                              ),
                            ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: GestureDetector(
                          onTap: () {
                            showImagePickerOption(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.7),
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
              child: Form(
                key: Key,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * .05,
                      ),
                      CustomTextField(
                          controller: name,
                          input: TextInputType.name,
                          icon: Icons.edit,
                          label: const Text('Name'),
                          subtitel: user2.name),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      CustomTextField(
                          controller: email,
                          input: TextInputType.emailAddress,
                          icon: Icons.edit,
                          label: const Text('Email'),
                          subtitel: user2.email),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      CustomTextField(
                          controller: mobile,
                          input: TextInputType.phone,
                          icon: Icons.edit,
                          label: const Text('Mobile'),
                          subtitel: user2.phone!),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      CustomTextField(
                          controller: country,
                          input: TextInputType.text,
                          icon: Icons.edit,
                          label: const Text('Country'),
                          subtitel: user2.country!),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      CustomTextField(
                          controller: birth,
                          input: TextInputType.datetime,
                          icon: Icons.edit,
                          label: const Text('Birth'),
                          subtitel: '12/12/2001'),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      CustomTextField(
                          controller: jop,
                          input: TextInputType.text,
                          icon: Icons.edit,
                          label: const Text('Jop'),
                          subtitel: user2.jop!),
                           SizedBox(
                        height: size.height * .03,
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              user2.name = Name;
                              user2.email = Email;
                              user2.country = Country;
                              user2.jop = Jop;
                              user2.phone = Phone;
                              user2.date = Birth;
                            });
                          },
                          child: save(size: size, isDark: isDark))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue[100],
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

//Gallery
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop(); //close the model sheet
  }

//Camera
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
