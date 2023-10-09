// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      isVerified: json['isVerified'] as bool,
      email: json['email'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      university: json['university'] as String?,
      username: json['username'] as String?,
      location: json['location'] == null
          ? null
          : UserLocationModel.fromJson(
              json['location'] as Map<String, dynamic>),
      pref: (json['pref'] as List<dynamic>?)
          ?.map((e) => PreferenceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      interest: (json['interest'] as List<dynamic>?)
          ?.map((e) => UserInterestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'isVerified': instance.isVerified,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'photo': instance.photo,
      'university': instance.university,
      'username': instance.username,
      'location': instance.location?.toJson(),
      'pref': instance.pref?.map((e) => e.toJson()).toList(),
      'interest': instance.interest?.map((e) => e.toJson()).toList(),
    };
