part of 'createtrip_bloc.dart';

abstract class CreateTripState extends Equatable {
  const CreateTripState();

  @override
  List<Object> get props => [];
}

class CreateTripInitial extends CreateTripState {}

class CreatedTripState extends CreateTripState {}

class CreatedTripErrorState extends CreateTripState {
  final String error;
  final String code;

  CreatedTripErrorState(
      {@required this.error, this.code = "to be defined code"});

  @override
  List<Object> get props => [error, code];
}

class LoadingState extends CreateTripState {}
