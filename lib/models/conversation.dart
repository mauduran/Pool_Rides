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
  final List<ConversationUser> members;
  @HiveField(2)
  final String originCity;
  @HiveField(3)
  final String destinationCity;
  @HiveField(4)
  final DateTime dateOfCreation;
  @HiveField(5)
  ChatMessage lastMessage;
  @HiveField(6)
  List<ChatMessage> messages;

  List<ChatMessage> get messageList => messages.reversed.toList();

  Conversation({
    @required this.conversationId,
    @required this.members,
    @required this.originCity,
    @required this.destinationCity,
    @required this.dateOfCreation,
    this.messages = const [],
    this.lastMessage,
  });

  void addMessage(String sender, String content) {
    ChatMessage message = ChatMessage(
        messageContent: content, messageSender: sender, date: DateTime.now());

    messages.add(message);
    lastMessage = message;
  }
}
