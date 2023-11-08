// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      isVerified: json['isVerified'] as bool?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      university: json['university'] as String?,
      username: json['username'] as String?,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      pref: (json['pref'] as List<dynamic>?)
          ?.map((e) => Pref.fromJson(e as Map<String, dynamic>))
          .toList(),
      interest: (json['interest'] as List<dynamic>?)
          ?.map((e) => Interest.fromJson(e as Map<String, dynamic>))
          .toList(),
      interestSkill: (json['interestSkill'] as List<dynamic>?)
          ?.map((e) => e as String)
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
      'interestSkill': instance.interestSkill,
    };

Interest _$InterestFromJson(Map<String, dynamic> json) => Interest(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$InterestToJson(Interest instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      city: json['city'] as String,
      locationId: json['locationId'] as String,
      province: json['province'] as String,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'city': instance.city,
      'locationId': instance.locationId,
      'province': instance.province,
    };

Pref _$PrefFromJson(Map<String, dynamic> json) => Pref(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PrefToJson(Pref instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
