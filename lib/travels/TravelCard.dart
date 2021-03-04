import 'package:Pool_Rides/models/travel.dart';
import 'package:flutter/material.dart';

class TravelCard extends StatelessWidget {
  final Travel travel;
  TravelCard({Key key, @required this.travel}) : super(key: key);

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
                          upText: travel.startTime,
                          downText: travel.arrivalTime,
                          colorDefault: true,
                        ),
                        SizedBox(width: 15),
                        principalText(
                          context: context,
                          upText: travel.sourceName,
                          downText: travel.destinyName,
                          colorDefault: false,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            travel.imageDriver != ""
                                ? travel.imageDriver
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
                                travel.driverName,
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
                                Text(travel.stars.toString(),
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
                  "\$${travel.priceTravel.toString()}",
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

  Widget principalText({
    @required upText,
    @required downText,
    @required context,
    @required colorDefault,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          upText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.south,
            size: 30,
            color: colorDefault
                ? Theme.of(context).primaryColor
                : Color(0xFFEFF2F6),
          ),
        ),
        Text(
          downText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
