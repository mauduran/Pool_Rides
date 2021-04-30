import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_trips_event.dart';
part 'my_trips_state.dart';

class MyTripsBloc extends Bloc<MyTripsEvent, MyTripsState> {
  MyTripsBloc() : super(MyTripsInitial());

  @override
  Stream<MyTripsState> mapEventToState(
    MyTripsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
