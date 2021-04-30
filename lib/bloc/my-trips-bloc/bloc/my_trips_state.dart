part of 'my_trips_bloc.dart';

abstract class MyTripsState extends Equatable {
  const MyTripsState();
  
  @override
  List<Object> get props => [];
}

class MyTripsInitial extends MyTripsState {}
