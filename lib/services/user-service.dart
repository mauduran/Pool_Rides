import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pool_rides/models/user.dart';

class UserService {
  final _cFirestore = FirebaseFirestore.instance;
  User currentUser;
  var userListener;

  static final UserService _userRepository = new UserService._internal();

  UserService._internal();
  factory UserService() {
    return _userRepository;
  }

  getCurrentUser(String currentUser) async {
    if (currentUser == null) await fetchCurrentUser(currentUser);
    return this.currentUser;
  }

  fetchCurrentUser(String currentUser) async {
    QuerySnapshot result = await _cFirestore
        .collection("users")
        .where("email", isEqualTo: currentUser)
        .get();
    if (result.size == 0) return null;
    QueryDocumentSnapshot userSnapshot = result.docs[0];
    // this.userListener = userSnapshot.reference.snapshots().listen((event) {
    //   currentUser = User.fromJson(event.data());
    // });
    return User.fromJson(userSnapshot.data());
  }

  removeCurrentUser() {
    userListener?.cancel();
    currentUser = null;
  }
}
