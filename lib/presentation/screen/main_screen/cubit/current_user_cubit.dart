import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:finddy/domain/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  CurrentUserCubit() : super(CurrentUserInitial());

  void getCurrentUser(String email) async {
    emit(CurrentUserLoading());
    try {
      final user = await UserRepository.getUser(email);
      emit(CurrentUserSuccess(user));
    } catch (e) {
      print(e.toString());
      emit(CurrentUserError(e.toString()));
    }
  }

  void logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      print("a : ${e.toString()}");
      emit(LogoutError(e.toString()));
    }
  }
}
