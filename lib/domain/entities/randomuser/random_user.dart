import 'package:equatable/equatable.dart';

class RandomUser extends Equatable {
  final String gender;
  final String email;
  final String country;

  const RandomUser(
      {required this.gender, required this.email, required this.country});

  @override
  List<Object?> get props => [gender, email, country];
}
