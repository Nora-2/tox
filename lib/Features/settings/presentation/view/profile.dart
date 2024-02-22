// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/customprofilecard.dart';
import 'package:image_picker/image_picker.dart';
final formKey = GlobalKey<FormState>();
// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  static String id = 'ProfileScreen';
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
  
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(gradient: gradientTop(isDark)),
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * .03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
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
                ? CircleAvatar(radius: 100, backgroundImage: MemoryImage(_image!))
                :  
                          CircleAvatar(
                            backgroundColor: Colors.transparent.withOpacity(0),
                            backgroundImage: AssetImage(
                              ImageConstant.profile,
                            ),
                          ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: GestureDetector(
                            onTap:() {
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
                const Text(
                  'Nora Mohamed',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'acme',
                      fontSize: 24),
                ),
                const Text('Researcher',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'acme',
                        fontSize: 20)),
              ],
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Container(
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
                key:formKey ,
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


