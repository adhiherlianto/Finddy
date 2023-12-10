// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastMessageModel _$LastMessageModelFromJson(Map<String, dynamic> json) =>
    LastMessageModel(
      timestamp: json['timestamp'] as String,
      message: json['message'] as String,
      userInfo: UserModel.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LastMessageModelToJson(LastMessageModel instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'message': instance.message,
      'userInfo': instance.userInfo.toJson(),
    };
