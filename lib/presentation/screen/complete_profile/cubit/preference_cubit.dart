import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/entities/preference/preference_model.dart';
import 'package:finddy/domain/repositories/preference/preference_repository.dart';

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
}
