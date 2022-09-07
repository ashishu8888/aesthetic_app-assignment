import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void ShowSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<File?> openCamera() async {
  ImagePicker impicker = ImagePicker();
  var image = await impicker.pickImage(source: ImageSource.camera);
  return File(image!.path);
}

Future<File?> openGallery() async {
  ImagePicker pic = ImagePicker();
  var image = await pic.pickImage(source: ImageSource.gallery);
  return File(image!.path);
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowCompression: true);
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
