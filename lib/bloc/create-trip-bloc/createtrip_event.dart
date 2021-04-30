part of 'createtrip_bloc.dart';

abstract class CreateTripEvent extends Equatable {
  const CreateTripEvent();

  @override
  List<Object> get props => [];
}

class CreateNewTripEvent extends CreateTripEvent {
  final DateTime departureDate;
  final Place origin;
  final Place destination;
  final int capacity;
  final double price;

  CreateNewTripEvent({
    @required this.departureDate,
    @required this.origin,
    @required this.destination,
    @required this.price,
    @required this.capacity,
  });

  List<Object> get props =>
      [departureDate, origin, destination, capacity, price];
}
