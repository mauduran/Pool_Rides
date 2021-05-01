import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/review.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';

class ReviewsService {
  final _cFirestore = FirebaseFirestore.instance;

  static final ReviewsService _reviewService = new ReviewsService._internal();

  ReviewsService._internal();
  factory ReviewsService() {
    return _reviewService;
  }

  final Map<String, int> ratingMapping = {
    'Excelente': 5,
    'Muy bien': 4,
    'Bien': 3,
    'Mal': 2,
    'Muy mal': 1
  };

  Future<bool> createReview({
    @required User reviewer,
    @required User reviewedUser,
    @required Trip trip,
    @required String rating,
    @required String description,
  }) async {
    try {
      final int stars =
          (ratingMapping.containsKey(rating)) ? ratingMapping[rating] : null;
      if (stars == null) return false;

      Review newReview = Review(
        reviewerName: reviewer.name,
        description: description,
        rating: rating,
        reviewerImage: reviewer.image,
        date: DateTime.now(),
        stars: stars,
      );

      DocumentReference ref =
          _cFirestore.collection('users').doc(reviewedUser.uid);
      await ref.update({
        'totalStars': FieldValue.increment(stars),
        'totalReviews': FieldValue.increment(1)
      });
      await ref.collection('reviews').add(newReview.toMap());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Review>> getUserReviews(String uid) async {
    final QuerySnapshot snapshot = await _cFirestore
        .collection('users')
        .doc(uid)
        .collection('reviews')
        .orderBy('date', descending: true)
        .get();

    if (snapshot.size == 0) return [];

    return snapshot.docs.map((e) => Review.fromJson(e.data())).toList();
  }
}
