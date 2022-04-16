// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}

// pickVideo(ImageSource source) async {
//   final file;
//    final _file = await FilePicker.platform.pickFiles(allowMultiple: false);
//   if (_file != null) {
//     // return await _file.readAsBytes();
//     final path = _file.files.single.path;
//     return file = File(path);
//     final fileName = basename(_file!.path)
// }
// }
showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}
