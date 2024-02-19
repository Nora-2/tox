// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/gradientTop.dart';
import 'package:Toxicon/core/utils/image_constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Toxicon/Features/settings/presentation/widgets/customprofilecard.dart';

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
  String _fileName = "";
  Uint8List _imageBytes = Uint8List(0);
void _pickImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );
  if (result != null) {
    setState(() {
      _fileName = result.files.single.name;
      _imageBytes = result.files.single.bytes ?? Uint8List(0);
    });
  }
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
  
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: gradientTop(isDark)
      ),
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
          if (_fileName.isNotEmpty)
         
         
         
             CircleAvatar(backgroundColor: Colors.transparent.withOpacity(0),backgroundImage:MemoryImage(_imageBytes) ,)

             else
             CircleAvatar(backgroundColor: Colors.transparent.withOpacity(0),backgroundImage:AssetImage( ImageConstant.profile,),),
         
        Positioned(
          right: 10,
          bottom: 10,
          child: GestureDetector(
            onTap:  _pickImage,
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
                child: const Icon(Icons.camera_alt_rounded,color: Colors.black,size: 20,)),
          ),
        )
          ],
        ),
      ),
    ),
        
         const Text(
            'Nora Mohamed',
            style:   TextStyle(
                    fontWeight: FontWeight.w400,
                   fontFamily: 'acme',
                    fontSize: 24),
          ),
          const Text(
            'Researcher',
            style:   TextStyle(
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
                spreadRadius:1,
                blurRadius: 9,
                offset: const Offset(0, -2),
              ),
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)),
          ),
          child: SingleChildScrollView(
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
          ),
        ],
      ),
    ));
  }
}
