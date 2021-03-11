import 'package:Pool_Rides/models/cars.dart';
import 'package:Pool_Rides/models/user.dart';
import 'package:flutter/foundation.dart';

class Trips {
  final String startTime;
  final String sourceName;
  final String sourceLocation;

  final String arrivalTime;
  final String destinyName;
  final String destinyLocation;

  final double priceTrips;
  final DateTime departureDate;

  final User driver;
  final List<User> passengers;

  final bool isCarSpecified;
  final Cars car;
  Trips({
    @required this.driver,
    @required this.passengers,
    @required this.sourceLocation,
    @required this.destinyLocation,
    @required this.departureDate,
    @required this.startTime,
    @required this.arrivalTime,
    @required this.priceTrips,
    @required this.sourceName,
    @required this.destinyName,
    @required this.isCarSpecified,
    this.car,
  });
}
