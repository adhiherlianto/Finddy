import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finddy/domain/entities/chat/last_message_model.dart';
import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../entities/chat/message_model.dart';

class ChatRepositories {
  static Future<void> sendMessage(String receiverId, String message) async {
    final senderId = FirebaseAuth.instance.currentUser!.uid;
    final senderEmail = FirebaseAuth.instance.currentUser!.email;
    final timestamp = DateTime.now().toString();

    final newMessage = MessageModel(
        senderId: senderId,
        senderEmail: senderEmail!,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
        downloadableUrl: "",
        fileName: "",
        fileType: "");

    List<String> ids = [senderId, receiverId];
    ids.sort();
    String roomId = ids.join("_");
    await FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(roomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  static Future<void> sendFileMessage(
      String receiverId,
      String message,
      String? fileName,
      String? fileType,
      String? orientation,
      String? filePath) async {
    String? downloadableUrl;
    bool? isImage;
    final senderId = FirebaseAuth.instance.currentUser!.uid;
    final senderEmail = FirebaseAuth.instance.currentUser!.email;
    final timestamp = DateTime.now().toString();
    if (fileType != null) {
      isImage = fileType == "jpg" || fileType == "jpeg" || fileType == "png"
          ? true
          : false;
      final nameFile = "chats/$fileName";
      final ref = FirebaseStorage.instance.ref().child(nameFile);
      File file = File(filePath!);
      await ref.putFile(file, SettableMetadata(contentType: fileType));
      downloadableUrl = (await ref.getDownloadURL()).toString();
    }

    final newMessage = MessageModel(
        senderId: senderId,
        senderEmail: senderEmail!,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
        downloadableUrl: downloadableUrl,
        fileName: fileName ?? "",
        fileType: fileType ?? "",
        orientation: isImage == true ? orientation : "");

    List<String> ids = [senderId, receiverId];
    ids.sort();
    String roomId = ids.join("_");
    await FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(roomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String roomId = ids.join("_");

    return FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(roomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  static Future<void> postLastChats(
    UserModel receiver,
    UserModel sender,
    String lastMessage,
    String date,
  ) async {
    final lastMessageSender = LastMessageModel(
        timestamp: date, message: lastMessage, userInfo: sender);
    final lastMessageReceiver = LastMessageModel(
        timestamp: date, message: lastMessage, userInfo: receiver);

    List<String?> ids = [sender.uid, receiver.uid];
    ids.sort();
    String roomId = ids.join("_");

    await FirebaseFirestore.instance
        .collection("last_chats")
        .doc(sender.uid)
        .set({roomId: lastMessageReceiver.toJson()}, SetOptions(merge: true));

    await FirebaseFirestore.instance
        .collection("last_chats")
        .doc(receiver.uid)
        .set({roomId: lastMessageSender.toJson()}, SetOptions(merge: true));
  }

  static Future<List<LastMessageModel>> getLastMessage() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      List<LastMessageModel> lastMessage = [];
      final data = await FirebaseFirestore.instance
          .collection("last_chats")
          .doc(uid)
          .get()
          .then((value) => value.data());
      lastMessage = List.from(
          data?.values.map((e) => LastMessageModel.fromJson(e)) ?? []);
      print(lastMessage.length);
      return lastMessage;
    } catch (e) {
      rethrow;
    }
  }
}
