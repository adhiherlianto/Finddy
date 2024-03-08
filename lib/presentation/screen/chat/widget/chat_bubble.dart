// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
// import 'package:path/path.dart' as p;

class ChatBubble extends StatelessWidget {
  final String? fileUrl;
  final String? fileName;
  final String? fileType;
  final String? orientation;
  final bool haveFile;
  final String message;
  final Color color;
  const ChatBubble(
      {super.key,
      required this.message,
      required this.color,
      required this.haveFile,
      this.fileUrl,
      this.orientation,
      this.fileName,
      this.fileType});

  @override
  Widget build(BuildContext context) {
    String? filePath;
    return Container(
      padding: EdgeInsets.all(haveFile ? 10 : 0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), color: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (haveFile == false) ...[
            GestureDetector(
              onTap: () async {
                Map<Permission, PermissionStatus> status = await [
                  Permission.manageExternalStorage,
                ].request();
                print(Permission.manageExternalStorage.isGranted);

                // print("filePath : $filePath fileType : $fileType");
                if (filePath != null) {
                  print(filePath);
                  OpenFile.open(filePath);
                } else {
                  if (status[Permission.manageExternalStorage]!.isGranted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Downloading $fileName")));
                    Directory? directory =
                        Directory('/storage/emulated/0/Download');
                    if (!await directory.exists()) {
                      directory = await getExternalStorageDirectory();
                    }
                    // final name = p.basenameWithoutExtension(fileName!);
                    // filePath = "${directory!.path}/$name";
                    filePath = "${directory!.path}/$fileName";
                    try {
                      await Dio().download(
                        fileUrl!,
                        filePath,
                        options: Options(
                            responseType: ResponseType.bytes,
                            followRedirects: false,
                            validateStatus: (status) {
                              return status! < 500;
                            }),
                      );
                      OpenFile.open(filePath, type: fileType);
                    } on DioException catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                }
              },
              child:
                  fileType == "jpg" || fileType == "jpeg" || fileType == "png"
                      ? Image.network(
                          fileUrl!,
                          fit: orientation == "horizontal"
                              ? BoxFit.fitHeight
                              : BoxFit.fitWidth,
                          width: orientation == "horizontal" ? 300 : 200,
                          height: orientation == "horizontal" ? 200 : 200,
                        )
                      : Image.asset(
                          "assets/images/img_icon.png",
                          width: 150,
                          height: 200,
                        ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: const TextStyle(fontSize: 16),
            ),
          ] else ...[
            Text(
              message,
              style: const TextStyle(fontSize: 16),
            ),
          ]
        ],
      ),
    );
  }
}
