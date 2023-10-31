import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/entities/preference/preference_model.dart';
import 'package:finddy/domain/repositories/preference/preference_repository.dart';
import 'package:finddy/domain/repositories/user/user_repository.dart';

part 'preference_state.dart';

class PreferenceCubit extends Cubit<PreferenceState> {
  PreferenceCubit() : super(PreferenceInitial());

  void getAllPref() async {
    emit(PreferenceLoading());
    try {
      final data = await PreferenceRepository.getPref();
      emit(PreferenceSuccess(data));
    } catch (e) {
      emit(PreferenceError());
    }
  }

  void upadateUser(
    String docId,
    String phone,
    String photo,
    String university,
    String username,
    List<dynamic> interest,
    List<dynamic> pref,
    Map<String, String> location,
  ) async {
    emit(UpdateUserLoading());
    try {
      await UserRepository.updateUser(
          docId: docId,
          isVerified: true,
          phone: phone,
          photo: photo,
          university: university,
          username: username,
          interest: interest,
          pref: pref,
          location: location);
      emit(UpdateUserSuccess());
    } catch (e) {
      emit(UpdateUserError(e.toString()));
      print(e.toString());
    }
  }
}
