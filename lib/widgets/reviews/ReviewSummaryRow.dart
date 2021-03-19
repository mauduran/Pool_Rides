import 'package:flutter/material.dart';

class ReviewSummaryRow extends StatelessWidget {
  final String title;
  final int amount;
  final int total;
  const ReviewSummaryRow({Key key, this.title, this.amount, this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 75,
            child: Text(title),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .50,
            child: LinearProgressIndicator(
              value: amount / total,
              backgroundColor: Color(0xFF9FB2C6),
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              "$amount",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
