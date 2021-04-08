part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class ChangingImageState extends UserState {}

class LoadingState extends UserState {}

class LoadedInformatiogState extends UserState {}

class ErrorState extends UserState {
  final String error;
  final String errorEasy;

  ErrorState({@required this.error, @required this.errorEasy});
  @override
  List<Object> get props => [error];
}

class AccountNewImageState extends UserState {
  final File image;

  AccountNewImageState({@required this.image});
  @override
  List<Object> get props => [image];
}

class ChangeBiographyState extends UserState {}

class AccountNewBiographyState extends UserState {
  final String biography;

  AccountNewBiographyState({@required this.biography});
  @override
  List<Object> get props => [biography];
}

class CarInformationState extends UserState {
  final Car userCar;
  final bool newCar;
  CarInformationState({@required this.userCar, @required this.newCar});
  @override
  List<Object> get props => [userCar, newCar];
}
