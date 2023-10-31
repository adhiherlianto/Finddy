import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/entities/location/location_model.dart';
import 'package:finddy/domain/repositories/location/location_repository.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(GetLocationInitial());

  void getAllProvince() async {
    emit(GetLocationLoading());
    try {
      final data = await LocationRepository.getProvince();
      emit(GetProvinceSuccess(data));
    } catch (e) {
      emit(GetProvinceError());
    }
  }

  void getLocation(String province) async {
    emit(GetLocationLoading());
    try {
      final data = await LocationRepository.getCity(province);
      emit(GetLocationSuccess(data));
    } catch (e) {
      emit(GetLocationError());
      print(e.toString());
    }
  }
}
