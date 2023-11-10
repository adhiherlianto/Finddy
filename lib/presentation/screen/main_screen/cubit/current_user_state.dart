part of 'current_user_cubit.dart';

abstract class CurrentUserState extends Equatable {
  const CurrentUserState();

  @override
  List<Object> get props => [];
}

class CurrentUserInitial extends CurrentUserState {}

class CurrentUserLoading extends CurrentUserState {}

class CurrentUserSuccess extends CurrentUserState {
  final UserModel currentUser;
  const CurrentUserSuccess(this.currentUser);
  @override
  List<Object> get props => [currentUser];
}

class CurrentUserError extends CurrentUserState {
  final String error;

  const CurrentUserError(this.error);
  @override
  List<Object> get props => [error];
}

class LogoutSuccess extends CurrentUserState {}

class LogoutError extends CurrentUserState {
  final String error;

  const LogoutError(this.error);
  @override
  List<Object> get props => [error];
}
