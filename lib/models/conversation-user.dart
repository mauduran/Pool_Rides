import 'package:flutter/foundation.dart';

class ConversationUser {
  final String userId;
  final String name;
  final String image;
  final String email;
  final String phoneNumber;

  ConversationUser({
    @required this.userId,
    @required this.name,
    @required this.image,
    @required this.email,
    @required this.phoneNumber,
  });
}
