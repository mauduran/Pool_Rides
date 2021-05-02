part of 'messages_bloc.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}

class GetMessagesEvent extends MessagesEvent {
  final String conversationId;

  GetMessagesEvent({@required this.conversationId});
  List<Object> get props => [];
}
