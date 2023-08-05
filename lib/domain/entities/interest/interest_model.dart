import 'package:json_annotation/json_annotation.dart';

part 'interest_model.g.dart';

@JsonSerializable()
class InterestModel {
  final String id, name;

  InterestModel(this.id, this.name);

  factory InterestModel.fromJson(Map<String, dynamic> json) =>
      _$InterestModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterestModelToJson(this);
}
