import 'package:Pool_Rides/models/review.dart';
import 'package:Pool_Rides/reviews/ReviewSummary.dart';
import 'package:flutter/material.dart';
import 'package:Pool_Rides/reviews/ReviewDetail.dart';

class ReviewsPage extends StatefulWidget {
  ReviewsPage({Key key}) : super(key: key);

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

List<Widget> _getReviewDetails() {
  var array = [
    Review(
      reviewerName: "Manuel",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
      rating: "Excelente",
      reviewerImage: 'https://randomuser.me/api/portraits/men/5.jpg',
      date: DateTime.now(),
    ),
    Review(
      reviewerName: "Hector",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
      rating: "Excelente",
      reviewerImage: 'https://randomuser.me/api/portraits/men/5.jpg',
      date: DateTime.now(),
    ),
    Review(
      reviewerName: "Gabriela",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
      rating: "Excelente",
      reviewerImage: 'https://randomuser.me/api/portraits/men/5.jpg',
      date: DateTime.now(),
    ),
  ];

  return array
      .map(
        (review) => ReviewDetail(
          review: review,
        ),
      )
      .toList();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reseñas"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 20, 32, 0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/5.jpg",
                    ),
                    radius: 36,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edgar Rolas",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            "${4.5.toStringAsFixed(1)}/5 - ${60} reviews",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            ReviewSummary(),
            ..._getReviewDetails()
          ],
        ),
      ),
    );
  }
}
