import 'package:flutter/material.dart';

class RouteLocations extends StatelessWidget {
  final String origin;
  final String destination;
  final double spacing;
  const RouteLocations(
      {Key key,
      @required this.origin,
      @required this.destination,
      @required this.spacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 28,
                color: Colors.red[900],
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                origin,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(
            height: spacing,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                destination,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
