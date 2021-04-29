part of 'search_trips_bloc.dart';

abstract class SearchTripsState extends Equatable {
  const SearchTripsState();
  
  @override
  List<Object> get props => [];
}

class SearchTripsInitial extends SearchTripsState {}
