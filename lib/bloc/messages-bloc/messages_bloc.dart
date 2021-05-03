import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:pool_rides/models/message.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/messages-service.dart';
import 'package:pool_rides/services/user-service.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(MessagesInitial());
  Box _myMessagesBox = Hive.box("Messages");
  Box _myUserBox = Hive.box("User");

  @override
  Stream<MessagesState> mapEventToState(
    MessagesEvent event,
  ) async* {
    if (event is GetMessagesEvent) {
      try {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          User user = await UserService().getCurrentUser(
            UserAuthProvider().getUid(),
            update: true,
          );

          Stream<QuerySnapshot> query =
              MessagesService().getMessages(event.conversationId);

          yield MessagesSnapshotsState(messagesQuery: query, user: user);
        } else {
          List<ChatMessage> messages =
              _myMessagesBox.get("${event.conversationId}");
          User user = _myUserBox.get("current_user");

          yield OfflineMessagesState(messages: messages, user: user);
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
