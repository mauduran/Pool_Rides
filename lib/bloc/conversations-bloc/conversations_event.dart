part of 'conversations_bloc.dart';

abstract class ConversationsEvent extends Equatable {
  const ConversationsEvent();

  @override
  List<Object> get props => [];
}

class GetUserConversationsEvent extends ConversationsEvent {
  List<Object> get props => [];
}
