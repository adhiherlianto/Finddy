// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      isVerified: json['isVerified'] as bool,
      email: json['email'] as String,
      locationId: json['locationId'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      university: json['university'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'isVerified': instance.isVerified,
      'email': instance.email,
      'locationId': instance.locationId,
      'name': instance.name,
      'phone': instance.phone,
      'photo': instance.photo,
      'university': instance.university,
      'username': instance.username,
    };
