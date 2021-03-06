import 'package:pool_rides/Pages/trips/Trips.dart';
import 'package:pool_rides/models/place.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pool_rides/models/trip-query.dart';

class SearchTripPage extends StatefulWidget {
  SearchTripPage({Key key}) : super(key: key);

  @override
  _SearchTripPageState createState() => _SearchTripPageState();
}

class _SearchTripPageState extends State<SearchTripPage> {
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  DateFormat dateFormat;
  DateTime tripDate = DateTime.now();
  Place originPlace;
  Place destinationPlace;

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMd('es');
    super.initState();
  }

  void _searchTrips() {
    if (originPlace != null && destinationPlace != null) {
      final query = TripQuery(
          origin: originPlace, destination: destinationPlace, date: tripDate);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Trips(query: query)));
    }
  }

  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: tripDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 90)),
      helpText: 'Select a date',
    );

    if (newDate != null) {
      setState(() {
        tripDate = newDate;
      });
    }
  }

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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "¿A dónde quieres ir?",
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: GestureDetector(
                          onTap: () {
                            _getLocation(origin: true);
                          },
                          child: TextField(
                            enabled: false,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: _originController,
                            focusNode: FocusNode(
                              canRequestFocus: false,
                              descendantsAreFocusable: false,
                              skipTraversal: false,
                            ),
                            enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              hintText: "Origen",
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Theme.of(context).primaryColor,
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 8.0, top: 16.0, bottom: 12),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _getLocation(origin: false);
                        },
                        child: TextField(
                          enabled: false,
                          controller: _destinationController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onTap: () {
                            _getLocation(origin: false);
                          },
                          focusNode: FocusNode(
                            canRequestFocus: false,
                            descendantsAreFocusable: false,
                            skipTraversal: false,
                          ),
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                            hintText: "Destino",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Theme.of(context).primaryColor,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 8.0,
                              top: 16.0,
                              bottom: 12,
                            ),
                          ),
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
                  heroTag: "switch",
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
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: _selectDate,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[600],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${(dateFormat == null || (dateFormat.format(DateTime.now()) == dateFormat.format(tripDate))) ? 'Hoy' : dateFormat.format(tripDate)}",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.date_range_outlined,
                    size: 24,
                  )
                ],
              ),
            ),
          ),
          Spacer(
            flex: 2,
          ),
          SizedBox(
            width: double.infinity,
            height: 90,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: _searchTrips,
                child: Text(
                  "Buscar Viaje",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
