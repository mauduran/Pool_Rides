import 'package:flutter/foundation.dart';

class Travel {
  final String driverName;
  final String startTime;
  final String arrivalTime;
  final double priceTravel;
  final double stars;
  final String sourceName;
  final String destinationName;
  final String imageDriver;
  Travel({
    @required this.driverName,
    @required this.startTime,
    @required this.arrivalTime,
    @required this.priceTravel,
    @required this.stars,
    @required this.sourceName,
    @required this.destinationName,
    @required this.imageDriver,
  });
}
