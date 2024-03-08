import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finddy/domain/repositories/chat/chat_repositories.dart';

import '../../../../domain/entities/chat/last_message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Future<void> sendMessage(String receiverId, String message) async {
    emit(SendChatLoading());
    try {
      await ChatRepositories.sendMessage(receiverId, message);
      print("Pesan Terkirim");
      emit(SendChatSuccess());
    } catch (e) {
      print(e.toString());
      emit(SendChatError(e.toString()));
    }
  }

  Future<void> sendFileMessage(
      String receiverId,
      String message,
      String? fileName,
      String? fileType,
      String? orientation,
      String? filePath) async {
    emit(SendChatLoading());
    try {
      await ChatRepositories.sendFileMessage(
          receiverId, message, fileName, fileType, orientation, filePath);
      print("Pesan Terkirim");
      emit(SendChatSuccess());
    } catch (e) {
      print(e.toString());
      emit(SendChatError(e.toString()));
    }
  }

  Future<void> getLastMessage() async {
    emit(LastChatLoading());
    try {
      final data = await ChatRepositories.getLastMessage();
      emit(LastChatSuccess(data));
    } catch (e) {
      emit(LastChatError(e.toString()));
    }
  }
}
