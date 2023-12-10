part of 'chat_cubit.dart';

abstract class ChatState {
  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {
  bool? loading = false;
  ChatLoading(this.loading);
}

class ChatSuccess extends ChatState {
  Stream<QuerySnapshot> data;

  ChatSuccess(this.data);
  @override
  List<Object> get props => [data];
}

class ChatError extends ChatState {
  final String error;
  ChatError(this.error);

  @override
  List<Object> get props => [error];
}

class SendChatLoading extends ChatState {}

class SendChatSuccess extends ChatState {}

class SendChatError extends ChatState {
  final String error;
  SendChatError(this.error);

  @override
  List<Object> get props => [error];
}

class LastChatLoading extends ChatState {}

class LastChatSuccess extends ChatState {
  List<LastMessageModel> data;

  LastChatSuccess(this.data);
  @override
  List<Object> get props => [data];
}

class LastChatError extends ChatState {
  final String error;
  LastChatError(this.error);

  @override
  List<Object> get props => [error];
}
