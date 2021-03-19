import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/utils/places.dart';
import 'package:pool_rides/utils/principalText.dart';
import 'package:flutter/material.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final double cercania;
  TripCard({Key key, @required this.trip, this.cercania}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 15, 10),
          // color: Color(0xFFEFF2F6),
          decoration: BoxDecoration(
            color: Color(0xFFEFF2F6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        principalText(
                          context: context,
                          upText: trip.startTime,
                          downText: trip.arrivalTime,
                          colorDefault: true,
                        ),
                        SizedBox(width: 15),
                        places(
                          context: context,
                          upText: trip.origin.city,
                          downText: trip.destination.city,
                          colorDefault: false,
                          cercaniaOrigen: cercania,
                          cercaniaDestino: (cercania + 1) % 3,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            trip.driver.image != ""
                                ? trip.driver.image
                                : "https://www.freeiconspng.com/thumbs/driver-icon/driver-icon-14.png",
                          ),
                          maxRadius: 22.5,
                          backgroundColor: Colors.grey[300],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(
                                trip.driver.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.star),
                                SizedBox(width: 6),
                                Text(
                                    trip.driver.stars
                                        .toString()
                                        .substring(0, 4),
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "\$${trip.tripPrice.toString().substring(0, 6)}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
