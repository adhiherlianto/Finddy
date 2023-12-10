import 'package:finddy/domain/entities/user/user_model.dart';

class ChatParams {
  final UserModel sender;
  final UserModel receiver;

  ChatParams({required this.sender, required this.receiver});
}
