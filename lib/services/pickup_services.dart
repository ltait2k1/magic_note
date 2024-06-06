import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_extensions/services/image_picker/image_options.dart';
import 'package:flutter_quill_extensions/services/image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';

Future<String> _uploadFile(File file, String mediaType) async {
  String fileName = file.path
      .split('/')
      .last;
  Reference storageReference = //Tạo đôi tượng Reference để trỏ đến vị trí trong firebase
  FirebaseStorage.instance.ref().child(
      '$mediaType/$fileName'); // storage nơi lưu trữ tệp
  UploadTask uploadTask = storageReference.putFile(file);
  TaskSnapshot taskSnapshot = await uploadTask;
  return await taskSnapshot.ref.getDownloadURL();
}

Future<void> _pickImage(ImageSource source) async {
  late QuillController _contentController;
  final ImagePicker _picker = ImagePicker();
  final XFile? pickedFile = await _picker.pickImage(source: source);
  if (pickedFile != null) {
  String imageUrl = await _uploadFile(File(pickedFile.path), 'image');
  final delta = Delta()..insert({'image': imageUrl});
  setState(() {
  _contentController.document.compose(delta, ChangeSource.local);
  });
  }
}