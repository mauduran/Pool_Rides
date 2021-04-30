import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/review.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/reviews-service.dart';
import 'package:pool_rides/services/user-service.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  ReviewsBloc() : super(ReviewsInitial());

  @override
  Stream<ReviewsState> mapEventToState(
    ReviewsEvent event,
  ) async* {
    if (event is CreateReviewEvent) {
      try {
        yield LoadingState();
        User user =
            await UserService().getCurrentUser(UserAuthProvider().getUid());
        if (user.car == null || user.car.brand == null) {
          yield ErrorState(
            error: "Por favor registra tu auto primero.",
            code: "400",
          );
          return;
        }

        bool createdReview = await ReviewsService().createReview(
          reviewer: user,
          reviewedUser: event.reviewedUser,
          trip: event.trip,
          rating: event.rating,
          description: event.description,
        );

        //TODO: Change trip object to mytrip when ready
        if (!createdReview) throw Exception("Could not create review");

        yield CreatedReviewState();
      } catch (e) {
        print(e);
        yield ErrorState(
          error: "No se pudo crear reseña",
          code: "400",
        );
      }
    } else if (event is GetUserReviewsEvent) {
      try {
        User user = await UserService().getCurrentUser(event.uid);
        List<Review> reviews =
            await ReviewsService().GetUserReviewsEvent(event.uid);

        yield ReviewsFoundState(reviews: reviews, user: user);
      } catch (e) {
        yield ErrorState(
          error: "No se pudieron encontrar las reseñas",
          code: "400",
        );
      }
    }
  }
}
