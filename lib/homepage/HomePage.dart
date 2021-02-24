import 'package:Pool_Rides/chat-detail/ChatDetailPage.dart';
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
            onPressed: () {},
            icon: Icon(Icons.chat),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: TextField(
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
              focusedBorder: RoundedInputBorder,
              border: RoundedInputBorder,
              enabledBorder: RoundedInputBorder),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatDetailPage(),
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
