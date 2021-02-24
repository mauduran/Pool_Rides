import 'package:Pool_Rides/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Message extends StatelessWidget {
  final ChatMessage message;
  const Message({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 5),
      child: Align(
        widthFactor: 1,
        alignment: (message.messageSender == "mau4duran"
            ? Alignment.topRight
            : Alignment.topLeft),
        child: Column(
          crossAxisAlignment: (message.messageSender == "mau4duran"
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start),
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (message.messageSender == "mau4duran"
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade200),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message.messageContent,
                style: (message.messageSender == "mau4duran"
                    ? Theme.of(context).accentTextTheme.bodyText1
                    : Theme.of(context).textTheme.bodyText1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                DateFormat("dd/MM/yyyy  HH:mm").format(message.date),
                style: Theme.of(context).textTheme.caption,
              ),
            )
          ],
        ),
      ),
    );
  }
}
