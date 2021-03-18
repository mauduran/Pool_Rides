import 'package:intl/date_symbol_data_local.dart';
import 'package:pool_rides/chat-detail/message/MessageWithSep.dart';
import 'package:pool_rides/models/conversation.dart';
import 'package:flutter/material.dart';

import 'message/Message.dart';

class ChatDetailPage extends StatefulWidget {
  final Conversation conversation;
  ChatDetailPage({Key key, @required this.conversation}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  var origin = "";
  var destination = "";
  var conversationName = "";
  final currentUserId = 'mau4duran';

  DateTime currentDate;

  final ScrollController _scrollController = ScrollController();
  final _messageInput = TextEditingController();
  @override
  void initState() {
    initializeDateFormatting();
    final conversation = widget.conversation;
    origin = conversation.originCity;
    destination = conversation.destinationCity;
    conversationName = conversation.members
        .firstWhere((element) => element.userId != currentUserId)
        .name;

    super.initState();
  }

  void addMessage() {
    if (_messageInput.text.trim().length > 0) {
      setState(() {
        widget.conversation
            .addMessage(currentUserId, _messageInput.text.trim());
        _messageInput.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              backgroundImage:
                  NetworkImage("https://randomuser.me/api/portraits/men/5.jpg"),
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
                  conversationName,
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
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.conversation.messages.length,
              shrinkWrap: true,
              reverse: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                var message =
                    widget.conversation.messages.reversed.toList()[index];

                if (index == widget.conversation.messages.length - 1 ||
                    (widget.conversation.messages.reversed
                            .toList()[index + 1]
                            .date
                            .difference(message.date)
                            .inDays
                            .abs()) !=
                        0) {
                  currentDate = message.date;
                  return MessageWithSep(message: message);
                }
                return Message(message: message);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
            constraints: BoxConstraints(minHeight: 60, maxHeight: 300),
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
          ),
        ],
      ),
    );
  }
}
