import 'package:Pool_Rides/route-locations/RouteLocations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CreateReviewPage extends StatefulWidget {
  CreateReviewPage({Key key}) : super(key: key);

  @override
  _CreateReviewPageState createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  final DateTime date = DateTime.now();
  DateFormat dateFormat;
  DateFormat timeFormat;
  String value = "excelente";

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('es');
    timeFormat = new DateFormat.Hm('es');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Crear Reseña"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 20, 32, 20),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/5.jpg",
                  ),
                  radius: 36,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Edgardo Rolas",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          Text(
            "${(dateFormat != null) ? dateFormat.format(date) : ''} - ${(timeFormat != null) ? timeFormat.format(date) : ''}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20.0, 40, 20),
            child: RouteLocations(
              origin: "San Luis Potosí, S.L.P.",
              destination: "Guadalajara, Jal.",
              spacing: 20,
            ),
          ),
          Text(
            "¿Cómo calificarías tu experiencia?",
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: DropdownButtonFormField(
              value: value,
              items: [
                DropdownMenuItem(
                  child: Text("Excelente"),
                  value: "excelente",
                ),
                DropdownMenuItem(
                  child: Text("Muy bien"),
                  value: "muy_bien",
                ),
                DropdownMenuItem(
                  child: Text("Bien"),
                  value: "bien",
                ),
                DropdownMenuItem(
                  child: Text("Mal"),
                  value: "mal",
                ),
                DropdownMenuItem(
                  child: Text("Muy mal"),
                  value: "muy_mal",
                ),
              ],
              onChanged: (val) {
                setState(() {
                  value = val;
                });
              },
            ),
          ),
          Text(
            "Describe tu experiencia",
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Ingrese breve descripción",
              ),
              keyboardType: TextInputType.multiline,
              minLines: 10,
              maxLines: 10,
              maxLength: 255,
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 25),
            child: MaterialButton(
              height: 50,
              minWidth: 330,
              onPressed: () {},
              color: Theme.of(context).primaryColor,
              child: Text(
                "Aceptar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
