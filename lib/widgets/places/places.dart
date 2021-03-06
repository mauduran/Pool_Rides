import 'package:flutter/material.dart';

Widget places({
  @required upText,
  @required downText,
  @required context,
  @required colorDefault,
  @required distanceOrigin,
  @required distanceDestination,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Flexible(
        child: Text(
          upText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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
                  color: distanceOrigin <= 5
                      ? Colors.green[400]
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
                  color: distanceOrigin > 5 && distanceOrigin <= 10
                      ? Colors.yellow[700]
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
                  color: distanceOrigin > 10
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
        softWrap: true,
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
                  color: distanceDestination <= 5
                      ? Colors.green[400]
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
                  color: distanceDestination > 5 && distanceDestination <= 10
                      ? Colors.yellow[700]
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
                  color: distanceDestination > 10
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
