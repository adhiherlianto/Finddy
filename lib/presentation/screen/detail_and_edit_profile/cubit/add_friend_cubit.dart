import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/repositories/user/user_repository.dart';

part 'add_friend_state.dart';

class AddFriendCubit extends Cubit<AddFriendState> {
  AddFriendCubit() : super(AddFriendInitial());

  void addFriend(String uid) async {
    emit(AddFriendLoading());
    try {
      await UserRepository.addFriend(uid);
      emit(const AddFriendSuccess("Teman ditambahkan"));
    } catch (e) {
      emit(AddFriendError(e.toString()));
    }
  }

  void deleteFriend(String uid) async {
    emit(AddFriendLoading());
    try {
      await UserRepository.deleteFriend(uid);
      emit(const DeleteFriendSuccess("Teman dihapus"));
    } catch (e) {
      emit(AddFriendError(e.toString()));
    }
  }

  void addFriendRequest(String uid) async {
    emit(AddFriendLoading());
    try {
      await UserRepository.addFriendRequest(uid);
      emit(const AddFriendSuccess("Permintaan pertemanan dikirim"));
    } catch (e) {
      emit(AddFriendError(e.toString()));
    }
  }

  void deleteFriendRequest(String uid, bool? isAccept) async {
    emit(AddFriendLoading());
    try {
      await UserRepository.deleteFriendRequest(uid, isAccept);
      emit(const DeleteFriendSuccess("Permintaan pertemanan dibatalkan"));
    } catch (e) {
      emit(AddFriendError(e.toString()));
    }
  }
}
