import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/entities/interest/interest_model.dart';
import 'package:finddy/domain/repositories/interest/interest_repository.dart';

part 'interest_state.dart';

class InterestCubit extends Cubit<InterestState> {
  InterestCubit() : super(InterestInitial());

  void getAllInterest() async {
    emit(InterestLoading());
    try {
      final data = await InterestRepository.getCity();
      emit(InterestSuccess(data));
    } catch (e) {
      emit(InterestError());
    }
  }
}
