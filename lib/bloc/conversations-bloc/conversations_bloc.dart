import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/conversation.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/conversations-service.dart';
import 'package:pool_rides/services/user-service.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  ConversationsBloc() : super(ConversationsInitial());

  @override
  Stream<ConversationsState> mapEventToState(
    ConversationsEvent event,
  ) async* {
    if (event is GetUserConversationsEvent) {
      try {
        User user = await UserService().getCurrentUser(
          UserAuthProvider().getUid(),
          update: true,
        );

        //TODO: Check connectivity. If offline then get Hive conversations.
        // Yield OfflineConversationsState
        // yield OfflineConversationsState(
        //     conversations: conversations, user: user);

        Stream<QuerySnapshot> query = ConversationsService().getConversations();

        yield ConversationSnapshotsState(conversationsQuery: query, user: user);
      } catch (e) {
        yield ErrorState(
          error: "No se pudieron encontrar las conversaciones",
          code: "400",
        );
      }
    }
  }
}
