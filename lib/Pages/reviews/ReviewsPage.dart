import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pool_rides/bloc/reviews-bloc/reviews_bloc.dart';
import 'package:pool_rides/models/review.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/widgets/reviews/ReviewDetail.dart';
import 'package:pool_rides/widgets/reviews/ReviewSummary.dart';

class ReviewsPage extends StatefulWidget {
  final String uid;
  ReviewsPage({Key key, @required this.uid}) : super(key: key);

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  ReviewsBloc _bloc;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reseñas"),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) {
            _bloc = ReviewsBloc()..add(GetUserReviewsEvent(uid: widget.uid));
            return _bloc;
          },
          child: BlocConsumer<ReviewsBloc, ReviewsState>(
            listener: (context, state) {
              if (state is ErrorState) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(state.error),
                    duration: Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: "Aceptar",
                      textColor: Colors.blue,
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ));
              }
            },
            builder: (context, state) {
              if (state is ErrorState) {
                return Container(
                  child: Center(
                    child: Text("No se pudo realizar busqueda"),
                  ),
                );
              } else if (state is ReviewsFoundState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    _bloc.add(GetUserReviewsEvent(uid: widget.uid));
                    return;
                  },
                  child: _ReviewsList(
                    user: state.user,
                    reviews: state.reviews,
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}

class _ReviewsList extends StatelessWidget {
  final User user;
  final List<Review> reviews;

  const _ReviewsList({Key key, @required this.user, @required this.reviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 20, 32, 0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: (user.image != null && user.image != '')
                      ? NetworkImage(
                          user.image,
                        )
                      : AssetImage('assets/images/avatar_placeholder.png'),
                  radius: 36,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
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
                          (user.totalReviews > 0)
                              ? "${user.totalStars / user.totalReviews}/5 - ${user.totalReviews} reseñas"
                              : "0 reseñas",
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
          ReviewSummary(reviews: reviews),
          ...reviews
              .map(
                (review) => ReviewDetail(
                  review: review,
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
