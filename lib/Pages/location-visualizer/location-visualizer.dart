import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pool_rides/models/place.dart';

class LocationVisualizerPage extends StatelessWidget {
  final Place location;
  const LocationVisualizerPage({Key key, @required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: location.coordinates,
          zoom: 13,
        ),
        markers: Set<Marker>.from(
          [
            Marker(
              markerId: MarkerId(location.description),
              position: location.coordinates,
            ),
          ],
        ),
      ),
    );
  }
}
