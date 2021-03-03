import 'package:Pool_Rides/create-review/CreateReviewPage.dart';
import 'package:Pool_Rides/homepage/HomePage.dart';
import 'package:Pool_Rides/principal/principal.dart';
import 'package:Pool_Rides/principal/principal_signin.dart';
import 'package:Pool_Rides/session/sign_in.dart';
import 'package:Pool_Rides/session/sign_up.dart';
import 'package:Pool_Rides/session/sign_up_2.dart';
import 'package:Pool_Rides/reviews/ReviewsPage.dart';
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
      initialRoute: '/home',
      routes: {
        '/': (context) => Principal(),
        '/home': (context) => HomePage(title: 'Pool Rides'),
        '/PrincipalSignIn': (context) => PrincipalSignIn(),
        '/SignUp': (context) => SignUp(),
        '/SignUp2': (context) => SignUp2(),
        '/SignIn': (context) => SignIn(),
        '/reviews': (context) => ReviewsPage(),
        '/make-review': (context) => CreateReviewPage()
      },
    );
  }
}
