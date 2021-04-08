import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/review.dart';
import 'car.dart';

class User {
  String name;
  String biography;
  String image;
  String email;
  String password;
  String phoneNumber;
  int age;
  int tripNumber;
  int reviewsNumber;
  double stars;

  final DateTime joined;
  List<Review> reviews;
  Car car;
  User({
    @required this.name,
    @required this.biography,
    @required this.image,
    @required this.email,
    @required this.phoneNumber,
    @required this.age,
    @required this.tripNumber,
    @required this.reviewsNumber,
    @required this.stars,
    @required this.joined,
    @required this.reviews,
    this.car,
    this.password,
  });

  bool changePhoto(String url) {
    var currentPhoto = this.image;

    this.image = url;
    if (currentPhoto != this.image) {
      return true;
    }
    return false;
  }
}
