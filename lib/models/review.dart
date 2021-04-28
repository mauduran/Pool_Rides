import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'review.g.dart';

@HiveType(typeId: 1, adapterName: "ReviewAdapter")
class Review {
  @HiveField(0)
  final String reviewerName;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String rating;
  @HiveField(3)
  final String reviewerImage;
  @HiveField(4)
  final DateTime date;
  @HiveField(5)
  final int stars;
  Review({
    @required this.reviewerName,
    @required this.description,
    @required this.rating,
    @required this.reviewerImage,
    @required this.date,
    @required this.stars,
  });

  factory Review.fromJson(Map<String, dynamic> parsedJson) {
    return new Review(
      reviewerName: parsedJson['reviewerName'],
      description: parsedJson['description'],
      rating: parsedJson['rating'],
      reviewerImage: parsedJson['reviewerImage'],
      date: DateTime.parse(parsedJson['date']),
      stars: parsedJson['stars'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "reviewerName": reviewerName,
      "description": description,
      "rating": rating,
      "reviewerImage": reviewerImage,
      "date": date.toIso8601String(),
      "stars": stars,
    };
  }
}
