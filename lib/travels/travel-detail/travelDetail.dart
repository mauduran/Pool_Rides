import 'package:Pool_Rides/models/travel.dart';
import 'package:Pool_Rides/models/user.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TravelDetailPage extends StatefulWidget {
  final Travel travelDetail;
  final int cercania;

  TravelDetailPage({
    Key key,
    @required this.travelDetail,
    @required this.cercania,
  }) : super(key: key);

  @override
  _TravelDetailPageState createState() => _TravelDetailPageState();
}

class _TravelDetailPageState extends State<TravelDetailPage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  String dateToString(DateTime dt) {
    // String result = "${DateFormat.EEEE().format(dt).substring(0, 3)} ${dt.toString().split("-")[2].substring(0, 2)} ${DateFormat.MMMd().format(dt)}";
    String result =
        "${DateFormat.EEEE().format(dt).substring(0, 3)} ${DateFormat.MMMMd().format(dt)}";

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
                    dateToString(widget.travelDetail.departureDate),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            travelInformation(
              startTime: widget.travelDetail.startTime,
              sourceLocation: widget.travelDetail.sourceLocation,
              sourceName: widget.travelDetail.sourceName,
              cercania: widget.cercania,
              icon: Icons.hail,
            ),
            SizedBox(
              height: 20,
            ),
            travelInformation(
              startTime: widget.travelDetail.arrivalTime,
              sourceLocation: widget.travelDetail.destinyLocation,
              sourceName: widget.travelDetail.destinyName,
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
                    "\$${widget.travelDetail.priceTravel.toString().substring(0, 6)}",
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
              stars: widget.travelDetail.driver.stars,
              driverName: widget.travelDetail.driver.name,
              imageDriver: widget.travelDetail.driver.image,
              reviewsNumber: widget.travelDetail.driver.reviewsNumber,
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
                  'Contactar a ${widget.travelDetail.driver.name}',
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
            for (int i = 0; i < widget.travelDetail.passengers.length; i++)
              passengerBuilder(
                passenger: widget.travelDetail.passengers[i],
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

  Widget passengerBuilder({
    @required User passenger,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () {
          // To Do: Ir hacia perfil de usuario
          print(passenger.name);
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
                    passenger.name,
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
                        "${passenger.stars.toString().substring(0, 4)}/5 - ${passenger.reviewsNumber} reseña(s)", // To Do: agregar el atributo "No. de reseñas en conductor"
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
                      passenger.image != ""
                          ? passenger.image
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

  Widget driverInformation({
    @required driverName,
    @required stars,
    @required imageDriver,
    @required reviewsNumber,
  }) {
    return GestureDetector(
      onTap: () {
        // To Do: Ir hacia perfil de usuario
        print(driverName);
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
                  driverName,
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
                      "${stars.toString().substring(0, 4)}/5 - $reviewsNumber reseña(s)", // To Do: agregar el atributo "No. de reseñas en conductor"
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
                    imageDriver != ""
                        ? imageDriver
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

  Widget travelInformation({
    @required startTime,
    @required sourceLocation,
    @required sourceName,
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
                  sourceLocation,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.5,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  sourceName,
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
