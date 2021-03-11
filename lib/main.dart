import 'package:pool_rides/create-review/CreateReviewPage.dart';
import 'package:pool_rides/homepage/HomePage.dart';
import 'package:pool_rides/principal/principal.dart';
import 'package:pool_rides/principal/principal_signin.dart';
import 'package:pool_rides/search-trip/SearchTrip.dart';
import 'package:pool_rides/session/sign_in.dart';
import 'package:pool_rides/session/sign_up.dart';
import 'package:pool_rides/session/sign_up_2.dart';
import 'package:pool_rides/reviews/ReviewsPage.dart';
import 'package:pool_rides/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'location-picker/LocationPicker.dart';

void main() {
  Intl.defaultLocale = 'es_MX';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pool Rides',
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/': (context) => Principal(),
        '/home': (context) => HomePage(title: 'Pool Rides'),
        '/principal-signin': (context) => PrincipalSignIn(),
        '/signup': (context) => SignUp(),
        '/signup2': (context) => SignUp2(),
        '/signin': (context) => SignIn(),
        '/reviews': (context) => ReviewsPage(),
        '/make-review': (context) => CreateReviewPage(),
        '/location-picker': (context) => LocationPicker(),
        '/search-trip': (conext) => SearchTrip()
      },
    );
  }
}
