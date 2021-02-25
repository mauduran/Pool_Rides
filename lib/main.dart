import 'package:Pool_Rides/homepage/HomePage.dart';
import 'package:Pool_Rides/principal/principal.dart';
import 'package:Pool_Rides/session/sign_up.dart';
import 'package:Pool_Rides/session/sign_up_2.dart';
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
        '/': (context) => Principal(),
        '/HomePage': (context) => HomePage(title: 'Pool Rides'),
        '/SignUp': (context) => SignUp(),
        '/SignUp2': (context) => SignUp2(),
      },
    );
  }
}
