import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/models/my-trip.dart';

import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/trip-service.dart';

class MyTripService {
  DateFormat dateFormat = DateFormat.yMMMd('es');
  DateFormat dateFormatPretty = DateFormat.yMd('es');
  DateFormat timeFormat = DateFormat("hh:mm aaa");

  static final MyTripService _myTripService = new MyTripService._internal();
  static final TripService _tripService = TripService();
  UserAuthProvider _authProvider = UserAuthProvider();
  CollectionReference trips = FirebaseFirestore.instance.collection('trips');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  MyTripService._internal();
  factory MyTripService() {
    return _myTripService;
  }

  Future<MyTrip> createMyTrip({
    @required String tripId,
    @required double distanceOrigin,
    @required double distanceDestination,
  }) async {
    try {
      final String uid = _authProvider.getUid();
      MyTrip myNewTrip = MyTrip(
        distanceDestination: distanceDestination,
        distanceOrigin: distanceOrigin,
        reviewedUsers: [],
        userUid: uid,
      );

      Map<String, dynamic> myTripMap = myNewTrip.toMap();

      myTripMap['tripRef'] = trips.doc(tripId);

      await users.doc(uid).collection("myTrips").doc(tripId).set(myTripMap);

      return myNewTrip;
    } catch (e) {
      return null;
    }
  }

  Future<void> addReviewedToMyTrip(
    String tripId,
    String reviewedUserUid,
  ) async {
    final String uid = _authProvider.getUid();

    await users.doc(uid).collection("myTrips").doc(tripId).update({
      'reviewedUsers': FieldValue.arrayUnion([reviewedUserUid])
    });
  }

  Future<List<MyTrip>> getMyTrips(User user) async {
    try {
      QuerySnapshot queryResult =
          await users.doc(_authProvider.getUid()).collection("myTrips").get();

      List<QueryDocumentSnapshot> docs = queryResult.docs;

      List<Future<MyTrip>> myTripsFuture = docs.map((e) async {
        MyTrip tempMyTrip = await parseMyTripFromFirebase(e);
        return tempMyTrip;
      }).toList();

      List<MyTrip> myTrips = await Future.wait(myTripsFuture);

      myTrips.sort((a, b) =>
          a.trip.departureDate.difference(b.trip.departureDate).inHours);
      return myTrips;
    } catch (e) {
      return null;
    }
  }

  Future<MyTrip> parseMyTripFromFirebase(DocumentSnapshot e) async {
    Map<String, dynamic> element = e.data();

    DocumentSnapshot tripSnapshot =
        await (element['tripRef'] as DocumentReference).get();
    element['trip'] = await _tripService.parseTripFromFirebase(tripSnapshot);

    MyTrip mytrip = MyTrip.fromJson(element);
    return mytrip;
  }
}
