import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/user.dart';

import 'car.dart';

part 'trip.g.dart';

@HiveType(typeId: 9, adapterName: "TripAdapter")
class Trip {
  @HiveField(0)
  final String startTime;
  @HiveField(1)
  final Place origin;
  @HiveField(2)
  final Place destination;
  @HiveField(3)
  final String arrivalTime;
  @HiveField(4)
  final double tripPrice;
  @HiveField(5)
  final DateTime departureDate;
  @HiveField(6)
  final User driver;
  @HiveField(7)
  final int passengerCapacity;
  @HiveField(8)
  List<User> passengers;
  @HiveField(10)
  final String formattedDepartureDate;
  @HiveField(11)
  String tripId;

  Trip({
    @required this.passengerCapacity,
    @required this.driver,
    this.passengers = const [],
    @required this.origin,
    @required this.destination,
    @required this.departureDate,
    @required this.startTime,
    @required this.arrivalTime,
    @required this.tripPrice,
    @required this.formattedDepartureDate,
    this.tripId,
  });

  static double distanceBetweenTwoPlaces(Place origin, Place destination) {
    double distanceInMeters = Geolocator.distanceBetween(
      origin.coordinates.lat,
      origin.coordinates.long,
      destination.coordinates.lat,
      destination.coordinates.long,
    );

    return distanceInMeters;
  }

  factory Trip.fromJson(Map<String, dynamic> parsedJson) {
    List<User> passenger = [];
    if (parsedJson.containsKey("passengers") &&
        parsedJson["passengers"].length > 0) {
      passenger = (parsedJson['passengers'])
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return new Trip(
      passengerCapacity: parsedJson['passengerCapacity'],
      driver: (parsedJson.containsKey('driver'))
          ? User.fromJson(parsedJson['driver'])
          : null,
      passengers: passenger,
      origin: (parsedJson.containsKey('origin'))
          ? Place.fromJson(parsedJson['origin'])
          : null,
      destination: (parsedJson.containsKey('destination'))
          ? Place.fromJson(parsedJson['destination'])
          : null,
      departureDate: DateTime.parse(parsedJson['departureDate']),
      startTime: parsedJson['startTime'],
      arrivalTime: parsedJson['arrivalTime'],
      tripPrice: parsedJson['tripPrice'],
      formattedDepartureDate: parsedJson['formattedDepartureDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "passengerCapacity": passengerCapacity,
      "driver": driver.toMap(),
      "passengers": passengers.map((e) => e.toMap()).toList(),
      "origin": origin.toMap(),
      "destination": destination.toMap(),
      "departureDate": departureDate.toIso8601String(),
      "startTime": startTime,
      "arrivalTime": arrivalTime,
      "tripPrice": tripPrice,
      "formattedDepartureDate": formattedDepartureDate,
    };
  }
}
