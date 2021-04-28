import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pool_rides/Pages/homepage/HomePage.dart';
import 'package:pool_rides/Pages/loading-page/LoadingPage.dart';
import 'package:pool_rides/Pages/principal/principal.dart';
import 'package:pool_rides/Pages/principal/principal_signin.dart';
import 'package:pool_rides/Pages/session-pages/sign_up.dart';
import 'package:pool_rides/Pages/session-pages/sign_up_2.dart';
import 'package:pool_rides/Pages/splash-screen/SplashScreen.dart';
import 'package:pool_rides/bloc/auth-bloc/auth_bloc.dart';

class SessionManager extends StatefulWidget {
  SessionManager({Key key}) : super(key: key);

  @override
  _SessionManagerState createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("Login Error"),
                content: Text("${state.error}"),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  )
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state is AlreadyAuthState || state is LoginSuccessState) {
          return HomePage(title: "Pool Rides");
        } else if (state is UnAuthState) {
          return Principal();
        } else if (state is LoggedOutState || state is LoginErrorState) {
          return PrincipalSignIn();
        } else if (state is LoginLoadingState) {
          return LoadingPage();
        } else if (state is RegisterPageState) {
          return SignUp();
        } else if (state is RegisterPage2State) {
          return SignUp2();
        }
        return SplashScreen();
      },
    );
  }
}
