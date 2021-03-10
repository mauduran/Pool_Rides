import 'package:Pool_Rides/models/review.dart';
import 'package:flutter/foundation.dart';

class User {
  final String name;
  final String biography;
  final String image;
  final int age;
  final int travelsNumber;
  final int reviewsNumber;
  final double stars;

  final DateTime joined;
  final List<Review> reviews;
  User({
    @required this.name,
    @required this.biography,
    @required this.image,
    @required this.age,
    @required this.travelsNumber,
    @required this.reviewsNumber,
    @required this.stars,
    @required this.joined,
    @required this.reviews,
  });
}
