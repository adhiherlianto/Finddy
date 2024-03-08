part of 'search_friend_cubit_cubit.dart';

abstract class SearchFriendCubitState extends Equatable {
  const SearchFriendCubitState();

  @override
  List<Object> get props => [];
}

class SearchFriendCubitInitial extends SearchFriendCubitState {}

class SearchFriendCubitLoading extends SearchFriendCubitState {}

class SearchFriendCubitSuccess extends SearchFriendCubitState {
  final List<UserModel> allUser;

  const SearchFriendCubitSuccess(this.allUser);

  @override
  List<Object> get props => [allUser];
}

class SearchFriendCubitError extends SearchFriendCubitState {
  final String error;

  const SearchFriendCubitError(this.error);
  @override
  List<Object> get props => [];
}
