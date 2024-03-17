// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:typed_data';
import 'package:Toxicon/core/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ImageUploadWidget extends StatefulWidget {
  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}
class _ImageUploadWidgetState extends State<ImageUploadWidget> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child:const Text("Pick Image"),
        ),
       
        if (_fileName.isNotEmpty)
         
             
         
                 Center(child: CircleAvatar(backgroundImage:MemoryImage(_imageBytes) ,))

                 else
                 CircleAvatar(backgroundImage:AssetImage( ImageConstant.profile,),)
         
                         
          
     
       
      ],
    );
  }
}
