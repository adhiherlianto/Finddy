part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String error;

  const LoginError(this.error);
  @override
  List<Object> get props => [error];
}

class LogoutSuccess extends AuthState {}

class LogoutError extends AuthState {
  final String error;

  const LogoutError(this.error);
  @override
  List<Object> get props => [error];
}
