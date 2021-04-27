import 'dart:convert';

import 'package:pool_rides/credentials.dart';
import 'package:pool_rides/models/latilong.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/suggestion.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider({this.sessionToken = ''});

  final sessionToken;

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=es&components=country:mx&key=$GOOGLE_API_KEY';

    if (sessionToken != "") {
      url += '&sessionToken=$sessionToken';
    }
    final request = Uri.parse(url);
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

  Future<Place> getPlaceFromCoords(LatLng coords) async {
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${coords.latitude},${coords.longitude}&key=$GOOGLE_API_KEY');

    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final res = result['results'][0];
        final components = res['address_components'] as List<dynamic>;

        final geometry = res['geometry'];
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
          coordinates:
              LatiLong(lat: coordinates.latitude, long: coordinates.longitude),
          placeId: res["place_id"],
          description: res["formatted_address"],
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
          if (type.contains('administrative_area_level_1')) {
            place.state = c['short_name'];
          }
          if (type.contains('country')) {
            place.country = c['short_name'];
          }
        });
        return place;
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
          coordinates:
              LatiLong(lat: coordinates.latitude, long: coordinates.longitude),
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
          if (type.contains('administrative_area_level_1')) {
            place.state = c['short_name'];
          }
          if (type.contains('country')) {
            place.country = c['short_name'];
          }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch place details');
    }
  }

  Future<int> getTimeFromOriginToDest(Place origin, Place destination) async {
    final originId = origin.placeId;
    final destinationId = destination.placeId;

    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?origins=place_id:$originId&destinations=place_id:$destinationId&key=$GOOGLE_API_KEY');

    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      int duration = result['rows'][0]['elements'][0]['duration']['value'];

      return duration;
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
