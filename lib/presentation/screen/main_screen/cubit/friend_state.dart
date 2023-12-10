part of 'friend_cubit.dart';

abstract class FriendCubitState extends Equatable {
  const FriendCubitState();

  @override
  List<Object> get props => [];
}

class FriendCubitInitial extends FriendCubitState {}

class FriendCubitLoading extends FriendCubitState {}

class FriendCubitSuccess extends FriendCubitState {
  final List<UserModel> allfriend;

  const FriendCubitSuccess(this.allfriend);

  @override
  List<Object> get props => [allfriend];
}

class FriendCubitError extends FriendCubitState {
  final String error;

  const FriendCubitError(this.error);
  @override
  List<Object> get props => [];
}
