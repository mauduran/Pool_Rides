import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/widgets/places/places.dart';
import 'package:pool_rides/utils/principalText.dart';
import 'package:flutter/material.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final double distanceOrigin;
  final double distanceDestination;
  TripCard(
      {Key key,
      @required this.trip,
      @required this.distanceOrigin,
      @required this.distanceDestination})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int numOfReviews = this.trip.driver.totalReviews;
    final double averageRating = this.trip.driver.totalStars / numOfReviews;
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 15, 10),
          height: 225,
          decoration: BoxDecoration(
            color: Color(0xFFEFF2F6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            fit: StackFit.loose,
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
                        Expanded(
                          child: places(
                            context: context,
                            upText: trip.origin.city ?? trip.origin.state,
                            downText:
                                trip.destination.city ?? trip.origin.state,
                            colorDefault: false,
                            distanceOrigin: distanceOrigin,
                            distanceDestination: distanceDestination,
                          ),
                        )
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
                                    (numOfReviews > 0)
                                        ? averageRating.toStringAsFixed(1)
                                        : 'No hay reseñas aún',
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
                alignment: Alignment.bottomRight,
                child: Text(
                  "\$${trip.tripPrice.floor().toString()}",
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
