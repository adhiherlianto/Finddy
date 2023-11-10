import 'dart:io';
import 'package:finddy/domain/entities/user_interest/user_interest_model.dart';

class ParamScreenThree {
  final Map<String, String>? location;
  final String? username;
  final String? university;
  final String? phone;
  final File? photo;
  final List<UserInterestModel> userInterest;
  final List<String>? interestSkill;
  ParamScreenThree(
      {this.location,
      this.username,
      this.university,
      this.phone,
      this.photo,
      required this.userInterest,
      this.interestSkill});
}
