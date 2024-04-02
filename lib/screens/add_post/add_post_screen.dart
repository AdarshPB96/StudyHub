// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyhub/core/common/custom_widgets.dart';
import 'package:studyhub/core/constants/global_variables.dart';
import 'package:studyhub/domain/provider/post_provider.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostProvider>(context, listen: false);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Add Post",
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          provider.pickFiles();
                        },
                        icon: Icon(Icons.add)),
                    GlobalVariables.width20,
                    ElevatedButton(onPressed: () {}, child: Text('Post'))
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Type your description",
                  ),
                  maxLines: null,
                ),
                GlobalVariables.height10,
                Consumer<PostProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final file = value.selectedFiles[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                              color: Colors.grey.shade300,
                              width: double.infinity,
                              height: h * 0.4,
                              child: Stack(
                                children: [
                                  if (file != null) ...[
                                    _buildFileWidget(file),
                                    _buildCloseButtonAndName(
                                        file.path.split('/').last, () {
                                      value.removeFile(index);
                                    }),
                                  ],
                                ],
                              )),
                        );
                      },
                      itemCount: value.selectedFiles.length ?? 0,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileWidget(File file) {
    final extension = file.path.split('.').last.toLowerCase();
    if (extension == 'pdf') {
      return const Center(
        child: Icon(Icons.picture_as_pdf, size: 100, color: Colors.red),
      );
    } else if (extension == 'doc' || extension == 'docx') {
      return const Center(
        child: Icon(Icons.insert_drive_file, size: 100, color: Colors.blue),
      );
    } else if (extension == 'mp4' || extension == 'mov' || extension == 'avi') {
      return const Center(
        child: Icon(Icons.videocam, size: 100, color: Colors.green),
      );
    } else {
      return Image.file(
        file,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
  }

  Widget _buildCloseButtonAndName(String fileName, Function onPressed) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              fileName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              onPressed();
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
