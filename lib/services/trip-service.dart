import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/place-service.dart';
import 'package:pool_rides/utils/date.utils.dart';

class TripService {
  final _cFirestore = FirebaseFirestore.instance;
  DateFormat _dateFormatPretty = DateFormat.yMd('es');
  DateFormat _timeFormat = DateFormat("hh:mm aaa");

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
        startTime: _timeFormat.format(departureDate),
        arrivalTime: _timeFormat.format(arrivalDateTime),
        departureDate: departureDate,
        destination: destination,
        origin: origin,
        passengerCapacity: capacity,
        tripPrice: price,
        passengers: [],
        formattedDepartureDate: _dateFormatPretty.format(departureDate),
      );

      Map<String, dynamic> tripMap = newTrip.toMap();
      tripMap['driverRef'] = _cFirestore.collection('users').doc(user.uid);
      tripMap['passengerRefs'] = [];

      await _cFirestore.collection('trips').add(tripMap);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addUserToTrip({
    @required Trip trip,
  }) async {
    try {
      final String uid = UserAuthProvider().getUid();
      DocumentReference passengerRef = _cFirestore.collection('users').doc(uid);

      await _cFirestore.collection('trips').doc(trip.tripId).update({
        'passengerRefs': FieldValue.arrayUnion([passengerRef])
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Trip>> searchTrips({
    @required DateTime date,
    @required Place origin,
    @required Place destination,
  }) async {
    String formattedDate = _dateFormatPretty.format(date);
    QuerySnapshot queryResult = await _cFirestore
        .collection('trips')
        .where('formattedDepartureDate', isEqualTo: formattedDate)
        .where('origin.state', isEqualTo: origin.state)
        .where('destination.state', isEqualTo: destination.state)
        .get();

    List<QueryDocumentSnapshot> docs = queryResult.docs;
    List<Future<Trip>> tripsFuture = docs.map((e) async {
      return await parseTripFromFirebase(e);
    }).toList();

    List<Trip> trips = await Future.wait(tripsFuture);

    return trips.where((element) {
      return (Trip.distanceBetweenTwoPlaces(origin, element.origin) < 20000 &&
          Trip.distanceBetweenTwoPlaces(destination, element.destination) <
              20000 &&
          element.passengerCapacity > element.passengers.length);
    }).toList();
  }

  Future<Trip> parseTripFromFirebase(DocumentSnapshot e) async {
    Map<String, dynamic> element = e.data();
    DocumentSnapshot usrSnapshot =
        await (element['driverRef'] as DocumentReference).get();
    Map<String, dynamic> usr = usrSnapshot.data();
    element['driver'] = usr;

    if (element.containsKey('passengerRefs')) {
      List<Future<Map<String, dynamic>>> passengersFuture =
          element['passengerRefs']
              .map<Future<Map<String, dynamic>>>((ref) async {
        DocumentSnapshot passengerSnapshot =
            await (ref as DocumentReference).get();
        return passengerSnapshot.data();
      }).toList();
      element['passengers'] = await Future.wait(passengersFuture);
    }

    Trip trip = Trip.fromJson(element);
    trip.tripId = e.id;

    return trip;
  }
}
