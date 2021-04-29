import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_trips_event.dart';
part 'search_trips_state.dart';

class SearchTripsBloc extends Bloc<SearchTripsEvent, SearchTripsState> {
  SearchTripsBloc() : super(SearchTripsInitial());

  @override
  Stream<SearchTripsState> mapEventToState(
    SearchTripsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
