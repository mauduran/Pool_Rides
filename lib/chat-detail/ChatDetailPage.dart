import 'package:Pool_Rides/models/message.dart';
import 'package:flutter/material.dart';

import 'message/Message.dart';

class ChatDetailPage extends StatefulWidget {
  ChatDetailPage({Key key}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatMessage> messages = [
    ChatMessage(
        messageContent: "Hello, Rolas",
        messageSender: "mau4duran",
        date: DateTime.now()),
    ChatMessage(
      messageContent: "How have you been?",
      messageSender: "mau4duran",
      date: DateTime.now(),
    ),
    ChatMessage(
      messageContent: "Hey Mau, I am doing fine dude. wbu?",
      messageSender: "rolas",
      date: DateTime.now(),
    ),
    ChatMessage(
      messageContent:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam convallis nibh non metus semper, eu congue tellus mollis. Vivamus euismod pretium leo quis feugiat. Morbi lobortis, eros id viverra aliquam, dolor neque gravida massa, et sollicitudin urna erat vel nunc. Sed posuere porttitor tincidunt. Vivamus suscipit sagittis elit vel ultrices. Sed tempus varius libero et vestibulum. Quisque ante enim, bibendum eu nunc ut, commodo tempor libero.",
      messageSender: "rolas",
      date: DateTime.now(),
    ),
    ChatMessage(
      messageContent: "Is there any thing wrong?",
      messageSender: "mau4duran",
      date: DateTime.now(),
    ),
  ];

  var origin = "Guadalajara";
  var destination = "San Luis Potosi";
  var conversationName = "Edgar Rolas";

  final ScrollController _scrollController = ScrollController();
  final _messageInput = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void addMessage() {
    if (_messageInput.text.trim().length > 0) {
      setState(() {
        messages.add(
          ChatMessage(
            messageContent: _messageInput.text.trim(),
            messageSender: 'mau4duran',
            date: DateTime.now(),
          ),
        );
        _messageInput.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        // centerTitle: true,
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
            // height: MediaQuery.of(context).size.height * .8,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              shrinkWrap: true,
              reverse: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                return Message(message: messages.reversed.toList()[index]);
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
