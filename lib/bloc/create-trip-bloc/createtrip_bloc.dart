import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/my-trip-service.dart';
import 'package:pool_rides/services/trip-service.dart';
import 'package:pool_rides/services/user-service.dart';

part 'createtrip_event.dart';
part 'createtrip_state.dart';

class CreateTripBloc extends Bloc<CreateTripEvent, CreateTripState> {
  final _myTripService = MyTripService();
  CreateTripBloc() : super(CreateTripInitial());

  @override
  Stream<CreateTripState> mapEventToState(
    CreateTripEvent event,
  ) async* {
    if (event is CreateNewTripEvent) {
      try {
        yield LoadingState();
        User user =
            await UserService().getCurrentUser(UserAuthProvider().getUid());
        if (user.car == null || user.car.brand == null) {
          yield CreatedTripErrorState(
            error: "Por favor registra tu auto primero.",
            code: "400",
          );
          return;
        }
        final createdTrip = await TripService().createTrip(
          user: user,
          departureDate: event.departureDate,
          origin: event.origin,
          destination: event.destination,
          capacity: event.capacity,
          price: event.price,
        );

        if (createdTrip == null) throw Exception("Could not create trip");
        await _myTripService.createMyTrip(
          tripId: createdTrip,
          distanceOrigin: 0,
          distanceDestination: 0,
        );
        yield CreatedTripState();
      } catch (e) {
        print(e);
        yield CreatedTripErrorState(
          error: "No se pudo crear viaje",
          code: "Temp Code",
        );
      }
    }
  }
}
