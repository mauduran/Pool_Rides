part of 'trip_detail_bloc.dart';

abstract class TripDetailEvent extends Equatable {
  const TripDetailEvent();

  @override
  List<Object> get props => [];
}

class AddUserToTripEvent extends TripDetailEvent {
  final Trip trip;
  final double distanceOrigin;
  final double distanceDestination;
  AddUserToTripEvent({
    @required this.trip,
    @required this.distanceOrigin,
    @required this.distanceDestination,
  });

  List<Object> get props => [trip, distanceOrigin, distanceDestination];
}
