part of 'create_review_bloc.dart';

abstract class CreateReviewState extends Equatable {
  const CreateReviewState();

  @override
  List<Object> get props => [];
}

class CreateReviewInitial extends CreateReviewState {}

class CreatedReviewState extends CreateReviewState {}

class CreatedReviewErrorState extends CreateReviewState {
  final String error;
  final String code;

  CreatedReviewErrorState({@required this.error, this.code = "400"});

  @override
  List<Object> get props => [error, code];
}

class LoadingState extends CreateReviewState {}
