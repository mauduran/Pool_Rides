import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pool_rides/models/review.dart';
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
  int tripNumber;
  @HiveField(8)
  final DateTime joined;
  @HiveField(9)
  List<Review> reviews;
  @HiveField(10)
  Car car;

  User({
    @required this.name,
    @required this.biography,
    @required this.image,
    @required this.email,
    @required this.phoneNumber,
    @required this.age,
    @required this.tripNumber,
    @required this.joined,
    this.reviews = const [],
    @required this.car,
    @required this.birthdate,
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
    List<Review> reviews = (!parsedJson.containsKey('reviews'))
        ? []
        : (parsedJson['reviews'] as List<Map<String, dynamic>>)
            .map((e) => Review.fromJson(e));
    return new User(
      name: parsedJson['name'],
      biography: parsedJson['biography'],
      image: parsedJson['image'],
      email: parsedJson['email'],
      phoneNumber: parsedJson['phoneNumber'],
      age: parsedJson['age'],
      tripNumber: parsedJson['tripNumber'],
      joined: DateTime.parse(parsedJson['joined']),
      reviews: reviews,
      car: (parsedJson.containsKey('car'))
          ? Car.fromJson(parsedJson['car'])
          : null,
      birthdate: DateTime.parse(parsedJson['birthdate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "biography": biography,
      "image": image,
      "email": email,
      "phoneNumber": phoneNumber,
      "age": age,
      "tripNumber": tripNumber,
      "joined": joined.toIso8601String(),
      "reviews": reviews.map((e) => e.toMap()),
      "car": car.toMap(),
      "birthdate": birthdate.toIso8601String(),
    };
  }
}
