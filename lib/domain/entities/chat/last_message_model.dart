import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'last_message_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LastMessageModel {
  String timestamp;
  String message;
  UserModel userInfo;

  LastMessageModel({
    required this.timestamp,
    required this.message,
    required this.userInfo,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     "message": message,
  //     "timestamp": timestamp,
  //     "userInfo": user.toJson(),
  //   };
  // }

  factory LastMessageModel.fromJson(Map<String, dynamic> json) =>
      _$LastMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LastMessageModelToJson(this);
}
