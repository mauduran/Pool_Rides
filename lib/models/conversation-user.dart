import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'conversation-user.g.dart';

@HiveType(typeId: 4, adapterName: "ConversationUserAdapter")
class ConversationUser {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String phoneNumber;

  ConversationUser({
    @required this.userId,
    @required this.name,
    @required this.image,
    @required this.email,
    @required this.phoneNumber,
  });

  factory ConversationUser.fromJson(Map<String, dynamic> parsedJson) {
    return new ConversationUser(
      email: parsedJson['email'],
      image: parsedJson['image'],
      name: parsedJson['name'],
      phoneNumber: parsedJson['phoneNumber'],
      userId: parsedJson['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "image": image,
      "name": name,
      "phoneNumber": phoneNumber,
      "userId": userId,
    };
  }
}
