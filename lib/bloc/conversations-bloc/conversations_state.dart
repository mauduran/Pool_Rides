part of 'conversations_bloc.dart';

abstract class ConversationsState extends Equatable {
  const ConversationsState();

  @override
  List<Object> get props => [];
}

class ConversationsInitial extends ConversationsState {}

class ErrorState extends ConversationsState {
  final String error;
  final String code;

  ErrorState({@required this.error, this.code = "400"});

  @override
  List<Object> get props => [error, code];
}

class LoadingState extends ConversationsState {}

class ConversationSnapshotsState extends ConversationsState {
  final Stream<QuerySnapshot> conversationsQuery;
  final User user;

  ConversationSnapshotsState({
    @required this.conversationsQuery,
    @required this.user,
  });
}

class OfflineConversationsState extends ConversationsState {
  final List<Conversation> conversations;
  final User user;

  OfflineConversationsState({
    @required this.conversations,
    @required this.user,
  });
}
