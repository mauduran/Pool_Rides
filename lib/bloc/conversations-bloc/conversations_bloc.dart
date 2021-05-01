import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  ConversationsBloc() : super(ConversationsInitial());

  @override
  Stream<ConversationsState> mapEventToState(
    ConversationsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
