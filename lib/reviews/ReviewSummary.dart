import 'package:pool_rides/reviews/ReviewSummaryRow.dart';
import 'package:flutter/material.dart';

class ReviewSummary extends StatelessWidget {
  const ReviewSummary({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
      child: Column(
        children: [
          ReviewSummaryRow(
            title: "Excelente",
            amount: 35,
            total: 60,
          ),
          ReviewSummaryRow(
            title: "Muy bien",
            amount: 15,
            total: 60,
          ),
          ReviewSummaryRow(
            title: "Bien",
            amount: 8,
            total: 60,
          ),
          ReviewSummaryRow(
            title: "Mal",
            amount: 1,
            total: 60,
          ),
          ReviewSummaryRow(
            title: "Muy mal",
            amount: 1,
            total: 60,
          ),
        ],
      ),
    );
  }
}
