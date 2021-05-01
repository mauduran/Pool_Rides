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
  String image;
  @HiveField(2)
  String email;
  @HiveField(3)
  DateTime birthdate;
  @HiveField(4)
  String phoneNumber;
  @HiveField(5)
  int age;
  @HiveField(6)
  final DateTime joined;
  @HiveField(7)
  Car car;
  @HiveField(8)
  String uid;
  @HiveField(9)
  int totalStars;
  @HiveField(10)
  int totalReviews;

  User({
    this.biography = "",
    this.image,
    this.phoneNumber,
    this.age,
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
      "joined": joined.toIso8601String(),
      "car": carMap,
      "birthdate": birthdateString,
      "totalStars": totalStars,
      "totalReviews": totalReviews
    };
  }
}
