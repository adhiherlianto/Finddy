part of 'interest_cubit.dart';

abstract class InterestState extends Equatable {
  const InterestState();

  @override
  List<Object> get props => [];
}

class InterestInitial extends InterestState {}

class InterestLoading extends InterestState {}

class InterestSuccess extends InterestState {
  final List<InterestModel> interest;

  const InterestSuccess(this.interest);

  @override
  List<Object> get props => [];
}

class InterestError extends InterestState {}
