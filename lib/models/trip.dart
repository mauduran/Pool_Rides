import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/user.dart';

import 'cars.dart';

class Trip {
  final String startTime;
  final String originName;
  final String originLocation;

  final String arrivalTime;
  final String destinationName;
  final String destinationLocation;

  final double tripPrice;
  final DateTime departureDate;

  final User driver;
  final List<User> passengers;

  final bool isCarSpecified;
  final Cars car;
  Trip({
    @required this.driver,
    @required this.passengers,
    @required this.originLocation,
    @required this.destinationLocation,
    @required this.departureDate,
    @required this.startTime,
    @required this.arrivalTime,
    @required this.tripPrice,
    @required this.originName,
    @required this.destinationName,
    @required this.isCarSpecified,
    this.car,
  });
}
