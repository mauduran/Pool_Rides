import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  String streetNumber;
  String street;
  String city;
  String zipCode;
  String description;
  LatLng coordinates;
  LatLngBounds bounds;
  String placeId;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
    @required this.coordinates,
    @required this.bounds,
    @required this.placeId,
    @required this.description,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}
