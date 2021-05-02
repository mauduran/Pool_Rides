import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pool_rides/Pages/chat-detail/ChatDetailPage.dart';
import 'package:pool_rides/bloc/conversations-bloc/conversations_bloc.dart';
import 'package:pool_rides/models/conversation-user.dart';
import 'package:pool_rides/models/conversation.dart';

class ConversationsPage extends StatefulWidget {
  final Conversation conversation;

  ConversationsPage({Key key, this.conversation}) : super(key: key);

  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  ConversationsBloc _bloc;

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
      body: BlocProvider(
        create: (context) {
          _bloc = ConversationsBloc()..add(GetUserConversationsEvent());
          return _bloc;
        },
        child: BlocConsumer<ConversationsBloc, ConversationsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ErrorState) {
              return Container(
                child: Center(
                  child: Text("No se pudieron obtener las conversaciones."),
                ),
              );
            } else if (state is OfflineConversationsState) {
              return Container(
                child: Center(
                  child:
                      Text("Aqui se deben mostrar las conversaciones offline"),
                ),
              );
            } else if (state is ConversationSnapshotsState) {
              return StreamBuilder(
                stream: state.conversationsQuery,
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

                  List<Conversation> convos =
                      items.map((e) => Conversation.fromJson(e.data())).toList()
                        ..sort((a, b) {
                          if (a.lastMessage == null && b.lastMessage == null) {
                            return a.dateOfCreation
                                .difference(b.dateOfCreation)
                                .inHours;
                          } else if (a.lastMessage == null) {
                            return a.dateOfCreation
                                .difference(b.lastMessage.date)
                                .inHours;
                          } else if (b.lastMessage == null) {
                            a.lastMessage.date
                                .difference(b.dateOfCreation)
                                .inHours;
                          }
                          return a.lastMessage.date
                              .difference(b.lastMessage.date)
                              .inHours;
                        });

                  return ConversationsList(
                    convos: convos,
                    userUid: state.user.uid,
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class ConversationsList extends StatelessWidget {
  const ConversationsList({
    Key key,
    @required this.convos,
    @required this.userUid,
  }) : super(key: key);

  final List<Conversation> convos;
  final String userUid;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 15),
      itemCount: convos.length,
      separatorBuilder: (BuildContext context, int idx) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Divider(
          thickness: 1,
          color: Theme.of(context).primaryColor,
        ),
      ),
      itemBuilder: (BuildContext context, int idx) {
        final conversation = convos[idx];
        final otherUser = conversation.members.values
            .firstWhere((element) => element.userId != userUid);
        return ConversationItem(
            conversation: conversation, otherUser: otherUser);
      },
    );
  }
}

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    Key key,
    @required this.conversation,
    @required this.otherUser,
  }) : super(key: key);

  final Conversation conversation;
  final ConversationUser otherUser;

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
