import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pool_rides/models/user.dart' as UserModel;
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/user-service.dart';
import 'package:pool_rides/services/messages-service.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  UserAuthProvider _authProvider = UserAuthProvider();
  UserModel.User currentUser;
  String registerName;
  String registerEmail;
  String registerPassword;

  Box _myTripsBox = Hive.box("MyTrips");
  Box _userBox = Hive.box("User");
  Box _myConversationsBox = Hive.box("Conversations");

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is VerifyAuthEvent) {
      // requests a APIs
      // acceso a BD locales
      // revisar acceso a internet
      // lo que debamos hacer para inicializar datos de la app
      if (_authProvider.isLogged())
        yield AlreadyAuthState();
      else
        yield UnAuthState();
    } else if (event is SignOutAuthEvent) {
      _myTripsBox.delete("trips");
      _userBox.delete("current_user");
      _myConversationsBox.delete("conversations");
      MessagesService().removeMessages();
      print("\n");
      print("trips:");

      print(_myTripsBox.containsKey('trips'));
      print("current_user:");

      print(_userBox.containsKey('current_user'));
      print("conversations:");

      print(_myConversationsBox.containsKey('conversations'));

      UserService().removeCurrentUser();
      _authProvider
        ..signOutFirebase()
        ..signOutGoogle()
        ..signOutFacebook();
      _authProvider.userAuthType = LoginType.NONE;
      yield UnAuthState();
    } else if (event is LoginWithGoogleEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.signInWithGoogle();
        yield LoginSuccessState();
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(error: "Error al iniciar sesión");
      }
    } else if (event is LoginWithFacebookEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.signInWithFacebook();
        yield LoginSuccessState();
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(error: "Error al iniciar sesión");
      }
    } else if (event is LoginWithEmailEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.signInWithEmail(event.email, event.password);
        yield LoginSuccessState();
      } on FirebaseAuthException catch (e) {
        yield LoginErrorState(error: e.code);
      }
    } else if (event is ShowRegisterPageEvent) {
      registerName = null;
      registerEmail = null;
      registerPassword = null;
      yield RegisterPageState();
    } else if (event is ShowRegister2PageEvent) {
      registerName = event.name;
      registerEmail = event.email;
      registerPassword = event.password;
      yield RegisterPage2State();
    } else if (event is CancelRegisterEvent) {
      yield LoggedOutState();
    } else if (event is RegisterWithEmailEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.registerWithEmail(
          email: registerEmail,
          password: registerPassword,
          name: registerName,
          birthdate: event.birthdate,
          phone: event.phone,
          title: event.title,
        );

        registerName = null;
        registerEmail = null;
        registerPassword = null;
        yield LoginSuccessState();
      } on FirebaseAuthException catch (e) {
        yield LoginErrorState(
            error: "No se pudo completar registro", code: e.code);
      } on Exception catch (e) {
        print(e);
        yield LoginErrorState(
            error: "No se pudo completar registro", code: '400');
      }
    }
  }
}
