import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:finddy/domain/repositories/user/user_repository.dart';

part 'friend_state.dart';

class FriendCubit extends Cubit<FriendCubitState> {
  FriendCubit() : super(FriendCubitInitial());

  void getAllFriend(List<String> uid) async {
    emit(FriendCubitLoading());
    try {
      final data = await UserRepository.getAllFriend(uid);
      emit(FriendCubitSuccess(data));
    } catch (e) {
      emit(FriendCubitError(e.toString()));
    }
  }
}
