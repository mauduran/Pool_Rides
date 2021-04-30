import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/trip-query.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/trip-service.dart';
import 'package:pool_rides/services/user-service.dart';
import 'package:pool_rides/models/user.dart';

part 'search_trips_event.dart';
part 'search_trips_state.dart';

class SearchTripsBloc extends Bloc<SearchTripsEvent, SearchTripsState> {
  SearchTripsBloc() : super(SearchTripsInitial());

  @override
  Stream<SearchTripsState> mapEventToState(
    SearchTripsEvent event,
  ) async* {
    if (event is SearchTripsQueryEvent) {
      try {
        yield TripsLoadingState();
        TripQuery query = event.query;
        List<Trip> trips = await TripService().searchTrips(
            date: query.date,
            origin: query.origin,
            destination: query.destination);

        User user =
            await UserService().getCurrentUser(UserAuthProvider().getUid());

        yield SearchTripResults(trips: trips, user: user);
      } catch (e) {
        yield TripsErrorState(
          error: "No se pudo realizar búsqueda",
          code: "Temp Code",
        );
      }
    }
  }
}
