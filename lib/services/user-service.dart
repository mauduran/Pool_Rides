import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pool_rides/models/user.dart';

class UserService {
  final _cFirestore = FirebaseFirestore.instance;
  User _currentUser;
  var userListener;

  static final UserService _userRepository = new UserService._internal();

  UserService._internal();
  factory UserService() {
    return _userRepository;
  }

  getCurrentUser(String currentUser) async {
    if (currentUser == null) await fetchCurrentUser(currentUser);
    return this._currentUser;
  }

  fetchCurrentUser(String uid) async {
    DocumentReference ref = _cFirestore.collection("users").doc(uid);

    DocumentSnapshot snapshot = await ref.get();

    userListener = ref.snapshots().listen((event) {
      _currentUser = User.fromJson(event.data());
    });

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

  createUserFromEmail(String uid, String email, String name, String image) {
    User newUser = User(email: email, joined: DateTime.now(), name: name);
  }

  removeCurrentUser() {
    userListener?.cancel();
    _currentUser = null;
  }
}
