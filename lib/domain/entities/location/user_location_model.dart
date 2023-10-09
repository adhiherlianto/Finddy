import 'package:json_annotation/json_annotation.dart';

part 'user_location_model.g.dart';

@JsonSerializable()
class UserLocationModel {
  final String id, name, province;

  UserLocationModel(this.id, this.name, this.province);

  factory UserLocationModel.fromJson(Map<String, dynamic> json) =>
      _$UserLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationModelToJson(this);
}
