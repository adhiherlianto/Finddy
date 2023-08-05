import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void registerUser(String email, String password, String name) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await UserRepository.createUser(
          email: email, isVerified: false, name: name);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const RegisterError("Password terlalu lemah"));
      } else if (e.code == 'email-already-in-use') {
        emit(const RegisterError("Email telah digunakan"));
      }
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
