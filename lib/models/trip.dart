import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/user.dart';

import 'car.dart';

class Trip {
  final String startTime;
  final Place origin;
  final Place destination;

  final String arrivalTime;

  final double tripPrice;
  final DateTime departureDate;

  final User driver;
  List<User> passengers;

  final bool isCarSpecified;
  final Car car;

  int availableSeatsNumber;
  Trip({
    @required this.driver,
    @required this.passengers,
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
      origin.coordinates.latitude,
      origin.coordinates.longitude,
      destination.coordinates.latitude,
      destination.coordinates.longitude,
    );

    return distanceInMeters;
  }
}
