part of 'complete_profile_cubit.dart';

abstract class CompleteProfileState extends Equatable {
  const CompleteProfileState();

  @override
  List<Object> get props => [];
}

class GetLocationInitial extends CompleteProfileState {}

class GetLocationLoading extends CompleteProfileState {}

class GetLocationSuccess extends CompleteProfileState {
  final List<LocationModel> location;

  const GetLocationSuccess(this.location);

  @override
  List<Object> get props => [location];
}

class GetLocationError extends CompleteProfileState {}

class GetProvinceLoading extends CompleteProfileState {}

class GetProvinceSuccess extends CompleteProfileState {
  final List<String> province;

  const GetProvinceSuccess(this.province);

  @override
  List<Object> get props => [province];
}

class GetProvinceError extends CompleteProfileState {}
