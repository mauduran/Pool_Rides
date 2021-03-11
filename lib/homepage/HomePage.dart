import 'package:Pool_Rides/chat-detail/ChatDetailPage.dart';
import 'package:Pool_Rides/travels/TripCard.dart';
import 'package:Pool_Rides/travels/trip-detail/tripDetail.dart';
import 'package:Pool_Rides/utils/lists.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indexBottomBar = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatDetailPage(),
                ),
              );
            },
            icon: Icon(Icons.chat),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatDetailPage(),
              ),
            );
          },
          icon: Icon(
            Icons.account_circle,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    contentPadding: EdgeInsets.all(8),
                    focusedBorder: roundedInputBorder,
                    border: roundedInputBorder,
                    enabledBorder: roundedInputBorder),
              ),
              SizedBox(height: 20),
              for (int i = 0; i < trips.length; i++)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TripDetailPage(
                          tripDetail: trips[i],
                          cercania: (i % 3),
                        ),
                      ),
                    );
                  },
                  child: TripCard(
                    trip: trips[i],
                    cercania: (i % 3),
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/reviews');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            _indexBottomBar, // this will be set when a new tab is tapped
        onTap: (newCurrentIndex) {
          setState(() {
            _indexBottomBar = newCurrentIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Mis viajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          )
        ],
      ),
    );
  }
}
