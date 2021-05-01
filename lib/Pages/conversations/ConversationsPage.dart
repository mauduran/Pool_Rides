import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/Pages/chat-detail/ChatDetailPage.dart';
import 'package:pool_rides/models/conversation-user.dart';
import 'package:pool_rides/models/conversation.dart';
import 'package:pool_rides/utils/lists.dart';

class ConversationsPage extends StatefulWidget {
  final List<Conversation> conversationList = conversations;

  ConversationsPage({Key key}) : super(key: key);

  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  bool isLoading = false;

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
      body: showConversations(),
    );
  }

  showConversations() {
    if (isLoading)
      return Center(
        child: CircularProgressIndicator(),
      );

    return ListView.separated(
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
        return ConversationItem(
            conversation: conversation, otherUser: otherUser, widget: widget);
      },
      itemCount: widget.conversationList.length,
    );
  }
}

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    Key key,
    @required this.conversation,
    @required this.otherUser,
    @required this.widget,
  }) : super(key: key);

  final Conversation conversation;
  final ConversationUser otherUser;
  final ConversationsPage widget;

  @override
  Widget build(BuildContext context) {
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
                  : DateFormat.yMMMEd().format(conversation.lastMessage.date),
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
              backgroundImage:
                  (otherUser.image != null && otherUser.image != '')
                      ? NetworkImage(otherUser.image)
                      : AssetImage('assets/images/avatar_placeholder.png'),
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
              conversation: conversation,
            ),
          ),
        );
      },
    );
  }
}
