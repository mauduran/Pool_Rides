part of 'trip_detail_bloc.dart';

abstract class TripDetailState extends Equatable {
  const TripDetailState();

  @override
  List<Object> get props => [];
}

class TripDetailInitial extends TripDetailState {}

class LoadingState extends TripDetailState {}

class ErrorState extends TripDetailState {
  final String error;
  final String errorEasy;

  ErrorState({@required this.error, this.errorEasy = "to be defined code"});

  @override
  List<Object> get props => [error, errorEasy];
}

class UserAddedSuccesfully extends TripDetailState {
  final Trip trip;

  UserAddedSuccesfully({@required this.trip});

  @override
  List<Object> get props => [trip];
}
