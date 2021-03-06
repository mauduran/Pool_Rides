import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:pool_rides/models/conversation-user.dart';
import 'package:pool_rides/models/conversation.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/user-service.dart';

class ConversationsService {
  final _cFirestore = FirebaseFirestore.instance;

  static final ConversationsService _conversationService =
      new ConversationsService._internal();
  static Box _myConversationsBox = Hive.box("Conversations");
  ConversationsService._internal();
  factory ConversationsService() {
    return _conversationService;
  }

  Future<Conversation> createConversationIfNotExists(
      Trip trip, User user) async {
    try {
      final String uid = UserAuthProvider().getUid();
      User currentUser = await UserService().getCurrentUser(uid);

      String passenger = (trip.driver.uid != uid) ? uid : user.uid;

      String conversationId = "${trip.tripId}-$passenger";

      DocumentReference ref =
          _cFirestore.collection('conversations').doc(conversationId);

      DocumentSnapshot convoSnapshot = await ref.get();

      if (convoSnapshot.exists) {
        Map<String, dynamic> data = convoSnapshot.data();
        Conversation existingConversation = Conversation.fromJson(data);
        return existingConversation;
      }

      Conversation conversation = Conversation(
        conversationId: conversationId,
        dateOfCreation: DateTime.now(),
        destinationCity: trip.destination.city ?? trip.destination.state,
        originCity: trip.origin.city ?? trip.origin.state,
        tripId: trip.tripId,
      );

      final convoUser = ConversationUser(
        userId: user.uid,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
      );

      final convoCurrentUser = ConversationUser(
        userId: currentUser.uid,
        name: currentUser.name,
        email: currentUser.email,
        phoneNumber: currentUser.phoneNumber,
      );

      conversation.members = {
        convoCurrentUser.userId: convoCurrentUser,
        convoUser.userId: convoUser
      };

      Map<String, dynamic> conversationMap = conversation.toMap();

      await ref.set(conversationMap);

      return conversation;
    } catch (e) {
      return null;
    }
  }

  Stream<QuerySnapshot> getConversations() {
    try {
      String uid = UserAuthProvider().getUid();

      return _cFirestore
          .collection('conversations')
          .where('members.$uid.userId', isEqualTo: uid)
          .snapshots();
    } catch (e) {
      return null;
    }
  }

  static void saveConversations(List<Conversation> convs) {
    _myConversationsBox.put("conversations", convs);
  }
}
