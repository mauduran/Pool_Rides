import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/chat-detail/ChatDetailPage.dart';
import 'package:pool_rides/models/conversation.dart';
import 'package:pool_rides/utils/lists.dart';

class Conversations extends StatefulWidget {
  final List<Conversation> conversationList = conversations;

  Conversations({Key key}) : super(key: key);

  @override
  _ConversationsState createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Conversaciones"),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 15),
        separatorBuilder: (BuildContext context, int idx) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Divider(
            thickness: 1,
            color: Theme.of(context).primaryColor,
          ),
        ),
        itemBuilder: (BuildContext context, int idx) {
          final conversation = widget.conversationList[idx];
          final otherUser = conversation.members
              .firstWhere((element) => element.userId != 'mau4duran');
          return GestureDetector(
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      Text(
                        conversation.originCity,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Icon(
                        Icons.arrow_right_alt,
                        size: 16,
                      ),
                      Text(
                        conversation.destinationCity,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    otherUser.name,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
              subtitle: Text(
                (conversation.lastMessage == null)
                    ? DateFormat.yMMMEd().format(conversation.dateOfCreation)
                    : (DateTime.now()
                                .difference(conversation.lastMessage.date)
                                .inDays ==
                            0)
                        ? "Hoy"
                        : DateFormat.yMMMEd()
                            .format(conversation.lastMessage.date),
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(otherUser.image),
                    radius: 28,
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.navigate_next,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatDetailPage(
                    conversation: widget.conversationList[idx],
                  ),
                ),
              );
            },
          );
        },
        itemCount: widget.conversationList.length,
      ),
    );
  }
}
