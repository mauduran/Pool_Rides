import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pool_rides/models/trip.dart';
import 'package:pool_rides/models/user.dart';
import 'package:pool_rides/services/auth-service.dart';
import 'package:pool_rides/services/reviews-service.dart';
import 'package:pool_rides/services/user-service.dart';

part 'create_review_event.dart';
part 'create_review_state.dart';

class CreateReviewBloc extends Bloc<CreateReviewEvent, CreateReviewState> {
  CreateReviewBloc() : super(CreateReviewInitial());

  @override
  Stream<CreateReviewState> mapEventToState(
    CreateReviewEvent event,
  ) async* {
    if (event is CreateNewReviewEvent) {
      try {
        yield LoadingState();
        User user =
            await UserService().getCurrentUser(UserAuthProvider().getUid());
        if (user.car == null || user.car.brand == null) {
          yield CreatedReviewErrorState(
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
        yield CreatedReviewErrorState(
          error: "No se pudo crear reseña",
          code: "400",
        );
      }
    }
  }
}
