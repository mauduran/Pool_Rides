import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/models/my-trip.dart';

import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';

class MyTripService {
  DateFormat dateFormat = DateFormat.yMMMd('es');
  DateFormat dateFormatPretty = DateFormat.yMd('es');
  DateFormat timeFormat = DateFormat("hh:mm aaa");

  static final MyTripService _myTripService = new MyTripService._internal();

  UserAuthProvider _authProvider = UserAuthProvider();
  CollectionReference trips = FirebaseFirestore.instance.collection('trips');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  MyTripService._internal();
  factory MyTripService() {
    return _myTripService;
  }

  Future<MyTrip> addUserToTrip({
    @required User user,
    @required Trip trip,
    @required double distanceOrigin,
    @required double distanceDestination,
  }) async {
    try {
      MyTrip myNewTrip = MyTrip(
        distanceDestination: distanceDestination,
        distanceOrigin: distanceOrigin,
        trip: trip,
        reviewedUsers: [],
        userUid: user.uid,
      );

      await trips.doc(trip.tripId).update({
        "passengers": FieldValue.arrayUnion([user.toMap()])
      });

      return myNewTrip;
    } catch (e) {
      return null;
    }
  }

  Future<List<MyTrip>> getMyTrips(User user) async {
    try {
      QuerySnapshot queryResult = await users
          .doc(_authProvider.getUid())
          .collection("myTrips")
          .orderBy('trip.departureDate', descending: true)
          .get();

      List<QueryDocumentSnapshot> docs = queryResult.docs;

      List<MyTrip> myTrips = docs.map((e) {
        MyTrip trip = MyTrip.fromJson(e.data());
        return trip;
      }).toList();

      return myTrips;
    } catch (e) {
      return null;
    }
  }
}
