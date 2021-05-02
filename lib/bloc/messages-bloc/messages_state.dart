part of 'messages_bloc.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

class MessagesInitial extends MessagesState {}

class LoadingState extends MessagesState {}

class MessagesSnapshotsState extends MessagesState {
  final Stream<QuerySnapshot> messagesQuery;
  final User user;

  MessagesSnapshotsState({
    @required this.messagesQuery,
    @required this.user,
  });
}

class OfflineMessagesState extends MessagesState {
  final List<ChatMessage> messages;
  final User user;

  OfflineMessagesState({
    @required this.messages,
    @required this.user,
  });
}

class ErrorState extends MessagesState {
  final String error;
  final String code;

  ErrorState({@required this.error, this.code = "400"});

  @override
  List<Object> get props => [error, code];
}
