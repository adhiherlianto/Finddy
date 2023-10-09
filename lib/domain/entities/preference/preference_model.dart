import 'package:json_annotation/json_annotation.dart';

part 'preference_model.g.dart';

@JsonSerializable()
class PreferenceModel {
  final String id, name;

  PreferenceModel(this.id, this.name);

  factory PreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$PreferenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PreferenceModelToJson(this);
}
