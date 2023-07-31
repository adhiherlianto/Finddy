import 'package:equatable/equatable.dart';

class User extends Equatable {
  final bool isVerified;
  final String email;
  final String? locationId;
  final String? name;
  final String? phone;
  final String? photo;
  final String? university;
  final String? username;

  const User(
      {required this.isVerified,
      required this.email,
      this.locationId,
      this.name,
      this.phone,
      this.photo,
      this.university,
      this.username});

  @override
  List<Object?> get props =>
      [isVerified, email, locationId, name, phone, photo, university, username];
}
