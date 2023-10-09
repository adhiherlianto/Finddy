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

import 'package:finddy/domain/entities/location/user_location_model.dart';
import 'package:finddy/domain/entities/preference/preference_model.dart';
import 'package:finddy/domain/entities/user_interest/user_interest_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final bool? isVerified;
  final String? email;
  final String? name;
  final String? phone;
  final String? photo;
  final String? university;
  final String? username;
  final UserLocationModel? location;
  final List<PreferenceModel>? pref;
  final List<UserInterestModel>? interest;

  const UserModel(
      {this.isVerified,
      this.email,
      this.name,
      this.phone,
      this.photo,
      this.university,
      this.username,
      this.location,
      this.pref,
      this.interest});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
