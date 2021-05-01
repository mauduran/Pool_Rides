import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/place-service.dart';
import 'package:pool_rides/utils/date.utils.dart';

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
        origin: origin,
        passengerCapacity: capacity,
        tripPrice: price,
        passengers: [],
        formattedDepartureDate: dateFormatPretty.format(departureDate),
      );

      Map<String, dynamic> tripMap = newTrip.toMap();
      tripMap['driverRef'] = _cFirestore.collection('users').doc(user.uid);

      await _cFirestore.collection('trips').add(tripMap);
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
    List<Future<Trip>> tripsFuture = docs.map((e) async {
      Map<String, dynamic> element = e.data();
      DocumentSnapshot usrSnapshot =
          await (element['driverRef'] as DocumentReference).get();
      Map<String, dynamic> usr = usrSnapshot.data();
      element['driver'] = usr;
      Trip trip = Trip.fromJson(element);
      trip.tripId = e.id;
      return trip;
    }).toList();

    List<Trip> trips = await Future.wait(tripsFuture);

    return trips.where((element) {
      return (Trip.distanceBetweenTwoPlaces(origin, element.origin) < 20000 &&
          Trip.distanceBetweenTwoPlaces(destination, element.destination) <
              20000 &&
          element.passengerCapacity > element.passengers.length);
    }).toList();
  }
}
