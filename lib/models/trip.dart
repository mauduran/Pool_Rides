import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/user.dart';

import 'car.dart';

part 'trip.g.dart';

@HiveType(typeId: 9, adapterName: "TripAdapter")
class Trip {
  @HiveField(0)
  final String startTime;
  @HiveField(1)
  final Place origin;
  @HiveField(2)
  final Place destination;
  @HiveField(3)
  final String arrivalTime;
  @HiveField(4)
  final double tripPrice;
  @HiveField(5)
  final DateTime departureDate;
  @HiveField(6)
  final User driver;
  @HiveField(7)
  final int passengerCapacity;
  @HiveField(8)
  List<User> passengers;
  @HiveField(10)
  final bool isCarSpecified;
  @HiveField(11)
  final Car car;

  int availableSeatsNumber;
  Trip({
    @required this.passengerCapacity,
    @required this.driver,
    this.passengers = const [],
    @required this.origin,
    @required this.destination,
    @required this.departureDate,
    @required this.startTime,
    @required this.arrivalTime,
    @required this.tripPrice,
    @required this.isCarSpecified,
    this.car, // To Do: hacerlo required
    this.availableSeatsNumber,
  });

  static double distanceBetweenTwoPlaces(Place origin, Place destination) {
    double distanceInMeters = Geolocator.distanceBetween(
      origin.coordinates.lat,
      origin.coordinates.long,
      destination.coordinates.lat,
      destination.coordinates.long,
    );

    return distanceInMeters;
  }
}
