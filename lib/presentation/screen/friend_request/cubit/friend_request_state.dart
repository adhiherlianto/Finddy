part of 'friend_request_cubit.dart';

abstract class FriendRequestCubitState extends Equatable {
  const FriendRequestCubitState();

  @override
  List<Object> get props => [];
}

class FriendRequestCubitInitial extends FriendRequestCubitState {}

class FriendRequestCubitLoading extends FriendRequestCubitState {}

class FriendRequestCubitSuccess extends FriendRequestCubitState {
  final List<UserModel> allFriendRequest;

  const FriendRequestCubitSuccess(this.allFriendRequest);

  @override
  List<Object> get props => [allFriendRequest];
}

class FriendRequestCubitError extends FriendRequestCubitState {
  final String error;

  const FriendRequestCubitError(this.error);
  @override
  List<Object> get props => [];
}
