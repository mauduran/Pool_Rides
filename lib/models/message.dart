import 'package:flutter/foundation.dart';

class ChatMessage {
  String messageContent;
  String messageSender;
  DateTime date;
  ChatMessage({
    @required this.messageContent,
    @required this.messageSender,
    @required this.date,
  });
}
