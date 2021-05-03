import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pool_rides/Pages/my-trip-detail/MyTripDetail.dart';
import 'package:pool_rides/bloc/my-trips-bloc/my_trips_bloc.dart';
import 'package:pool_rides/widgets/trips/TripCard.dart';

class MyTrips extends StatefulWidget {
  MyTrips({Key key}) : super(key: key);

  @override
  _MyTripsState createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  MyTripsBloc _bloc;
  bool isNotConnected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider(
            create: (context) {
              _bloc = MyTripsBloc()..add(SearchMyTrips());
              return _bloc;
            },
            child: BlocConsumer<MyTripsBloc, MyTripsState>(
              listener: (context, state) {
                if (state is OfflineMode) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text("Modo offline: viajes guardados"),
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
                } else if (state is OfflineMode) {
                  isNotConnected = true;
                }
              },
              builder: (context, state) {
                if (state is LoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MyTripsFound) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Column(
                        children: [
                          if (state.myTrips.length == 0)
                            Text("No se encontraron viajes"),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 20),
                              for (int i = 0; i < state.myTrips.length; i++)
                                GestureDetector(
                                  onTap: () async {
                                    var madeChanges =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MyTripDetailPage(
                                          tripDetail: state.myTrips[i],
                                          user: state.user,
                                        ),
                                      ),
                                    );
                                    if (madeChanges != null && madeChanges) {
                                      _bloc.add(SearchMyTrips());
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Viaje registrado exitosamente"),
                                            duration: Duration(seconds: 3),
                                            behavior: SnackBarBehavior.floating,
                                            action: SnackBarAction(
                                              label: "Aceptar",
                                              textColor: Colors.blue,
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                              },
                                            ),
                                          ),
                                        );
                                    }
                                  },
                                  child: TripCard(
                                    trip: state.myTrips[i].trip,
                                    distanceOrigin:
                                        state.myTrips[i].distanceOrigin,
                                    distanceDestination:
                                        state.myTrips[i].distanceDestination,
                                  ),
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                } else
                  return Text("No se encontraron viajes");
              },
            )));
  }
}
