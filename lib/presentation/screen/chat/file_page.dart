// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:finddy/presentation/screen/chat/cubit/chat_cubit.dart';
import 'package:finddy/presentation/screen/chat/file_page_params.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';

class FilePage extends StatefulWidget {
  final FilePageParams params;
  const FilePage({super.key, required this.params});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  final TextEditingController _messageController = TextEditingController();
  File? file;
  @override
  void initState() {
    file = File(widget.params.filePath);
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is SendChatLoading) {
              return const CircularProgressIndicator();
            }
            return Column(
              children: [
                Expanded(
                  child: widget.params.fileExtention == "jpg" ||
                          widget.params.fileExtention == "jpeg" ||
                          widget.params.fileExtention == "png"
                      ? Image.file(
                          file!,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/img_icon.png",
                              width: 150,
                              height: 200,
                            ),
                            Text(widget.params.fileName),
                          ],
                        ),
                ),
                _buildMessageInput(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      height: 67,
      decoration: const BoxDecoration(
        color: AppColors.lightWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.neutralBlack20,
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textAlign: TextAlign.center,
              controller: _messageController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(83)),
                  hintText: "Masukan Pesan",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.neutralBlack20,
                  )),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await context.read<ChatCubit>().sendFileMessage(
                    widget.params.receiverUserId,
                    _messageController.text,
                    widget.params.fileName,
                    widget.params.fileExtention,
                    widget.params.orientation,
                    widget.params.filePath,
                  );
              _messageController.clear();
              context.pop();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
              backgroundColor: AppColors.primaryGreen, // <-- Button color
              foregroundColor: AppColors.lightWhite, // <-- Splash color
            ),
            child: const Icon(
              FeatherIcons.send,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
