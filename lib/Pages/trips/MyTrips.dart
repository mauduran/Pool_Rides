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
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider(
            create: (context) {
              _bloc = MyTripsBloc()..add(SearchMyTrips());
              return _bloc;
            },
            child: BlocConsumer<MyTripsBloc, MyTripsState>(
              listener: (context, state) {},
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
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MyTripDetailPage(
                                          tripDetail: state.myTrips[i],
                                          user: state.user,
                                        ),
                                      ),
                                    );
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
