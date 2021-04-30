part of 'trip_detail_bloc.dart';

abstract class TripDetailEvent extends Equatable {
  const TripDetailEvent();

  @override
  List<Object> get props => [];
}

class AddUserToTripEvent extends TripDetailEvent {
  final Trip trip;

  AddUserToTripEvent({
    @required this.trip,
  });

  List<Object> get props => [trip];
}
