import 'package:json_annotation/json_annotation.dart';

part 'user_interest_model.g.dart';

@JsonSerializable()
class UserInterestModel {
  final String id, name, skill;

  UserInterestModel(this.id, this.name, this.skill);

  factory UserInterestModel.fromJson(Map<String, dynamic> json) =>
      _$UserInterestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInterestModelToJson(this);
}
