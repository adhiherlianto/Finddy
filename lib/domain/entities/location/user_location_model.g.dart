// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLocationModel _$UserLocationModelFromJson(Map<String, dynamic> json) =>
    UserLocationModel(
      json['id'] as String,
      json['name'] as String,
      json['province'] as String,
    );

Map<String, dynamic> _$UserLocationModelToJson(UserLocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'province': instance.province,
    };
