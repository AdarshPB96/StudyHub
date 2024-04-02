import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  List<File> _selectedFiles = [];

  List<File> get selectedFiles => _selectedFiles;

  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        _selectedFiles = result.paths.map((path) => File(path!)).toList();
        notifyListeners();
      }
    } catch (e) {
      print("Error picking files: $e");
    }
  }

  Future<void> removeFile(index) async {
    _selectedFiles.removeAt(index);
    notifyListeners();
  }
}
