import 'package:pool_rides/chat-detail/message/Message.dart';
import 'package:pool_rides/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageWithSep extends StatelessWidget {
  final ChatMessage message;
  const MessageWithSep({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 15, left: 10, right: 10),
            child: Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.blueGrey,
                      height: 36,
                      thickness: 2,
                    )),
              ),
              Text(
                (DateTime.now().difference(message.date).inDays == 0)
                    ? "Hoy"
                    : (DateTime.now().difference(message.date).inDays.abs() < 7)
                        ? DateFormat("EEEE").format(message.date)
                        : DateFormat("dd/MM/yyyy").format(message.date),
                textAlign: TextAlign.center,
                style: TextStyle(
                  backgroundColor: Colors.white,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(
                      color: Colors.blueGrey,
                      height: 36,
                      thickness: 2,
                    )),
              ),
            ])),
        Message(message: message)
      ],
    );
  }
}
