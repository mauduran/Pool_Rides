import 'package:Pool_Rides/homepage/HomePage.dart';
import 'package:Pool_Rides/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pool Rides',
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(title: 'Pool Rides'),
      },
    );
  }
}
