import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:finddy/domain/repositories/user/user_repository.dart';

part 'friend_request_state.dart';

class FriendRequestCubit extends Cubit<FriendRequestCubitState> {
  FriendRequestCubit() : super(FriendRequestCubitInitial());

  void getALlFriendRequest(List<String> friendUid) async {
    emit(FriendRequestCubitLoading());
    try {
      final data = await UserRepository.getAllFriendRequest(friendUid);
      emit(FriendRequestCubitSuccess(data));
    } catch (e) {
      emit(FriendRequestCubitError(e.toString()));
    }
  }
}
