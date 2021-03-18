import 'package:flutter/foundation.dart';

import 'conversation-user.dart';
import 'message.dart';

class Conversation {
  final String conversationId;
  final List<ConversationUser> members;
  final String originCity;
  final String destinationCity;
  final DateTime dateOfCreation;
  ChatMessage lastMessage;
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
