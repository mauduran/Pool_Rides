import 'package:Pool_Rides/models/place.dart';
import 'package:flutter/material.dart';

class SearchTrip extends StatefulWidget {
  SearchTrip({Key key}) : super(key: key);

  @override
  _SearchTripState createState() => _SearchTripState();
}

class _SearchTripState extends State<SearchTrip> {
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  Place originPlace;
  Place destinationPlace;

  _getLocation({bool origin}) async {
    Place place =
        await Navigator.of(context).pushNamed("/location-picker") as Place;

    if (place != null) {
      if (origin) {
        _originController.text = place.description;
        setState(() {
          originPlace = place;
        });
      } else {
        _destinationController.text = place.description;
        setState(() {
          destinationPlace = place;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar Viaje"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "¿A dónde quieres ir?",
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextField(
                            controller: _originController,
                            onTap: () {
                              _getLocation(origin: true);
                            },
                            focusNode: FocusNode(
                              canRequestFocus: false,
                              descendantsAreFocusable: false,
                              skipTraversal: false,
                            ),
                            decoration: InputDecoration(
                              hintText: "Origen",
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Theme.of(context).primaryColor,
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 8.0, top: 16.0),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _destinationController,
                          onTap: () {
                            _getLocation(origin: true);
                          },
                          focusNode: FocusNode(
                            canRequestFocus: false,
                            descendantsAreFocusable: false,
                            skipTraversal: false,
                          ),
                          decoration: InputDecoration(
                            hintText: "Destino",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Theme.of(context).primaryColor,
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 8.0, top: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      final tempText = _originController.text;
                      _originController.text = _destinationController.text;
                      _destinationController.text = tempText;
                      final tempPlace = originPlace;

                      setState(() {
                        originPlace = destinationPlace;
                        destinationPlace = tempPlace;
                      });
                    },
                    child: Icon(
                      Icons.swap_calls,
                      color: Colors.white,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
