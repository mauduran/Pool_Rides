import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/services/place-service.dart';
import 'package:pool_rides/utils/lists.dart';
import 'package:pool_rides/widgets/number-picker/NumberPicker.dart';
import 'package:pool_rides/utils/date.utils.dart';

class CreateTripPage extends StatefulWidget {
  CreateTripPage({Key key}) : super(key: key);

  @override
  _CreateTripPageState createState() => _CreateTripPageState();
}

class _CreateTripPageState extends State<CreateTripPage> {
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  DateFormat dateFormat;
  DateFormat timeFormat;
  DateTime tripDate = DateTime.now();
  Place originPlace;
  Place destinationPlace;
  int capacity = 1;
  double price = 300;

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMd('es');
    timeFormat = DateFormat("hh:mm aaa");
    _timeController.text = timeFormat.format(DateTime.now());
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  _createTrip() async {
    if (originPlace != null && destinationPlace != null) {
      int tripDuration = await PlaceApiProvider()
          .getTimeFromOriginToDest(originPlace, destinationPlace);

      DateTime arrivalDateTime =
          tripDate.copyWith().add(Duration(seconds: tripDuration));
      Trip newTrip = Trip(
        startTime: timeFormat.format(tripDate),
        arrivalTime: timeFormat.format(arrivalDateTime),
        departureDate: tripDate,
        destination: destinationPlace,
        driver: users[0],
        isCarSpecified: true,
        car: cars[0],
        origin: originPlace,
        passengerCapacity: capacity,
        tripPrice: price,
        passengers: [],
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text("Viaje creado."),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: "Aceptar",
            textColor: Colors.blue,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ));

      final newDate = DateTime.now();
      setState(() {
        tripDate = newDate;
        originPlace = null;
        destinationPlace = null;
        capacity = 1;
        price = 300;
        _originController.text = "";
        _destinationController.text = "";
        _timeController.text = timeFormat.format(newDate);
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
        tripDate = newDate.copyWith(
            year: newDate.year, month: newDate.month, day: newDate.day);
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: tripDate.hour, minute: tripDate.minute),
    );
    if (picked != null)
      setState(() {
        _timeController.text = timeFormat.format(
            tripDate.copyWith(hour: picked.hour, minute: picked.minute));
        tripDate = tripDate.copyWith(hour: picked.hour, minute: picked.minute);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            "Crear Viaje",
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 25,
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
                        padding: const EdgeInsets.only(bottom: 40),
                        child: GestureDetector(
                          onTap: () {
                            _getLocation(origin: true);
                          },
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            enabled: false,
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
                          controller: _destinationController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          enabled: false,
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
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              "¿Cuántos espacios libres tienes?",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker(
                  minValue: 1,
                  maxValue: 4,
                  currentValue: capacity,
                  subtract: () {
                    setState(() {
                      capacity--;
                    });
                  },
                  add: () {
                    setState(() {
                      capacity++;
                    });
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _selectDate,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[600],
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${(dateFormat == null || (DateTime.now().difference(tripDate).inDays.abs()) < 1) ? 'Hoy' : dateFormat.format(tripDate)}",
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
                InkWell(
                  onTap: _selectTime,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width / 3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              "Precio por asiento",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker(
                  minValue: 100,
                  maxValue: 1500,
                  currentValue: price.toInt(),
                  subtract: () {
                    setState(() {
                      price -= 10;
                    });
                  },
                  prefix: '\$',
                  suffix: '.00',
                  add: () {
                    setState(() {
                      price += 10;
                    });
                  }),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 90,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: _createTrip,
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
