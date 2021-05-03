import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pool_rides/models/conversation.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/conversations-service.dart';
import 'package:pool_rides/services/user-service.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  ConversationsBloc() : super(ConversationsInitial());

  Box _myUserBox = Hive.box("User");
  Box _myConversationsBox = Hive.box("Conversations");

  @override
  Stream<ConversationsState> mapEventToState(
    ConversationsEvent event,
  ) async* {
    if (event is GetUserConversationsEvent) {
      try {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          User user = await UserService().getCurrentUser(
            UserAuthProvider().getUid(),
            update: true,
          );
          Stream<QuerySnapshot> query =
              ConversationsService().getConversations();

          yield ConversationSnapshotsState(
              conversationsQuery: query, user: user);
        } else {
          List<Conversation> convs = _myConversationsBox.get("conversations");

          convs.sort((a, b) {
            if (a.lastMessage == null && b.lastMessage == null) {
              return a.dateOfCreation.difference(b.dateOfCreation).inHours;
            } else if (a.lastMessage == null) {
              return a.dateOfCreation.difference(b.lastMessage.date).inHours;
            } else if (b.lastMessage == null) {
              a.lastMessage.date.difference(b.dateOfCreation).inHours;
            }
            return a.lastMessage.date.difference(b.lastMessage.date).inHours;
          });
          User user = _myUserBox.get("current_user");
          yield OfflineConversationsState(conversations: convs, user: user);
        }
      } catch (e) {
        yield ErrorState(
          error: "No se pudieron encontrar las conversaciones",
          code: "400",
        );
      }
    }
  }
}
