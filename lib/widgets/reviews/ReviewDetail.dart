import 'package:pool_rides/models/review.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewDetail extends StatelessWidget {
  final Review review;
  const ReviewDetail({Key key, @required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 15, 10),
          color: Color(0xFFEFF2F6),
          child: Stack(
            children: [
              Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 5),
                    Text(
                      review.rating,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      review.description,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      DateFormat("MMM 'de' yyyy").format(review.date),
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundImage: (review.reviewerImage != null &&
                          review.reviewerImage != '')
                      ? NetworkImage(
                          review.reviewerImage,
                        )
                      : AssetImage('assets/images/avatar_placeholder.png'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
