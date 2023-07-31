import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void checkUserLogin() {
    emit(SplashLoading());
    try {
      Future.delayed(const Duration(seconds: 2), () {
        if (FirebaseAuth.instance.currentUser != null) {
          emit(SplashSuccess());
        } else {
          emit(SplashError());
        }
      });
    } catch (e) {
      emit(SplashError());
    }
  }
}
