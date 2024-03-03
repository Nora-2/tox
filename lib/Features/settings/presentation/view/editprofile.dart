// ignore_for_file: non_constant_identifier_names, avoid_print
import 'dart:io';
import 'package:Toxicon/Features/settings/presentation/widgets/custom%20textfield.dart';
import 'package:Toxicon/core/components/cachhelper.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/buttons.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:Toxicon/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String? url;
Future<String?> uploadImageToFirebase() async {
  if (_image == null) {
    print('No image selected.');
    return null;
  }

  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('User not signed in.');
      return null;
    }
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("user_images/${currentUser.uid}/${DateTime.now().toIso8601String()}");
    await storageReference.putFile(selectedIMage!);
    final imageUrl = await storageReference.getDownloadURL();
    setState(() {
      url = imageUrl;
    });

    print('File uploaded successfully. Image URL: $url');
    return imageUrl;
  } on FirebaseException catch (e) {
    print('Error uploading file: $e');
    return null;
  }
}

  Uint8List? _image;
  File? selectedIMage;



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
                     data.isNotEmpty
                    ? data.last['url'] != null
                        ? CircleAvatar(
                          backgroundColor: Colors.transparent.withOpacity(0),
                            radius: 50,
                            backgroundImage: NetworkImage(data.last['url']))
                        : CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent.withOpacity(0),
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
              data.isNotEmpty ? data.last['full_name'] : FirebaseAuth.instance.currentUser!.displayName  ,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'acme',
                    fontSize: 24),
              ),
              Text(data.isNotEmpty ?data.last['company']:'Engineer',
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
                          subtitel: data.isNotEmpty ? data.last['full_name'] : FirebaseAuth.instance.currentUser!.displayName),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      CustomTextField(
                          controller: email,
                          input: TextInputType.emailAddress,
                          icon: Icons.edit,
                          label: const Text('Email'),
                          subtitel: data.isNotEmpty ? data.last['email'] : FirebaseAuth.instance.currentUser!.displayName),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      CustomTextField(
                          controller: mobile,
                          input: TextInputType.phone,
                          icon: Icons.edit,
                          label: const Text('Mobile'),
                          subtitel:data.isNotEmpty ?  data.last['phone'] 
                              : ''
                             ),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      CustomTextField(
                          controller: country,
                          input: TextInputType.text,
                          icon: Icons.edit,
                          label: const Text('Country'),
                          subtitel:data.isNotEmpty ?  data.last['country']
                               :''
                              ),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      CustomTextField(
                          controller: birth,
                          input: TextInputType.datetime,
                          icon: Icons.edit,
                          label: const Text('Birth'),
                          subtitel:data.isNotEmpty ?  data.last['birth']
                              : ''
                              ),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      CustomTextField(
                          controller: jop,
                          input: TextInputType.text,
                          icon: Icons.edit,
                          label: const Text('Jop'),
                          subtitel: data.isNotEmpty ? data.last['company'] 
                              : ''
               ),
                      SizedBox(
                        height: size.height * .03,
                      ),
                 GestureDetector(
  onTap: () async {
    String? uploadedImageUrl = await uploadImageToFirebase();
    if (uploadedImageUrl != null) {
      setState(() {
        url = uploadedImageUrl;
      });
     CacheHelper.addUser(name: name, mobile: mobile, jop: jop, country: country, birth: birth, email: email, url: url);

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
 