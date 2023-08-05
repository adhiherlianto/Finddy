// import 'package:equatable/equatable.dart';

// class UserModel extends Equatable {
//   final bool isVerified;
//   final String email;
//   final String? locationId;
//   final String? name;
//   final String? phone;
//   final String? photo;
//   final String? university;
//   final String? username;

//   const UserModel(
//       {required this.isVerified,
//       required this.email,
//       this.locationId,
//       this.name,
//       this.phone,
//       this.photo,
//       this.university,
//       this.username});

//   @override
//   List<Object?> get props =>
//       [isVerified, email, locationId, name, phone, photo, university, username];
// }

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final bool isVerified;
  final String email;
  final String? locationId;
  final String? name;
  final String? phone;
  final String? photo;
  final String? university;
  final String? username;

  const UserModel(
      {required this.isVerified,
      required this.email,
      this.locationId,
      this.name,
      this.phone,
      this.photo,
      this.university,
      this.username});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
