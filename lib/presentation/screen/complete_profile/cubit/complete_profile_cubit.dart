import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/repositories/location/location_repository.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(CompleteProfileInitial());

  void getLocation() async {
    emit(CompleteProfileLoading());
    try {
      final data = await LocationRepository.get();
      final stringData = data.map((e) => e.name).toList();
      emit(CompleteProfileSuccess(stringData));
      print(stringData);
    } catch (e) {
      emit(CompleteProfileError());
      print(e.toString());
    }
  }
}
