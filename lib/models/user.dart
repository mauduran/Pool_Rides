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

  User(
      {@required this.name,
      @required this.biography,
      @required this.image,
      @required this.email,
      @required this.phoneNumber,
      @required this.age,
      @required this.tripNumber,
      @required this.joined,
      this.reviews,
      this.car,
      @required this.birthdate});

  bool changePhoto(String url) {
    var currentPhoto = this.image;

    this.image = url;
    if (currentPhoto != this.image) {
      return true;
    }
    return false;
  }
}
