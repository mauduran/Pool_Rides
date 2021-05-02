import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pool_rides/bloc/messages-bloc/messages_bloc.dart';
import 'package:pool_rides/models/conversation-user.dart';
import 'package:pool_rides/models/message.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/messages-service.dart';
import 'package:pool_rides/widgets/message/MessageWithSep.dart';
import 'package:pool_rides/models/conversation.dart';
import 'package:flutter/material.dart';
import 'package:pool_rides/widgets/message/Message.dart';

class ChatDetailPage extends StatefulWidget {
  final Conversation conversation;
  ChatDetailPage({Key key, @required this.conversation}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  var origin = "";
  var destination = "";
  String currentUserUid;

  MessagesBloc _bloc;
  ConversationUser member;

  DateTime currentDate;

  final _messageInput = TextEditingController();
  @override
  void initState() {
    initializeDateFormatting();
    final conversation = widget.conversation;

    setState(() {
      currentUserUid = UserAuthProvider().getUid();
      origin = conversation.originCity;
      destination = conversation.destinationCity;
      member = conversation.members.values
          .firstWhere((element) => element.userId != currentUserUid);
    });

    super.initState();
  }

  void addMessage() {
    if (_messageInput.text.trim().length > 0) {
      MessagesService().addMessage(
          widget.conversation.conversationId, _messageInput.text.trim());
      setState(() {
        _messageInput.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _bloc = MessagesBloc()
          ..add(GetMessagesEvent(
              conversationId: widget.conversation.conversationId));
        return _bloc;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: ChatDetailBar(
              member: member, origin: origin, destination: destination),
        ),
        body: BlocConsumer<MessagesBloc, MessagesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ErrorState) {
              return Container(
                child: Center(
                  child: Text("No se pudieron obtener las conversaciones."),
                ),
              );
            } else if (state is OfflineMessagesState) {
              return Container(
                child: Center(
                  child:
                      Text("Aqui se deben mostrar las conversaciones offline"),
                ),
              );
            } else if (state is MessagesSnapshotsState) {
              return StreamBuilder(
                stream: state.messagesQuery,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      child: Center(
                        child: Text(snapshot.error.toString()),
                      ),
                    );
                  }
                  QuerySnapshot query = snapshot.data;

                  List<DocumentSnapshot> items = query.docs;

                  List<ChatMessage> messages =
                      items.map((e) => ChatMessage.fromJson(e.data())).toList();

                  return Column(
                    children: [
                      MessagesList(
                        messages: messages,
                        uid: state.user.uid,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, bottom: 10, top: 10, right: 10),
                        constraints:
                            BoxConstraints(minHeight: 60, maxHeight: 300),
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: _messageInput,
                                onSubmitted: (e) => addMessage(),
                                decoration: InputDecoration(
                                    hintText: "Write message...",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                addMessage();
                              },
                              child: Icon(
                                Icons.send,
                              ),
                              elevation: 0,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            }
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChatDetailBar extends StatelessWidget {
  const ChatDetailBar({
    Key key,
    @required this.member,
    @required this.origin,
    @required this.destination,
  }) : super(key: key);

  final ConversationUser member;
  final String origin;
  final String destination;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: (member.image != null && member.image != '')
              ? NetworkImage(member.image)
              : AssetImage('assets/images/avatar_placeholder.png'),
          maxRadius: 20,
        ),
        SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              member.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Text(
                  origin,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Icon(
                  Icons.arrow_right_alt,
                  size: 16,
                ),
                Text(
                  destination,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class MessagesList extends StatelessWidget {
  final List<ChatMessage> messages;
  final String uid;

  const MessagesList({Key key, @required this.messages, @required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentDate;
    return Container(
      child: Expanded(
        child: ListView.builder(
          itemCount: messages.length,
          shrinkWrap: true,
          reverse: true,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          itemBuilder: (context, index) {
            var message = messages.reversed.toList()[index];

            if (index == messages.length - 1 ||
                (messages.reversed
                        .toList()[index + 1]
                        .date
                        .difference(message.date)
                        .inDays
                        .abs()) !=
                    0) {
              currentDate = message.date;
              return MessageWithSep(message: message);
            }
            return Message(
              message: message,
              userUid: uid,
            );
          },
        ),
      ),
    );
  }
}
