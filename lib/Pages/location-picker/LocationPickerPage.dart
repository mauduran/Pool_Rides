import 'package:geolocator/geolocator.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/suggestion.dart';
import 'package:pool_rides/services/place-service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:pool_rides/widgets/address-search/AddressSearch.dart';

class LocationPickerPage extends StatefulWidget {
  LocationPickerPage({Key key}) : super(key: key);

  @override
  _LocationPickerPageState createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  GoogleMapController _mapController;
  Marker marker;
  Place place;
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void searchLocation() async {
    final sessionToken = Uuid().v4();
    final Suggestion result = await showSearch(
      context: context,
      delegate: AddressSearch(sessionToken),
    );
    if (result != null) {
      final placeDetails = await PlaceApiProvider(sessionToken: sessionToken)
          .getPlaceDetailFromId(result.placeId, result.description);

      FocusScope.of(context).unfocus();

      _mapController
          .animateCamera(CameraUpdate.newLatLng(placeDetails.coordinates));

      // _mapController
      //     .animateCamera(CameraUpdate.newLatLngBounds(placeDetails.bounds, 0));
      _textController.text = result.description;

      setState(() {
        marker = Marker(
            markerId: MarkerId("location"), position: placeDetails.coordinates);
        place = placeDetails;
      });
    }
  }

  Future<void> _getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) return;
    }

    final sessionToken = Uuid().v4();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng coords = LatLng(position.latitude, position.longitude);

    _mapController.animateCamera(CameraUpdate.newLatLng(coords));
    final placeDetails = await PlaceApiProvider(sessionToken: sessionToken)
        .getPlaceFromCoords(coords);
    _textController.text = placeDetails.description;
    setState(() {
      marker = Marker(markerId: MarkerId("location"), position: coords);
      place = placeDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccionar Ubicación"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  _mapController = controller;
                });
              },
              markers: (marker == null) ? null : Set<Marker>.from([marker]),
              initialCameraPosition: CameraPosition(
                target: LatLng(20.613899, -103.418556),
                zoom: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: searchLocation,
                child: TextField(
                  controller: _textController,
                  enabled: false,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.location_on),
                    contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                  ),
                ),
              ),
            ),
            if (place != null)
              Positioned(
                bottom: 30,
                right: 20,
                child: FloatingActionButton(
                  heroTag: "confirmPlace",
                  onPressed: () {
                    Navigator.of(context).pop(place);
                  },
                  child: Icon(Icons.check),
                ),
              ),
            Positioned(
              bottom: 30,
              left: 20,
              child: FloatingActionButton(
                heroTag: "getCurrentPos",
                backgroundColor: Color(0xFF5A7A29),
                onPressed: () {
                  _getCurrentPosition();
                },
                child: Icon(
                  Icons.gps_fixed,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
