part of 'create_review_bloc.dart';

abstract class CreateReviewEvent extends Equatable {
  const CreateReviewEvent();

  @override
  List<Object> get props => [];
}

class CreateNewReviewEvent extends CreateReviewEvent {
  final String rating;
  final String description;
  final Trip trip;
  final User reviewedUser;

  CreateNewReviewEvent(
      {@required this.rating,
      @required this.description,
      @required this.trip,
      @required this.reviewedUser});

  List<Object> get props => [rating, description, trip, reviewedUser];
}
