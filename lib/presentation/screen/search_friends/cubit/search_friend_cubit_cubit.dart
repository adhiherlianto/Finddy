import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:finddy/domain/repositories/user/user_repository.dart';

part 'search_friend_state.dart';

class SearchFriendCubit extends Cubit<SearchFriendCubitState> {
  SearchFriendCubit() : super(SearchFriendCubitInitial());

  void getAllUser() async {
    emit(SearchFriendCubitLoading());
    try {
      final data = await UserRepository.getAllUser();
      emit(SearchFriendCubitSuccess(data));
    } catch (e) {
      emit(SearchFriendCubitError(e.toString()));
    }
  }

  void getNameSearch(String? name) async {
    emit(SearchFriendCubitLoading());
    try {
      final data = await UserRepository.getNameSearch(name);
      emit(SearchFriendCubitSuccess(data));
    } catch (e) {
      emit(SearchFriendCubitError(e.toString()));
    }
  }

  void getLocationSearch(String? locationId) async {
    emit(SearchFriendCubitLoading());
    try {
      final data = await UserRepository.getLocationSearch(locationId);
      emit(SearchFriendCubitSuccess(data));
    } catch (e) {
      emit(SearchFriendCubitError(e.toString()));
    }
  }

  void getSkillSearch(String? skill) async {
    emit(SearchFriendCubitLoading());
    try {
      final data = await UserRepository.getSkillSearch(skill!);
      emit(SearchFriendCubitSuccess(data));
    } catch (e) {
      emit(SearchFriendCubitError(e.toString()));
    }
  }

  // void getInterestSearch(String? interest) async {
  //   emit(SearchFriendCubitLoading());
  //   try {
  //     final data = await UserRepository.getInterestSearch(interest);
  //     emit(SearchFriendCubitSuccess(data));
  //   } catch (e) {
  //     emit(SearchFriendCubitError(e.toString()));
  //   }
  // }
}
