part of 'reviews_bloc.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object> get props => [];
}

class CreateReviewEvent extends ReviewsEvent {
  final String rating;
  final String description;
  final Trip trip;
  final User reviewedUser;

  CreateReviewEvent(
      {@required this.rating,
      @required this.description,
      @required this.trip,
      @required this.reviewedUser});

  List<Object> get props => [rating, description, trip, reviewedUser];
}

class GetUserReviewsEvent extends ReviewsEvent {
  final String uid;

  GetUserReviewsEvent({@required this.uid});

  List<Object> get props => [uid];
}
