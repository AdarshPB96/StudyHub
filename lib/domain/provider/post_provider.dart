import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:studyhub/core/constants/api/urls.dart';
import 'package:studyhub/core/firebase/file_url.dart';
import 'package:studyhub/domain/models/upload_post_model.dart';

class PostProvider extends ChangeNotifier {
  List<File> _selectedFiles = [];

  List<File> get selectedFiles => _selectedFiles;

  TextEditingController postTextController = TextEditingController();
  bool _loading = false;
  get loading => _loading;
    List<Post> _posts = [];
  List<Post> get posts => _posts;

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

  Future<void> uploadPost(String userId) async {
       _loading = true;
    notifyListeners();
    final apiUrl = 'http://192.168.1.5:3000/api/post';
    try {
   
      List<String> fileUrls = [];
      for (var file in selectedFiles) {
        String fileUrl = await uploadFileAndGetUrl(file);
        fileUrls.add(fileUrl);
      }
      Map<String, dynamic> requestBody = {
        'text': postTextController.text,
        'user_id': userId,
        'file_links': fileUrls,
      };
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 201) {
        print('Post created successfully');
      } else {
        print('Failed to create post: ${response.body}');
      }
    } catch (e) {
      print('Error uploading post: $e');
    }
       _loading = false;
    notifyListeners();
  }

    Future<List<Post>> getPosts() async {
    final apiUrl = 'http://192.168.1.5:3000/api/getpost';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Post.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
      throw e;
    }
  }

  //   Future<void> fetchPosts() async {
  //   final apiUrl = 'http://192.168.1.5:3000/api/getpost';
  //   try {
  //     final response = await http.get(Uri.parse(apiUrl));
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = json.decode(response.body);
  //       _posts = data.map((item) => Post.fromJson(item)).toList();
  //       notifyListeners();
  //     } else {
  //       throw Exception('Failed to fetch posts');
  //     }
  //   } catch (e) {
  //     print('Error fetching posts: $e');
  //     throw e;
  //   }
  // }
}
