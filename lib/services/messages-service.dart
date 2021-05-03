import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:pool_rides/models/message.dart';
import 'package:pool_rides/models/conversation.dart';
import 'package:pool_rides/services/auth-service.dart';

class MessagesService {
  final _cFirestore = FirebaseFirestore.instance;

  static final MessagesService _messagesService =
      new MessagesService._internal();
  Box _myMessagesBox = Hive.box("Messages");
  Box _myConversationsBox = Hive.box("Conversations");

  MessagesService._internal();
  factory MessagesService() {
    return _messagesService;
  }

  Future<bool> addMessage(String conversationId, String message) async {
    try {
      final String uid = UserAuthProvider().getUid();

      ChatMessage msg = ChatMessage(
          messageContent: message.trim(),
          messageSender: uid,
          date: DateTime.now());

      DocumentReference ref =
          _cFirestore.collection('conversations').doc(conversationId);

      Map<String, dynamic> messageMap = msg.toMap();
      await ref.update({'lastMessage': messageMap});

      await ref.collection('messages').add(messageMap);
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot> getMessages(String conversationId) {
    try {
      return _cFirestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .orderBy('date')
          .snapshots();
    } catch (e) {
      return null;
    }
  }

  void saveMessages(List<ChatMessage> messages, String conversationId) {
    _myMessagesBox.put("$conversationId", messages);
  }

  void removeMessages() {
    List<Conversation> convs = _myConversationsBox.get("conversations");

    for (int i = 0; i < convs.length; i++) {
      _myMessagesBox.delete("${convs[i].conversationId}");
    }
  }
}
