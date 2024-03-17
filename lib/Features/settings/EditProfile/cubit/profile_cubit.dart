import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  Uint8List imageBytes = Uint8List(0);
  Future<void> pickImageFromGallery(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null && result.files.isNotEmpty) {
        imageBytes = result.files.single.bytes ?? Uint8List(0);
        emit(imagegallerysucssess());
      }
      Navigator.pop(context);
    } catch (e) {
      print('Error picking image: $e');
      emit(imagegalleryfailed());
    }
  }

  String? url;
  Future<String?> uploadImageToFirebase() async {
    if (imageBytes.isEmpty) {
      print('No image selected.');
      return null;
    }

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('User not signed in.');
        return null;
      }

      final storageRef = FirebaseStorage.instance.ref().child(
          "user_images/${currentUser.uid}/${DateTime.now().toIso8601String()}.jpg");

      await storageRef.putData(imageBytes);

      final imageUrl = await storageRef.getDownloadURL();
      url = imageUrl;
      emit(uploadsucssess());

      print('File uploaded successfully. Image URL: $imageUrl');
      return imageUrl;
    } catch (e) {
      print('Error uploading file: $e');
      emit(uploadfailed());
      return null;
    }
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
                        pickImageFromGallery(context);
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
                        pickImageFromCamera(context);
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

  File? selectedIMage;
  Future pickImageFromCamera(BuildContext context) async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;

    selectedIMage = File(returnImage.path);
    emit(imagecamerasucssess());

    Navigator.of(context).pop();
  }
}
//    Uint8List? _image;
// //Gallery
//   Future _pickImageFromGallery() async {
//     final returnImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (returnImage == null) return;
//     setState(() {
//       selectedIMage = File(returnImage.path);
//       _image = File(returnImage.path).readAsBytesSync();
//     });
//     Navigator.of(context).pop(); //close the model sheet
//   }
  // Future<String?> uploadImageToFirebase() async {
  //   if (_image == null) {
  //     print('No image selected.');
  //     return null;
  //   }

  //   try {
  //     final currentUser = FirebaseAuth.instance.currentUser;
  //     if (currentUser == null) {
  //       print('User not signed in.');
  //       return null;
  //     }
  //     Reference storageReference = FirebaseStorage.instance.ref().child(
  //         "user_images/${currentUser.uid}/${DateTime.now().toIso8601String()}");
  //     await storageReference.putFile(selectedIMage!);
  //     final imageUrl = await storageReference.getDownloadURL();
  //     setState(() {
  //       url = imageUrl;
  //     });

  //     print('File uploaded successfully. Image URL: $url');
  //     return imageUrl;
  //   } on FirebaseException catch (e) {
  //     print('Error uploading file: $e');
  //     return null;
  //   }
  // }
//Camera