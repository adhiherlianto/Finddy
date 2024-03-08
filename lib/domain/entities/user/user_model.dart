import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final String? uid;
  final bool? isVerified;
  final String? email;
  final String? name;
  final String? phone;
  final String? photo;
  final String? university;
  final String? username;
  final Location? location;
  final List<Pref>? pref;
  final List<Interest>? interest;
  final List<String>? interestSkill;
  final List<String>? friends;
  final List<String>? friendRequests;

  const UserModel(
      {this.uid,
      this.isVerified,
      this.email,
      this.name,
      this.phone,
      this.photo,
      this.university,
      this.username,
      this.location,
      this.pref,
      this.interest,
      this.interestSkill,
      this.friends,
      this.friendRequests});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Interest {
  String id;
  String name;

  Interest({
    required this.id,
    required this.name,
  });

  factory Interest.fromJson(Map<String, dynamic> json) =>
      _$InterestFromJson(json);

  Map<String, dynamic> toJson() => _$InterestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Location {
  String city;
  String locationId;
  String province;

  Location({
    required this.city,
    required this.locationId,
    required this.province,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Pref {
  String id;
  String name;

  Pref({
    required this.id,
    required this.name,
  });

  factory Pref.fromJson(Map<String, dynamic> json) => _$PrefFromJson(json);

  Map<String, dynamic> toJson() => _$PrefToJson(this);
}
