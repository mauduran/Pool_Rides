import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pool_rides/models/message.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/messages-service.dart';
import 'package:pool_rides/services/user-service.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(MessagesInitial());

  @override
  Stream<MessagesState> mapEventToState(
    MessagesEvent event,
  ) async* {
    if (event is GetMessagesEvent) {
      try {
        User user = await UserService().getCurrentUser(
          UserAuthProvider().getUid(),
          update: true,
        );

        //TODO: Check connectivity. If offline then get Hive conversations.
        // yield OfflineMessagesState(
        //     messages: messages, user: user);

        Stream<QuerySnapshot> query =
            MessagesService().getMessages(event.conversationId);

        yield MessagesSnapshotsState(messagesQuery: query, user: user);
      } catch (e) {
        yield ErrorState(
          error: "No se pudieron encontrar las conversaciones",
          code: "400",
        );
      }
    }
  }
}
