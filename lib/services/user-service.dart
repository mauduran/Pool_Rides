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

  getCurrentUser(String uid, {bool update = false}) async {
    if (_currentUser == null && !update)
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
        email: email,
        joined: DateTime.now(),
        name: name,
        image: image,
        phoneNumber: phone);

    await _cFirestore.collection('users').doc(uid).set(newUser.toMap());
  }

  createUserFromEmail(
      String uid, String email, String name, String image) async {
    User newUser = User(email: email, joined: DateTime.now(), name: name);
    await _cFirestore.collection('users').doc(uid).set(newUser.toMap());
  }

  removeCurrentUser() {
    _currentUser = null;
  }
}
