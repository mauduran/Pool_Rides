import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

enum LoginType { FACEBOOK, GOOGLE, EMAIL, NONE }

class UserAuthProvider {
  static final UserAuthProvider _singleton = UserAuthProvider._internal();

  factory UserAuthProvider() {
    return _singleton;
  }

  UserAuthProvider._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    "email",
    "https://www.googleapis.com/auth/userinfo.profile"
  ]);
  final FacebookLogin _facebookLogin = FacebookLogin();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LoginType userAuthType = LoginType.NONE;

  bool isLogged() {
    var user = _auth.currentUser;

    return user != null;
  }

  String getEmail() {
    if (isLogged()) {
      return _auth.currentUser.email;
    }
    return null;
  }

  String getPhotoUrl() {
    if (isLogged()) {
      return _auth.currentUser.photoURL;
    }
    return "https://www.freeiconspng.com/thumbs/driver-icon/driver-icon-14.png";
  }

  Future<void> signOutGoogle() async {
    if (userAuthType == LoginType.GOOGLE) {
      await _googleSignIn.signOut();
    }
  }

  Future<void> signOutFacebook() async {
    if (userAuthType == LoginType.FACEBOOK) {
      await _facebookLogin.logOut();
    }
  }

  Future<void> signOutFirebase() async {
    await _auth.signOut();
  }

  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await _auth.signInWithCredential(credential);
    userAuthType = LoginType.GOOGLE;
  }

  Future<void> signInWithFacebook() async {
    FacebookLoginResult _result = await _facebookLogin.logIn(['email']);

    switch (_result.status) {
      case FacebookLoginStatus.cancelledByUser:
        throw Exception("Operation Cancelled by user");
        break;
      case FacebookLoginStatus.error:
        throw Exception("Error logging in");
        break;
      case FacebookLoginStatus.loggedIn:
        FacebookAccessToken _token = _result.accessToken;
        AuthCredential credential =
            FacebookAuthProvider.credential(_token.token);
        await _auth.signInWithCredential(credential);
        userAuthType = LoginType.FACEBOOK;
    }
  }

  Future<void> registerWithEmail(
      {@required String email, String password, String name}) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _auth.currentUser.updateProfile(
      displayName: name,
      photoURL:
          "https://www.freeiconspng.com/thumbs/driver-icon/driver-icon-14.png",
    );

    userAuthType = LoginType.EMAIL;
  }

  Future<void> signInWithEmail(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    userAuthType = LoginType.EMAIL;
  }
}
