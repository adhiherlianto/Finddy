import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/entities/location/location_model.dart';
import 'package:finddy/domain/repositories/location/location_repository.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(CompleteProfileInitial());

  void getLocation() async {
    emit(CompleteProfileLoading());
    try {
      final data = await LocationRepository.get();

      emit(CompleteProfileSuccess(data));
      print(data);
    } catch (e) {
      emit(CompleteProfileError());
      print(e.toString());
    }
  }
}
