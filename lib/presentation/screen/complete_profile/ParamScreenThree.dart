import 'package:finddy/domain/entities/user_interest/user_interest_model.dart';

class ParamScreenThree {
  final Map<String, String>? location;
  final String? username;
  final String? university;
  final String? phone;
  final String? photo;
  final List<UserInterestModel> userInterest;
  ParamScreenThree(
      {this.location,
      this.username,
      this.university,
      this.phone,
      this.photo,
      required this.userInterest});
}
