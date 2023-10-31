part of 'preference_cubit.dart';

abstract class PreferenceState extends Equatable {
  const PreferenceState();

  @override
  List<Object> get props => [];
}

class PreferenceInitial extends PreferenceState {}

class PreferenceLoading extends PreferenceState {}

class PreferenceSuccess extends PreferenceState {
  final List<PreferenceModel> pref;

  const PreferenceSuccess(this.pref);

  @override
  List<Object> get props => [];
}

class PreferenceError extends PreferenceState {}

class UpdateUserInitial extends PreferenceState {}

class UpdateUserLoading extends PreferenceState {}

class UpdateUserSuccess extends PreferenceState {}

class UpdateUserError extends PreferenceState {
  final String error;

  const UpdateUserError(this.error);
  @override
  List<Object> get props => [];
}
