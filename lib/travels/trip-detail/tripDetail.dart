import 'package:pool_rides/models/cars.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/user/user.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TripDetailPage extends StatefulWidget {
  final Trip tripDetail;
  final int cercania;

  TripDetailPage({
    Key key,
    @required this.tripDetail,
    @required this.cercania,
  }) : super(key: key);

  @override
  _TripDetailPageState createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  String dateToString(DateTime dt) {
    // String result = "${DateFormat.EEEE().format(dt).substring(0, 3)} ${dt.toString().split("-")[2].substring(0, 2)} ${DateFormat.MMMd().format(dt)}";
    String result = "${DateFormat.MMMMEEEEd().format(dt)}";
    // "${DateFormat.EEEE().format(dt).substring(0, 3)} ${DateFormat.MMMMd().format(dt)}";

    print(dt.toString().split("-")[2].substring(0, 2));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                    dateToString(widget.tripDetail.departureDate),
                    style: Theme.of(context).textTheme.headline4.copyWith(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            tripInformation(
              startTime: widget.tripDetail.startTime,
              originLocation: widget.tripDetail.origin.description,
              originName: widget.tripDetail.origin.city,
              cercania: widget.cercania,
              icon: Icons.hail,
            ),
            SizedBox(
              height: 20,
            ),
            tripInformation(
              startTime: widget.tripDetail.arrivalTime,
              originLocation: widget.tripDetail.destination.description,
              originName: widget.tripDetail.destination.city,
              cercania: widget.cercania,
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
                    "\$${widget.tripDetail.tripPrice.toString().substring(0, 6)}",
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
              user: widget.tripDetail.driver,
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
                  'Contactar a ${widget.tripDetail.driver.name}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    // color: Color(0xffe0e6eb),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  print("Hola");
                },
              ),
            ),
            if (widget.tripDetail.isCarSpecified)
              carInformation(
                car: widget.tripDetail.car,
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
            for (int i = 0; i < widget.tripDetail.passengers.length; i++)
              passengerBuilder(
                user: widget.tripDetail.passengers[i],
              ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 6,
              color: Colors.grey[500],
            ),
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
                          Navigator.of(context).pushNamed("/signin");
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
      ),
    );
  }

// ---------------------------------------------------
// ---------------------------------------------------
// --------------------- WIDGETS ---------------------
// ---------------------------------------------------
// ---------------------------------------------------

  Widget passengerBuilder({
    @required User user,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () {
          // To Do: Ir hacia perfil de usuario
          print(user.name);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UserDetail(
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
                        "${user.stars.toString().substring(0, 4)}/5 - ${user.reviewsNumber} reseña(s)", // To Do: agregar el atributo "No. de reseñas en conductor"
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
                    backgroundImage: NetworkImage(
                      user.image != ""
                          ? user.image
                          : "https://www.freeiconspng.com/thumbs/driver-icon/driver-icon-14.png",
                    ),
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
    @required Cars car,
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
              CircleAvatar(
                backgroundImage: NetworkImage(
                  car.image != ""
                      ? car.image
                      : "https://i.pinimg.com/originals/c0/0b/69/c00b692e9820c3970e907eae9bf2be25.png",
                ),
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
    );
  }

  Widget driverInformation({
    @required User user,
  }) {
    return GestureDetector(
      onTap: () {
        // To Do: Ir hacia perfil de usuario
        print(user.name);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserDetail(
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
                      "${user.stars.toString().substring(0, 4)}/5 - ${user.reviewsNumber} reseña(s)", // To Do: agregar el atributo "No. de reseñas en conductor"
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
                  backgroundImage: NetworkImage(
                    user.image != ""
                        ? user.image
                        : "https://www.freeiconspng.com/thumbs/driver-icon/driver-icon-14.png",
                  ),
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
    @required originLocation,
    @required originName,
    @required cercania,
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
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  originLocation,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.5,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  originName,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: cercania == 0
                            ? Colors.green[400]
                            : widget.cercania == 1
                                ? Colors.yellow[700]
                                : Color(0xFFff6257),
                      ),
                      child: Icon(
                        Icons.directions_walk,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "A 6 km de tu punto de salida",
                        style: TextStyle(
                          color: cercania == 0
                              ? Colors.green[400]
                              : widget.cercania == 1
                                  ? Colors.yellow[700]
                                  : Color(0xFFff6257),
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 27.5,
              ),
              onTap: () {
                // To Do: abrir el google maps
              },
            ),
          )
        ],
      ),
    );
  }
}
