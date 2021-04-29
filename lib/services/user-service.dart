import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pool_rides/models/user.dart';

class UserService {
  final _cFirestore = FirebaseFirestore.instance;
  User _currentUser;

  static final UserService _userRepository = new UserService._internal();

  UserService._internal();
  factory UserService() {
    return _userRepository;
  }

  Future<User> getCurrentUser(String uid, {bool update = false}) async {
    if (_currentUser == null || update)
      _currentUser = await fetchCurrentUser(uid);
    return _currentUser;
  }

  fetchCurrentUser(String uid) async {
    DocumentReference ref = _cFirestore.collection("users").doc(uid);

    DocumentSnapshot snapshot = await ref.get();

    if (!snapshot.exists) return null;

    return User.fromJson(snapshot.data());
  }

  existsUser(String uid) async {
    DocumentSnapshot snapshot =
        await _cFirestore.collection('users').doc(uid).get();
    return snapshot.exists;
  }

  createUserFromGoogle(
      String uid, String email, String name, String image, String phone) async {
    User newUser = User(
        uid: uid,
        email: email,
        joined: DateTime.now(),
        name: name,
        image: image,
        phoneNumber: phone);

    await _cFirestore.collection('users').doc(uid).set(newUser.toMap());
  }

  createUserFromEmail(String uid, String email, String name, DateTime birthdate,
      String phone, String title) async {
    DateTime now = DateTime.now();
    int age = (now.difference(birthdate).inDays / 365.25).floor();
    User newUser = User(
      uid: uid,
      email: email,
      joined: DateTime.now(),
      name: name,
      birthdate: birthdate,
      phoneNumber: phone,
      age: age,
    );
    await _cFirestore.collection('users').doc(uid).set(newUser.toMap());
  }

  removeCurrentUser() {
    _currentUser = null;
  }
}
