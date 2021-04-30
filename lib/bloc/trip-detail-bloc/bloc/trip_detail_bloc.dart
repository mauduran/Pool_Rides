import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/user-service.dart';

part 'trip_detail_event.dart';
part 'trip_detail_state.dart';

class TripDetailBloc extends Bloc<TripDetailEvent, TripDetailState> {
  TripDetailBloc() : super(TripDetailInitial());
  UserAuthProvider _authProvider = UserAuthProvider();
  static final UserService _userService = UserService();

  CollectionReference trips = FirebaseFirestore.instance.collection('trips');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Stream<TripDetailState> mapEventToState(
    TripDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is AddUserToTripEvent) {
      try {
        yield LoadingState();
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          bool isAdded = await addUserToTrip(event.trip);

          if (isAdded) {
            DocumentSnapshot updatedTrip =
                await trips.doc(event.trip.tripId).get();
            Trip newTrip = Trip.fromJson(updatedTrip
                .data()); //Truena aquí. Pero ya agrega el usuario al trip y en el usuario crea la colección de mis trips y agrega el viaje.
            yield UserAddedSuccesfully(trip: newTrip);
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

  addUserToTrip(Trip trip) async {
    try {
      User currentUser =
          await _userService.getCurrentUser(_authProvider.getUid());
      print("despues de current userr");
      await trips.doc(trip.tripId).update({
        "passengers": FieldValue.arrayUnion([currentUser.toMap()])
      });
      print("despues de agregar el pasajero al viaje");
      await users
          .doc(_authProvider.getUid())
          .collection("myTrips")
          .doc(trip.tripId)
          .set(trip.toMap()); // Modelo my trip
      print("despues de agregar el viaje a my trips");
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
