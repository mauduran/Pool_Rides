import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'car.dart';

part 'user.g.dart';

@HiveType(typeId: 3, adapterName: "UserAdapter")
class User {
  @HiveField(0)
  String name;
  @HiveField(1)
  String biography;
  @HiveField(2)
  String image;
  @HiveField(3)
  String email;
  @HiveField(4)
  DateTime birthdate;
  @HiveField(5)
  String phoneNumber;
  @HiveField(6)
  int age;
  @HiveField(7)
  String tripNumber;
  @HiveField(8)
  final DateTime joined;
  @HiveField(9)
  Car car;
  @HiveField(10)
  String uid;
  @HiveField(11)
  int totalStars;
  @HiveField(12)
  int totalReviews;

  User({
    this.biography = "",
    this.image =
        "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png",
    this.phoneNumber,
    this.age,
    this.tripNumber,
    this.car,
    this.birthdate,
    this.totalStars = 0,
    this.totalReviews = 0,
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.joined,
  });

  bool changePhoto(String url) {
    var currentPhoto = this.image;

    this.image = url;
    if (currentPhoto != this.image) {
      return true;
    }
    return false;
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
        name: parsedJson['name'],
        uid: parsedJson['uid'],
        biography: parsedJson['biography'],
        image: parsedJson['image'],
        email: parsedJson['email'],
        phoneNumber: parsedJson['phoneNumber'],
        age: parsedJson['age'],
        tripNumber: parsedJson['tripNumber'],
        joined: DateTime.parse(parsedJson['joined']),
        car: (parsedJson.containsKey('car'))
            ? Car.fromJson(parsedJson['car'])
            : null,
        birthdate: (parsedJson['birthdate'] != '')
            ? DateTime.parse(parsedJson['birthdate'])
            : null,
        totalStars: parsedJson['totalStars'] ?? 0,
        totalReviews: parsedJson['totalReviews'] ?? 0);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> carMap = (car != null) ? car.toMap() : {};
    final String birthdateString =
        (birthdate != null) ? birthdate.toIso8601String() : '';

    return {
      "name": name,
      "uid": uid,
      "biography": biography,
      "image": image,
      "email": email,
      "phoneNumber": phoneNumber,
      "age": age,
      "tripNumber": tripNumber,
      "joined": joined.toIso8601String(),
      "car": carMap,
      "birthdate": birthdateString,
      "totalStars": totalStars,
      "totalReviews": totalReviews
    };
  }
}
