part of 'vehicle_bloc.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object> get props => [];
}

class VehicleInitial extends VehicleState {}

class ErrorState extends VehicleState {
  final String error;
  final String errorEasy;

  ErrorState({@required this.error, @required this.errorEasy});
  @override
  List<Object> get props => [error];
}

class NewImageState extends VehicleState {
  final File image;
  final bool isNewImage;
  NewImageState({
    @required this.image,
    @required this.isNewImage,
  });
  @override
  List<Object> get props => [image, isNewImage];
}

class UpdatedSuccesfully extends VehicleState {
  final String msg;
  final Car newCar;
  UpdatedSuccesfully({
    @required this.msg,
    @required this.newCar,
  });
  @override
  List<Object> get props => [msg, newCar];
}
