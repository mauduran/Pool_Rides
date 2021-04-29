import 'package:flutter/material.dart';
import 'package:pool_rides/Pages/create-trip/CreateTripPage.dart';
import 'package:pool_rides/Pages/search-trip-page/SearchTripPage.dart';
import 'package:pool_rides/Pages/trips/MyTrips.dart';
import 'package:pool_rides/Pages/user/userProfile.dart';
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
      length: 3,
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
                  builder: (context) => UserProfile(),
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
            SearchTripPage(),
            MyTrips(),
            CreateTripPage(),
          ],
        ),
        bottomNavigationBar: Material(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.search),
                child: Text(
                  'Buscar',
                ),
              ),
              Tab(
                icon: Icon(Icons.home),
                child: Text(
                  'Mis viajes',
                ),
              ),
              Tab(
                icon: Icon(Icons.add),
                child: Text(
                  'Nuevo Viaje',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
