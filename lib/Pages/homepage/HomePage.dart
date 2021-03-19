import 'package:flutter/material.dart';
import 'package:pool_rides/Pages/search-trip-page/SearchTripPage.dart';
import 'package:pool_rides/Pages/trips/MyTrips.dart';
import 'package:pool_rides/Pages/trips/Test.dart';
import 'package:pool_rides/Pages/user/userProfile.dart';
import 'package:pool_rides/utils/lists.dart';
import 'package:pool_rides/widgets/messages-nav-icon/messagesNavigationIcon.dart';

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
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          actions: [
            MessagesNavigationIcon(),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserProfile(user: users[0]),
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
            SearchTripPage(),
            Test(),
            Test(),
          ],
        ),
        bottomNavigationBar: Material(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                child: Text(
                  'Mis viajes',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Tab(
                icon: Icon(Icons.search),
                child: Text(
                  'Buscar',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Tab(
                icon: Icon(Icons.add),
                child: Text(
                  'Nuevo Viaje',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Tab(
                icon: Icon(Icons.person),
                child: Text(
                  'Perfil',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
