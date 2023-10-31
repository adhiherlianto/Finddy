part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final UserModel user;
  const UserSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String error;

  const UserError(this.error);
  @override
  List<Object> get props => [error];
}

class LogoutSuccess extends UserState {}

class LogoutError extends UserState {
  final String error;

  const LogoutError(this.error);
  @override
  List<Object> get props => [error];
}
