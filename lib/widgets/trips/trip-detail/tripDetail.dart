import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pool_rides/Pages/chat-detail/ChatDetailPage.dart';
import 'package:pool_rides/Pages/location-visualizer/location-visualizer.dart';
import 'package:pool_rides/Pages/user/user-passenger/passenger.dart';
import 'package:pool_rides/bloc/trip-detail-bloc/bloc/trip_detail_bloc.dart';
import 'package:pool_rides/models/car.dart';
import 'package:pool_rides/models/conversation.dart';
import 'package:pool_rides/models/place.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pool_rides/services/conversations-service.dart';

class TripDetailPage extends StatefulWidget {
  final Trip tripDetail;
  final double distanceOrigin;
  final double distanceDestination;
  final User user;
  TripDetailPage({
    Key key,
    @required this.tripDetail,
    @required this.distanceOrigin,
    @required this.distanceDestination,
    @required this.user,
  }) : super(key: key);

  @override
  _TripDetailPageState createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  int numOfReviews = 0;
  double averageRating = 0;

  TripDetailBloc _bloc;
  @override
  void initState() {
    super.initState();
    this.numOfReviews = widget.tripDetail.driver.totalReviews;
    this.averageRating = widget.tripDetail.driver.totalStars / numOfReviews;
    initializeDateFormatting();
  }

  String dateToString(DateTime dt) {
    String result = "${DateFormat.MMMMEEEEd().format(dt)}";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (context) {
            _bloc = TripDetailBloc();
            return _bloc;
          },
          child: BlocConsumer<TripDetailBloc, TripDetailState>(
            listener: (context, state) {
              if (state is ErrorState) {
                showErrorDialog(context, state);
              } else if (state is UserAddedSuccesfully) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text("Viaje registrado exitosamente"),
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: "Aceptar",
                        textColor: Colors.blue,
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
              }
            },
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserAddedSuccesfully) {
                return tripWidget(
                  trip: state.trip,
                  distDest: state.distanceDestination,
                  distOrigin: state.distanceOrigin,
                );
              }
              return tripWidget(
                trip: widget.tripDetail,
                distDest: widget.distanceDestination,
                distOrigin: widget.distanceOrigin,
              );
            },
          ),
        ));
  }

// ---------------------------------------------------
// ---------------------------------------------------
// --------------------- WIDGETS ---------------------
// ---------------------------------------------------
// ---------------------------------------------------

  Widget tripWidget({
    Trip trip,
    double distOrigin,
    double distDest,
  }) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  top: 10,
                ),
                child: Text(
                  dateToString(trip.departureDate),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          tripInformation(
            startTime: trip.startTime,
            location: trip.origin,
            distance: widget.distanceOrigin,
            salida: true,
            icon: Icons.hail,
          ),
          SizedBox(
            height: 20,
          ),
          tripInformation(
            startTime: trip.arrivalTime,
            location: trip.destination,
            distance: widget.distanceDestination,
            icon: Icons.place,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 6,
            color: Colors.grey[500],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Importe total para 1 pasajero: "),
                Text(
                  "\$${trip.tripPrice.floor().toString()}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 6,
            color: Colors.grey[500],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              bottom: 10,
            ),
            child: Text(
              "Conductor",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          driverInformation(
            user: trip.driver,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
            ),
            child: InkWell(
              child: new Text(
                'Contactar a ${trip.driver.name}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () async {
                Conversation conversation = await ConversationsService()
                    .createConversationIfNotExists(trip, trip.driver);

                if (conversation != null)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatDetailPage(
                        conversation: conversation,
                      ),
                    ),
                  );
                else
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text("No se puede contactar al usuario"),
                        duration: Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                          label: "Aceptar",
                          textColor: Colors.blue,
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                      ),
                    );
              },
            ),
          ),
          carInformation(
            car: trip.driver.car,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 6,
            color: Colors.grey[500],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              top: 10,
              bottom: 10,
            ),
            child: Text(
              "Pasajeros",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          for (int i = 0; i < trip.passengers.length; i++)
            passengerBuilder(
              user: trip.passengers[i],
            ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 6,
            color: Colors.grey[500],
          ),
          if ((trip.passengers.length < trip.passengerCapacity) &&
              widget.user.uid != trip.driver.uid &&
              trip.passengers.firstWhere(
                      (element) => element.uid == widget.user.uid,
                      orElse: () => null) ==
                  null)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            height: 40,
                            color: Color.fromARGB(255, 51, 174, 250),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Reservar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              _bloc.add(AddUserToTripEvent(
                                trip: trip,
                                distanceOrigin: distOrigin,
                                distanceDestination: distDest,
                              ));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future showErrorDialog(BuildContext context, ErrorState state) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Parece que algo ha salido mal: '),
            content: Text('${state.errorEasy}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Aceptar"),
              )
            ],
          );
        });
  }

  Widget passengerBuilder({
    @required User user,
  }) {
    int numOfReviews = user.totalReviews;
    double averageRating = user.totalStars / numOfReviews;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PassengerDetail(
                user: user,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 17.5,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        (numOfReviews > 0)
                            ? "${averageRating.toStringAsFixed(1)}/5 - $numOfReviews reseña(s)"
                            : "No tiene reseñas", // To Do: agregar el atributo "No. de reseñas en conductor"
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: (user.image != "" && user.image != null)
                        ? NetworkImage(
                            user.image,
                          )
                        : AssetImage('assets/images/avatar_placeholder.png'),
                    maxRadius: 22.5,
                    backgroundColor: Colors.grey[300],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 27.5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget carInformation({
    @required Car car,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                car.model,
                style: TextStyle(
                  fontSize: 17.5,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${car.color}", // To Do: agregar el atributo "No. de reseñas en conductor"
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: CircleAvatar(
                  backgroundImage: (car.image != "" && car.image != null)
                      ? NetworkImage(
                          car.image,
                        )
                      : AssetImage('assets/images/car_placeholder.jpeg'),
                  maxRadius: 22.5,
                  backgroundColor: Colors.grey[300],
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 27.5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget driverInformation({
    @required User user,
  }) {
    return GestureDetector(
      onTap: () {
        // To Do: Ir hacia perfil de usuario
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PassengerDetail(user: user),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 17.5,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      (numOfReviews > 0)
                          ? "${averageRating.toStringAsFixed(1)}/5 - $numOfReviews reseña(s)"
                          : "No tiene reseñas",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: (user.image != "" && user.image != null)
                      ? NetworkImage(
                          user.image,
                        )
                      : AssetImage('assets/images/avatar_placeholder.png'),
                  maxRadius: 22.5,
                  backgroundColor: Colors.grey[300],
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 27.5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget tripInformation({
    @required startTime,
    @required Place location,
    @required double distance,
    bool salida = false,
    @required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Text(
                    startTime,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  icon,
                  color: Colors.black,
                  size: 30,
                ),
              ],
            ),
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LocationVisualizerPage(
                      location: location,
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.5,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    location.city ?? location.state,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: distance <= 5
                              ? Colors.green[400]
                              : distance > 5 && distance <= 10
                                  ? Colors.yellow[700]
                                  : Color(0xFFff6257),
                        ),
                        child: Icon(
                          Icons.directions_walk,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: Text(
                          "A ${distance.toStringAsFixed(1)} km de tu punto de ${salida ? 'salida' : 'llegada'}",
                          style: TextStyle(
                            color: distance <= 5
                                ? Colors.green[400]
                                : distance > 5 && distance <= 10
                                    ? Colors.yellow[700]
                                    : Color(0xFFff6257),
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 27.5,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LocationVisualizerPage(
                      location: location,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
