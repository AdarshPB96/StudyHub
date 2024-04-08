import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';

Future<String> uploadFileAndGetUrl(File file) async {
  try {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('uploads/${DateTime.now().millisecondsSinceEpoch}-${file.path.split('/').last}');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  } catch (e) {
    print('Error uploading file to Firebase Storage: $e');
    throw e;
  }
}
