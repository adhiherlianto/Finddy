import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:finddy/domain/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  void getUser(String email) async {
    emit(UserLoading());
    try {
      final user = await UserRepository.getUser(email);
      emit(UserSuccess(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void LogoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }
}
