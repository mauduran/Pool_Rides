import 'package:Pool_Rides/models/travel.dart';
import 'package:flutter/material.dart';

class TravelCard extends StatelessWidget {
  final Travel travel;
  final int cercania;
  TravelCard({Key key, @required this.travel, this.cercania}) : super(key: key);

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
                        places(
                          context: context,
                          upText: travel.sourceName,
                          downText: travel.destinationName,
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
        Padding(
          padding: const EdgeInsets.only(top: 2.5),
          child: Text(
            upText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 5.0,
            top: 5,
            bottom: 5,
          ),
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
        SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget places({
    @required upText,
    @required downText,
    @required context,
    @required colorDefault,
    @required cercaniaOrigen,
    @required cercaniaDestino,
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
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: cercaniaOrigen == 0
                        ? Colors.green[300]
                        : Color(0xFFEFF2F6),
                  ),
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.directions_walk,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: cercaniaOrigen == 1
                        ? Colors.yellow[300]
                        : Color(0xFFEFF2F6),
                  ),
                  height: 30,
                  width: 30,
                  child: Icon(Icons.directions_walk),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: cercaniaOrigen == 2
                        ? Color(0xFFff6257)
                        : Color(0xFFEFF2F6),
                  ),
                  height: 30,
                  width: 30,
                  child: Icon(Icons.directions_walk),
                ),
              ),
            ],
          ),
        ),
        Text(
          downText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: cercaniaDestino == 0
                        ? Colors.green[300]
                        : Color(0xFFEFF2F6),
                  ),
                  child: Icon(Icons.directions_walk),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: cercaniaDestino == 1
                        ? Colors.yellow[300]
                        : Color(0xFFEFF2F6),
                  ),
                  height: 30,
                  width: 30,
                  child: Icon(Icons.directions_walk),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: cercaniaDestino == 2
                        ? Color(0xFFff6257)
                        : Color(0xFFEFF2F6),
                  ),
                  height: 30,
                  width: 30,
                  child: Icon(Icons.directions_walk),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
