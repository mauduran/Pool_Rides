import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/user.dart';

import 'cars.dart';

class Trip {
  final String startTime;
  final Place origin;
  final Place destination;
  final String arrivalTime;
  final double tripPrice;
  final DateTime departureDate;
  final User driver;
  final int passengerCapacity;
  final List<User> passengers;

  final bool isCarSpecified;
  final Cars car;
  Trip({
    @required this.passengerCapacity,
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
  });
}
