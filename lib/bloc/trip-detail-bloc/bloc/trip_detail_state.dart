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
  final double distanceOrigin;
  final double distanceDestination;
  UserAddedSuccesfully({
    @required this.trip,
    @required this.distanceOrigin,
    @required this.distanceDestination,
  });

  @override
  List<Object> get props => [trip, distanceOrigin, distanceDestination];
}
