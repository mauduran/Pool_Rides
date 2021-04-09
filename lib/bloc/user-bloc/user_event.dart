part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class ChangeAccountImageEvent extends UserEvent {}

class ChangeAccountImageByPhotoEvent extends UserEvent {}

class ChangeAccountImageByGalleryEvent extends UserEvent {}

class ChangeBiographyEvent extends UserEvent {
  final String newBiography;
  final User currentUser;
  ChangeBiographyEvent(
      {@required this.newBiography, @required this.currentUser});

  @override
  List<Object> get props => [newBiography, currentUser];
}

class LoadCarEvent extends UserEvent {}

class GetInformationEvent extends UserEvent {}
