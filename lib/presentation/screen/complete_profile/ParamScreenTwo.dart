import 'dart:io';

class ParamScreenTwo {
  final Map<String, String>? location;
  final String? username;
  final String? university;
  final String? phone;
  final File? photo;

  const ParamScreenTwo(
      {this.location, this.username, this.university, this.phone, this.photo});
}
