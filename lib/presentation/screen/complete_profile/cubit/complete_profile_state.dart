part of 'complete_profile_cubit.dart';

abstract class CompleteProfileState extends Equatable {
  const CompleteProfileState();

  @override
  List<Object> get props => [];
}

class CompleteProfileInitial extends CompleteProfileState {}

class CompleteProfileLoading extends CompleteProfileState {}

class CompleteProfileSuccess extends CompleteProfileState {
  List<LocationModel> location;

  CompleteProfileSuccess(this.location);

  @override
  List<Object> get props => [location];
}

class CompleteProfileError extends CompleteProfileState {}
