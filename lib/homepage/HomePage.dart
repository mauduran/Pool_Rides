import 'package:pool_rides/MyTrips/MyTrips.dart';
import 'package:pool_rides/MyTrips/Test.dart';
import 'package:pool_rides/chat-detail/ChatDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:pool_rides/search-trip/SearchTrip.dart';
import 'package:pool_rides/user/user.dart';
import 'package:pool_rides/utils/lists.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatDetailPage(),
                  ),
                );
              },
              icon: Icon(Icons.chat),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserDetail(user: users[0]),
                ),
              );
            },
            icon: Icon(
              Icons.account_circle,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            MyTrips(),
            SearchTrip(),
            Test(),
          ],
        ),
        bottomNavigationBar: Material(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                child: Text('Mis viajes'),
              ),
              Tab(
                icon: Icon(Icons.search),
                child: Text('Buscar'),
              ),
              Tab(
                icon: Icon(Icons.person),
                child: Text('Perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
