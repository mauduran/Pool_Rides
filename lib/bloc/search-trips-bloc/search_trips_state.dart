part of 'search_trips_bloc.dart';

abstract class SearchTripsState extends Equatable {
  const SearchTripsState();

  @override
  List<Object> get props => [];
}

class SearchTripsInitial extends SearchTripsState {}

class SearchTripResults extends SearchTripsState {
  final List<Trip> trips;

  SearchTripResults({@required this.trips});
}

class TripsErrorState extends SearchTripsState {
  final String error;
  final String code;

  TripsErrorState({@required this.error, this.code = "to be defined code"});

  @override
  List<Object> get props => [error, code];
}

class TripsLoadingState extends SearchTripsState {}
