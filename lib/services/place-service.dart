import 'dart:convert';

import 'package:Pool_Rides/credentials.dart';
import 'package:Pool_Rides/models/place.dart';
import 'package:Pool_Rides/models/suggestion.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=es&components=country:mx&key=$GOOGLE_API_KEY');
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId, String description) async {
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$GOOGLE_API_KEY&sessiontoken=$sessionToken');

    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;

        final geometry = result['result']['geometry'];
        final coords = geometry["location"];
        final bounds = geometry["viewport"];
        final ne = bounds['northeast'];
        final sw = bounds['southwest'];

        // build result
        final boundsInfo = LatLngBounds(
          southwest: LatLng(sw["lat"], sw["lng"]),
          northeast: LatLng(ne["lat"], sw["lng"]),
        );

        final coordinates = LatLng(coords["lat"], coords["lng"]);
        final place = Place(
          bounds: boundsInfo,
          coordinates: coordinates,
          placeId: placeId,
          description: description,
        );

        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
