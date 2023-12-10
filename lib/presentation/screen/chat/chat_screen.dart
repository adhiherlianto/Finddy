import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finddy/domain/repositories/chat/chat_repositories.dart';
import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/chat/file_page_params.dart';
import 'package:finddy/presentation/screen/chat/widget/chat_bubble.dart';
import 'package:finddy/presentation/screen/chat/chat_params.dart';
import 'package:finddy/presentation/screen/chat/cubit/chat_cubit.dart';
import 'package:finddy/presentation/screen/widget/finddy_chip.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final ChatParams params;
  const ChatScreen({super.key, required this.params});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? orientation;
  @override
  void initState() {
    super.initState();
  }

  String sort(String senderId, String receiverId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String roomId = ids.join("_");
    return roomId;
  }

  void _selectFile(String receiverUserId) async {
    final result = await FilePicker.platform.pickFiles(allowCompression: true);
    final name = result!.files.first.name;
    final path = result.files.first.path;
    final extention = result.files.first.extension;
    if (extention == "jpg" || extention == "jpeg" || extention == "png") {
      File image = File(path!);
      var decodedImage = await decodeImageFromList(image.readAsBytesSync());
      bool isHorizontalImage = decodedImage.width > decodedImage.height;
      orientation = isHorizontalImage ? "horizontal" : "vertical";
    }

    final FilePageParams params = FilePageParams(
        fileName: name,
        filePath: path!,
        fileExtention: extention!,
        receiverUserId: receiverUserId,
        orientation: orientation ?? "");
    // ignore: use_build_context_synchronously
    context.pushNamed(AppRoutes.nrChatFile, extra: params);
  }

  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ChatRepositories _chatRepositories = ChatRepositories();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightBlue,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(66),
        child: AppBar(
            leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  FeatherIcons.chevronLeft,
                  size: 30,
                  color: AppColors.neutralBlack40,
                )),
            shadowColor: AppColors.neutralBlack20,
            backgroundColor: AppColors.lightWhite,
            centerTitle: true,
            title: Column(
              children: [
                FDText.headersH6(text: widget.params.receiver.name!),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  height: 20,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.params.receiver.interest!.length,
                      itemBuilder: (context, index) => FDChip.normal(
                          color: index == 0
                              ? AppColors.accentSky
                              : index == 1
                                  ? AppColors.accentGrass
                                  : AppColors.accentSunShine,
                          title: widget.params.receiver.interest!.length == 1
                              ? widget.params.receiver.interest![0].name
                              : widget.params.receiver.interest![index].name)),
                )
              ],
            )),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
                  child: _buildMessageList(widget.params.receiver.uid!))),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList(String receiverUserId) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          children:
              snapshot.data!.docs.map((e) => _buildMessageItem(e)).toList(),
        );
      },
      stream:
          _chatRepositories.getMessage(_auth.currentUser!.uid, receiverUserId),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    DateTime date = DateTime.parse(data["timestamp"]);
    String formattedDate = DateFormat('hh:mm').format(date);

    // print("kosong ga : ${data["files"].downloadableUrl}");

    final color = (data["senderId"] == _auth.currentUser!.uid)
        ? const Color(0xffD6EE98)
        : const Color(0xff7E7E7E);
    final alignment = (data["senderId"] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: (data["senderId"] == _auth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data["message"],
            color: color,
            haveFile: data["downloadableUrl"] == "" ? true : false,
            fileUrl: data["downloadableUrl"],
            fileName: data["fileName"],
            fileType: data["fileType"],
            orientation: data["orientation"],
          ),
          const SizedBox(
            height: 5,
          ),
          FDText.bodyP4(text: formattedDate),
          const SizedBox(
            height: 16,
          )
        ],
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
              _selectFile(widget.params.receiver.uid!);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
              backgroundColor: AppColors.primaryGreen, // <-- Button color
              foregroundColor: AppColors.lightWhite, // <-- Splash color
            ),
            child: const Icon(
              FeatherIcons.paperclip,
              size: 25,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_messageController.text != "") {
                ChatRepositories.postLastChats(
                    widget.params.receiver,
                    widget.params.sender,
                    _messageController.text,
                    DateTime.now().toString());
                context.read<ChatCubit>().sendMessage(
                      widget.params.receiver.uid!,
                      _messageController.text,
                    );
                _messageController.clear();
              }
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
