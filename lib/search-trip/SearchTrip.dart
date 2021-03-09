import 'package:flutter/material.dart';

class SearchTrip extends StatefulWidget {
  SearchTrip({Key key}) : super(key: key);

  @override
  _SearchTripState createState() => _SearchTripState();
}

class _SearchTripState extends State<SearchTrip> {
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
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
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
              child: TextField(
                controller: _originController,
                // cursorColor: Colors.red,
                decoration: InputDecoration(
                  labelText: 'Email',
                  // errorText: 'Error message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  // enabledBorder: InputBorder()
                  // fillColor: Colors.grey[200],
                  // filled: true,
                  suffixIcon: Icon(
                    Icons.mail,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 20),
              child: TextField(
                controller: _destinationController,
                // cursorColor: Colors.red,
                decoration: InputDecoration(
                  labelText: 'Email',
                  // errorText: 'Error message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  // enabledBorder: InputBorder()
                  // fillColor: Colors.grey[200],
                  // filled: true,
                  suffixIcon: Icon(
                    Icons.mail,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
