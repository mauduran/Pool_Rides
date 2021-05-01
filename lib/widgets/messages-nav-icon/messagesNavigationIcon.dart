import 'package:flutter/material.dart';
import 'package:pool_rides/Pages/conversations/ConversationsPage.dart';

class MessagesNavigationIcon extends StatefulWidget {
  MessagesNavigationIcon({Key key}) : super(key: key);

  @override
  _MessagesNavigationIconState createState() => _MessagesNavigationIconState();
}

class _MessagesNavigationIconState extends State<MessagesNavigationIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          icon: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.message),
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ConversationsPage(),
              ),
            );
          }),
    );
  }
}
