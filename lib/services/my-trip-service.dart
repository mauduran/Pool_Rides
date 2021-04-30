import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/models/my-trip.dart';

import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';

class MyTripService {
  DateFormat dateFormat = DateFormat.yMMMd('es');
  DateFormat dateFormatPretty = DateFormat.yMd('es');
  DateFormat timeFormat = DateFormat("hh:mm aaa");

  static final MyTripService _myTripService = new MyTripService._internal();

  CollectionReference trips = FirebaseFirestore.instance.collection('trips');

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
      );

      await trips.doc(trip.tripId).update({
        "passengers": FieldValue.arrayUnion([user.toMap()])
      });

      return myNewTrip;
    } catch (e) {
      return null;
    }
  }
}
