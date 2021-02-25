import 'package:flutter/foundation.dart';

class Review {
  final String reviewerName;
  final String description;
  final String rating;
  final String reviewerImage;
  final DateTime date;
  Review({
    @required this.reviewerName,
    @required this.description,
    @required this.rating,
    @required this.reviewerImage,
    @required this.date,
  });
}
