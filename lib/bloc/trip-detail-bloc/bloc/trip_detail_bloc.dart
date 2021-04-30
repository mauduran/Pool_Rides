import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/my-trip.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/user-service.dart';
import 'package:pool_rides/services/my-trip-service.dart';

part 'trip_detail_event.dart';
part 'trip_detail_state.dart';

class TripDetailBloc extends Bloc<TripDetailEvent, TripDetailState> {
  TripDetailBloc() : super(TripDetailInitial());
  UserAuthProvider _authProvider = UserAuthProvider();
  static final UserService _userService = UserService();
  static final MyTripService _myTripService = MyTripService();

  CollectionReference trips = FirebaseFirestore.instance.collection('trips');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Stream<TripDetailState> mapEventToState(
    TripDetailEvent event,
  ) async* {
    if (event is AddUserToTripEvent) {
      try {
        yield LoadingState();
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          bool isAdded = await addUserToTripBloc(
            trip: event.trip,
            distOrigin: event.distanceOrigin,
            distDest: event.distanceDestination,
          );

          if (isAdded) {
            DocumentSnapshot updatedTrip =
                await trips.doc(event.trip.tripId).get();
            Trip newTrip = Trip.fromJson(updatedTrip.data());
            yield UserAddedSuccesfully(
              trip: newTrip,
              distanceOrigin: event.distanceOrigin,
              distanceDestination: event.distanceDestination,
            );
            return;
          }
        }
        throw "Error";
      } catch (e) {
        yield ErrorState(
          error: e.toString(),
          errorEasy: "Algo salió mal al registrar al usuario en el viaje",
        );
      }
    }
  }

  addUserToTripBloc({
    Trip trip,
    double distOrigin,
    double distDest,
  }) async {
    try {
      User currentUser =
          await _userService.getCurrentUser(_authProvider.getUid());

      MyTrip newTrip = await _myTripService.addUserToTrip(
          user: currentUser,
          trip: trip,
          distanceOrigin: distOrigin,
          distanceDestination: distDest);

      await users
          .doc(_authProvider.getUid())
          .collection("myTrips")
          .doc(trip.tripId)
          .set(newTrip.toMap());
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
