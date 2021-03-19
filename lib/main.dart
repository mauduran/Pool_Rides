import 'package:pool_rides/Pages/session-pages/sign_in.dart';
import 'package:pool_rides/Pages/session-pages/sign_up.dart';
import 'package:pool_rides/Pages/session-pages/sign_up_2.dart';
import 'package:pool_rides/Pages/homepage/HomePage.dart';
import 'package:pool_rides/Pages/reviews/ReviewsPage.dart';
import 'package:pool_rides/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Pages/create-review/CreateReviewPage.dart';
import 'Pages/principal/principal.dart';
import 'Pages/principal/principal_signin.dart';
import 'Pages/search-trip-page/SearchTripPage.dart';
import 'Pages/location-picker/LocationPickerPage.dart';

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
        '/location-picker': (context) => LocationPickerPage(),
        '/search-trip': (conext) => SearchTripPage()
      },
    );
  }
}
