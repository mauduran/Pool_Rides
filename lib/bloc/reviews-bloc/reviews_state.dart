part of 'reviews_bloc.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object> get props => [];
}

class ReviewsInitial extends ReviewsState {}

class CreatedReviewState extends ReviewsState {}

class ErrorState extends ReviewsState {
  final String error;
  final String code;

  ErrorState({@required this.error, this.code = "400"});

  @override
  List<Object> get props => [error, code];
}

class LoadingState extends ReviewsState {}

class ReviewsFoundState extends ReviewsState {
  final List<Review> reviews;
  final User user;

  ReviewsFoundState({@required this.reviews, @required this.user});
}
