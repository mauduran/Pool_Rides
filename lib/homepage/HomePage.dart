import 'package:Pool_Rides/chat-detail/ChatDetailPage.dart';
import 'package:Pool_Rides/travels/TravelCard.dart';
import 'package:Pool_Rides/travels/travel-detail/travelDetail.dart';
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
          )
        ],
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
              for (int i = 0; i < travels.length; i++)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TravelDetailPage(
                          cercania: (i % 3),
                          travelDetail: travels[i],
                        ),
                      ),
                    );
                  },
                  child: TravelCard(
                    travel: travels[i],
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
    );
  }
}
