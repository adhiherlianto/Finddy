import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void checkUserLogin() async {
    emit(SplashLoading());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Future.delayed(const Duration(seconds: 2), () {
        if (FirebaseAuth.instance.currentUser != null) {
          emit(SplashSuccess());
        } else {
          final bool? checkUser = prefs.getBool('check');
          emit(SplashError(checkUser ?? false));
        }
      });
    } catch (e) {
      emit(const SplashError(false));
    }
  }
}
