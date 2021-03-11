import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/review.dart';
import 'cars.dart';

class User {
  final String name;
  final String biography;
  final String image;
  final String email;
  final String phoneNumber;
  final int age;
  final int tripNumber;
  final int reviewsNumber;
  final double stars;

  final DateTime joined;
  final List<Review> reviews;
  final List<Cars> cars;
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
    @required this.cars,
  });
}
