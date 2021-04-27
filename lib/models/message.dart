import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 5, adapterName: "ChatMessageAdapter")
class ChatMessage {
  @HiveField(0)
  String messageContent;
  @HiveField(1)
  String messageSender;
  @HiveField(2)
  DateTime date;

  ChatMessage({
    @required this.messageContent,
    @required this.messageSender,
    @required this.date,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> parsedJson) {
    return new ChatMessage(
        date: DateTime.parse(parsedJson['date']),
        messageContent: parsedJson['content'],
        messageSender: parsedJson['sender']);
  }

  Map<String, dynamic> toMap() {
    return {
      "date": date.toIso8601String(),
      "sender": messageSender,
      "content": messageContent
    };
  }
}
