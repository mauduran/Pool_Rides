import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/place.dart';

class TripQuery {
  Place origin;
  Place destination;
  DateTime date;

  TripQuery({
    @required this.origin,
    @required this.destination,
    @required this.date,
  });
}
