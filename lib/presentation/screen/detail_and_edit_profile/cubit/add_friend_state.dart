part of 'add_friend_cubit.dart';

abstract class AddFriendState extends Equatable {
  const AddFriendState();

  @override
  List<Object> get props => [];
}

class AddFriendInitial extends AddFriendState {}

class AddFriendLoading extends AddFriendState {}

class AddFriendSuccess extends AddFriendState {
  final String text;

  const AddFriendSuccess(this.text);
  @override
  List<Object> get props => [text];
}

class AddFriendError extends AddFriendState {
  final String error;

  const AddFriendError(this.error);
  @override
  List<Object> get props => [error];
}

class DeleteFriendInitial extends AddFriendState {}

class DeleteFriendLoading extends AddFriendState {}

class DeleteFriendSuccess extends AddFriendState {
  final String text;

  const DeleteFriendSuccess(this.text);
  @override
  List<Object> get props => [text];
}

class DeleteFriendError extends AddFriendState {
  final String error;

  const DeleteFriendError(this.error);
  @override
  List<Object> get props => [error];
}
