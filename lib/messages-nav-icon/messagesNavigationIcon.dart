import 'package:flutter/material.dart';
import 'package:pool_rides/conversations/Conversations.dart';

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
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: new Text(
                    '2',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Conversations(),
              ),
            );
          }),
    );
  }
}
