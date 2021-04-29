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
  ChangeBiographyEvent({@required this.newBiography});

  @override
  List<Object> get props => [newBiography];
}

class LoadCarEvent extends UserEvent {}

class GetUserEvent extends UserEvent {}
