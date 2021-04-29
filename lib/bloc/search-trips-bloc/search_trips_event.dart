part of 'search_trips_bloc.dart';

abstract class SearchTripsEvent extends Equatable {
  const SearchTripsEvent();

  @override
  List<Object> get props => [];
}

class SearchTripsQueryEvent extends SearchTripsEvent {
  final TripQuery query;

  SearchTripsQueryEvent({@required this.query});

  List<Object> get props => [query];
}
