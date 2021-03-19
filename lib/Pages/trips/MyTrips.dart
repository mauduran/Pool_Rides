import 'package:flutter/material.dart';
import 'package:pool_rides/utils/lists.dart';
import 'package:pool_rides/widgets/trips/TripCard.dart';
import 'package:pool_rides/widgets/trips/trip-detail/tripDetail.dart';

import '../../theme.dart';

class MyTrips extends StatefulWidget {
  MyTrips({Key key}) : super(key: key);

  @override
  _MyTripsState createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              for (int i = 0; i < tripList.length; i++)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TripDetailPage(
                          tripDetail: tripList[i],
                          cercania: (i % 3) * 1.0,
                        ),
                      ),
                    );
                  },
                  child: TripCard(
                    trip: tripList[i],
                    cercania: (i % 3) * 1.0,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
