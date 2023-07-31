import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String id;
  final String name;

  const LocationModel({required this.id, required this.name});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  List<Object?> get props => [id, name];
}
