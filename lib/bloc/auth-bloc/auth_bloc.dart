import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:pool_rides/services/auth-service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  UserAuthProvider _authProvider = UserAuthProvider();

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
    } else if (event is RegisterWithEmailEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.registerWithEmail(
            email: event.email, password: event.password, name: event.name);
        yield LoginSuccessState();
      } on FirebaseAuthException catch (e) {
        yield LoginErrorState(
            error: "Email o contraseña no válidos.", code: e.code);
      }
    }
  }
}
