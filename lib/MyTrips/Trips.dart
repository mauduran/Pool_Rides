import 'package:pool_rides/models/trip-query.dart';
import 'package:pool_rides/travels/TripCard.dart';
import 'package:pool_rides/travels/trip-detail/tripDetail.dart';
import 'package:flutter/material.dart';
import 'package:pool_rides/utils/lists.dart';

import '../theme.dart';

class Trips extends StatefulWidget {
  final TripQuery query;
  Trips({Key key, @required this.query}) : super(key: key);

  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar Viajes"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      contentPadding: EdgeInsets.all(8),
                      focusedBorder: roundedInputBorder,
                      border: roundedInputBorder,
                      enabledBorder: roundedInputBorder),
                ),
                SizedBox(height: 20),
                for (int i = 0; i < trips.length; i++)
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TripDetailPage(
                            tripDetail: trips[i],
                            cercania: (i % 3),
                          ),
                        ),
                      );
                    },
                    child: TripCard(
                      trip: trips[i],
                      cercania: (i % 3),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
