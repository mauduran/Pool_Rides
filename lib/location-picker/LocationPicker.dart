import 'package:Pool_Rides/models/place.dart';
import 'package:Pool_Rides/models/suggestion.dart';
import 'package:Pool_Rides/services/place-service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import 'AddressSearch.dart';

class LocationPicker extends StatefulWidget {
  LocationPicker({Key key}) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
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
      final placeDetails = await PlaceApiProvider(sessionToken)
          .getPlaceDetailFromId(result.placeId);

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
              child: TextField(
                controller: _textController,
                onTap: searchLocation,
                focusNode: FocusNode(
                  canRequestFocus: false,
                  descendantsAreFocusable: false,
                  skipTraversal: false,
                ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.location_on),
                  contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                ),
              ),
            ),
            if (place != null)
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pop(place);
                  },
                  child: Icon(Icons.check),
                ),
              )
          ],
        ),
      ),
    );
  }
}
