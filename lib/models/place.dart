import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

import 'latilong.dart';

part 'place.g.dart';

@HiveType(typeId: 8, adapterName: "PlaceAdapter")
class Place {
  @HiveField(0)
  String streetNumber;
  @HiveField(1)
  String street;
  @HiveField(2)
  String city;
  @HiveField(3)
  String state;
  @HiveField(4)
  String country;
  @HiveField(5)
  String zipCode;
  @HiveField(6)
  String description;
  @HiveField(7)
  LatiLong coordinates;
  LatLngBounds bounds;
  @HiveField(8)
  String placeId;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
    this.state,
    this.country,
    @required this.coordinates,
    this.bounds,
    @required this.placeId,
    @required this.description,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}
