import 'package:flutter/material.dart';

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
                  color: cercaniaOrigen == 1
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
                      ? Colors.green[400]
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
