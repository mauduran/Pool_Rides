import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pool_rides/bloc/search-trips-bloc/search_trips_bloc.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/trip-query.dart';

import 'package:flutter/material.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/widgets/trips/TripCard.dart';
import 'package:pool_rides/widgets/trips/trip-detail/tripDetail.dart';

class Trips extends StatefulWidget {
  final TripQuery query;
  Trips({Key key, @required this.query}) : super(key: key);

  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  SearchTripsBloc _bloc;
  int distance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar Viajes"),
      ),
      body: Container(
        child: BlocProvider(
            create: (context) {
              _bloc = SearchTripsBloc();
              return _bloc..add(SearchTripsQueryEvent(query: widget.query));
            },
            child: BlocConsumer<SearchTripsBloc, SearchTripsState>(
              listener: (context, state) {
                if (state is TripsErrorState) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text("Error al buscar viajes"),
                        duration: Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                          label: "Aceptar",
                          textColor: Colors.blue,
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                      ),
                    );
                }
              },
              builder: (context, state) {
                if (state is TripsLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTripResults) {
                  return Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _bloc.add(SearchTripsQueryEvent(query: widget.query));
                        return;
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (state.trips.length == 0)
                            Center(
                              child: Text(
                                'No se encontraron viajes',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                            ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.trips.length,
                              itemBuilder: (context, idx) {
                                Trip trip = state.trips[idx];
                                double distOrigin = getDistance(
                                    widget.query.origin, trip.origin);
                                double distDestination = getDistance(
                                    widget.query.destination, trip.destination);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TripDetailPage(
                                          tripDetail: trip,
                                          distanceDestination: distDestination,
                                          distanceOrigin: distOrigin,
                                          user: state.user,
                                        ),
                                      ),
                                    );
                                  },
                                  child: TripCard(
                                    trip: state.trips[idx],
                                    distanceDestination: distDestination,
                                    distanceOrigin: distOrigin,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container(
                  child: Text(
                    "Error. No se pudieron encontrar viajes",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }

  double getDistance(Place origin, Place destination) {
    double distanceInMeters =
        Trip.distanceBetweenTwoPlaces(origin, destination);

    return distanceInMeters / 1000;
  }
}
