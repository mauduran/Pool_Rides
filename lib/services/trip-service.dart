import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/place-service.dart';
import 'package:pool_rides/utils/date.utils.dart';
import 'package:pool_rides/utils/lists.dart';

class TripService {
  final _cFirestore = FirebaseFirestore.instance;
  DateFormat dateFormat = DateFormat.yMMMd('es');
  DateFormat dateFormatPretty = DateFormat.yMd('es');
  DateFormat timeFormat = DateFormat("hh:mm aaa");

  static final TripService _tripService = new TripService._internal();

  TripService._internal();
  factory TripService() {
    return _tripService;
  }

  Future<bool> createTrip({
    @required User user,
    @required DateTime departureDate,
    @required Place origin,
    @required Place destination,
    @required int capacity,
    @required double price,
  }) async {
    try {
      int tripDuration =
          await PlaceApiProvider().getTimeFromOriginToDest(origin, destination);

      DateTime arrivalDateTime =
          departureDate.copyWith().add(Duration(seconds: tripDuration));
      Trip newTrip = Trip(
          startTime: timeFormat.format(departureDate),
          arrivalTime: timeFormat.format(arrivalDateTime),
          departureDate: departureDate,
          destination: destination,
          driver: user,
          isCarSpecified: true,
          car: cars[0],
          origin: origin,
          passengerCapacity: capacity,
          tripPrice: price,
          passengers: [],
          formattedDepartureDate: dateFormatPretty.format(departureDate));
      await _cFirestore.collection('trips').add(newTrip.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Trip>> searchTrips({
    @required DateTime date,
    @required Place origin,
    @required Place destination,
  }) async {
    String formattedDate = dateFormatPretty.format(date);
    QuerySnapshot queryResult = await _cFirestore
        .collection('trips')
        .where('formattedDepartureDate', isEqualTo: formattedDate)
        .where('origin.state', isEqualTo: origin.state)
        .where('destination.state', isEqualTo: destination.state)
        .get();

    List<QueryDocumentSnapshot> docs = queryResult.docs;

    List<Trip> trips = docs.map((e) => Trip.fromJson(e.data())).toList();

    return trips.where((element) {
      return (Trip.distanceBetweenTwoPlaces(origin, element.origin) < 20000 &&
          Trip.distanceBetweenTwoPlaces(destination, element.destination) <
              20000 &&
          element.passengerCapacity > element.passengers.length);
    }).toList();
  }
}
