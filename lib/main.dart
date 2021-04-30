import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pool_rides/Pages/session-pages/sign_in.dart';
import 'package:pool_rides/Pages/homepage/HomePage.dart';
import 'package:pool_rides/Pages/reviews/ReviewsPage.dart';
import 'package:pool_rides/SessionManager.dart';
import 'package:pool_rides/bloc/auth-bloc/auth_bloc.dart';
import 'package:pool_rides/theme.dart';
import 'Pages/create-review/CreateReviewPage.dart';
import 'Pages/principal/principal.dart';
import 'Pages/principal/principal_signin.dart';
import 'Pages/search-trip-page/SearchTripPage.dart';
import 'Pages/location-picker/LocationPickerPage.dart';
import 'models/car.dart';
import 'models/conversation-user.dart';
import 'models/conversation.dart';
import 'models/latilong.dart';
import 'models/message.dart';
import 'models/place.dart';
import 'models/review.dart';
import 'models/trip.dart';
import 'models/user.dart';

void main() async {
  Intl.defaultLocale = 'es_MX';

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final _localStorage = await getApplicationDocumentsDirectory();
  Hive
    ..init(_localStorage.path)
    ..registerAdapter(ReviewAdapter())
    ..registerAdapter(CarAdapter())
    ..registerAdapter(UserAdapter())
    ..registerAdapter(ConversationUserAdapter())
    ..registerAdapter(ChatMessageAdapter())
    ..registerAdapter(ConversationAdapter())
    ..registerAdapter(LatiLongAdapter())
    ..registerAdapter(PlaceAdapter())
    ..registerAdapter(TripAdapter());
  Hive.openBox("MyTrips");
  Hive.openBox("User");
  Hive.openBox("Conversations");

  runApp(BlocProvider(
    create: (context) => AuthBloc()..add(VerifyAuthEvent()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pool Rides',
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      home: SessionManager(),
      routes: {
        '/principal': (context) => Principal(),
        '/home': (context) => HomePage(title: 'Pool Rides'),
        '/principal-signin': (context) => PrincipalSignIn(),
        '/signin': (context) => SignIn(),
        '/location-picker': (context) => LocationPickerPage(),
        '/search-trip': (conext) => SearchTripPage()
      },
    );
  }
}
