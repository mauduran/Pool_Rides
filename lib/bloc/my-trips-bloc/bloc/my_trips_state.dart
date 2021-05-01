part of 'my_trips_bloc.dart';

abstract class MyTripsState extends Equatable {
  const MyTripsState();

  @override
  List<Object> get props => [];
}

class MyTripsInitial extends MyTripsState {}

class MyTripsFound extends MyTripsState {
  final List<MyTrip> myTrips;
  final User user;
  MyTripsFound({
    @required this.myTrips,
    @required this.user,
  });
  @override
  List<Object> get props => [myTrips, user];
}

class LoadingState extends MyTripsState {}

class ErrorState extends MyTripsState {
  final String error;
  final String code;

  ErrorState({@required this.error, this.code = "to be defined code"});

  @override
  List<Object> get props => [error, code];
}
