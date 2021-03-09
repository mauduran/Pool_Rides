import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  String streetNumber;
  String street;
  String city;
  String zipCode;
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
    this.placeId,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}
