import 'package:flutter/material.dart';
import 'package:pool_rides/models/review.dart';
import 'package:pool_rides/widgets/reviews/ReviewSummaryRow.dart';

class ReviewSummary extends StatelessWidget {
  final List<Review> reviews;
  const ReviewSummary({Key key, @required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, int> reviewDistribution = {
      "Excelente": 0,
      "Muy bien": 0,
      "Bien": 0,
      "Mal": 0,
      "Muy mal": 0
    };

    int numOfReviews = reviews.length;

    reviews.forEach((element) {
      reviewDistribution[element.rating]++;
    });
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
      child: Column(
        children: [
          ReviewSummaryRow(
            title: "Excelente",
            amount: reviewDistribution['Excelente'],
            total: numOfReviews,
          ),
          ReviewSummaryRow(
            title: "Muy bien",
            amount: reviewDistribution['Muy bien'],
            total: numOfReviews,
          ),
          ReviewSummaryRow(
            title: "Bien",
            amount: reviewDistribution['Bien'],
            total: numOfReviews,
          ),
          ReviewSummaryRow(
            title: "Mal",
            amount: reviewDistribution['Mal'],
            total: numOfReviews,
          ),
          ReviewSummaryRow(
            title: "Muy mal",
            amount: reviewDistribution['Muy mal'],
            total: numOfReviews,
          ),
        ],
      ),
    );
  }
}
