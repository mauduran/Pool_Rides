import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'conversation-user.dart';
import 'message.dart';

part 'conversation.g.dart';

@HiveType(typeId: 6, adapterName: "ConversationAdapter")
class Conversation {
  @HiveField(0)
  final String conversationId;
  @HiveField(1)
  Map<String, ConversationUser> members;
  @HiveField(2)
  final String originCity;
  @HiveField(3)
  final String destinationCity;
  @HiveField(4)
  final DateTime dateOfCreation;
  @HiveField(5)
  ChatMessage lastMessage;
  @HiveField(6)
  final String tripId;

  Conversation({
    this.conversationId,
    this.members = const {},
    @required this.originCity,
    @required this.destinationCity,
    @required this.dateOfCreation,
    @required this.tripId,
    this.lastMessage,
  });
  //Messages

  // void addMessage(String sender, String content) {
  //   ChatMessage message = ChatMessage(
  //       messageContent: content, messageSender: sender, date: DateTime.now());

  //   lastMessage = message;
  // }

  factory Conversation.fromJson(Map<String, dynamic> parsedJson) {
    Map<String, ConversationUser> members = {};

    if (parsedJson.containsKey('members')) {
      (parsedJson['members']).values.forEach((e) {
        ConversationUser convoUsr = ConversationUser.fromJson(e);
        members[convoUsr.userId] = convoUsr;
      });
    }

    return new Conversation(
      conversationId: parsedJson['conversationId'],
      dateOfCreation: DateTime.parse(parsedJson['dateOfCreation']),
      originCity: parsedJson['originCity'],
      tripId: parsedJson['tripId'],
      destinationCity: parsedJson['destinationCity'],
      lastMessage: (parsedJson.containsKey('lastMessage'))
          ? ChatMessage.fromJson(parsedJson['lastMessage'])
          : null,
      members: members,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {
      "conversationId": conversationId,
      "dateOfCreation": dateOfCreation.toIso8601String(),
      "originCity": originCity,
      "destinationCity": destinationCity,
      "tripId": tripId,
      "members": members.map((key, member) =>
          MapEntry<String, Map<String, dynamic>>(member.userId, member.toMap()))
    };

    if (lastMessage != null) {
      json.putIfAbsent('lastMessage', () => lastMessage.toMap());
    }

    return json;
  }
}
