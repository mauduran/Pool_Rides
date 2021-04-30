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

class ChangePhoneNumberEvent extends UserEvent {
  final String phoneNumber;
  ChangePhoneNumberEvent({@required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class LoadCarEvent extends UserEvent {}

class GetUserEvent extends UserEvent {
  final bool update;

  GetUserEvent({this.update = false});

  @override
  List<Object> get props => [update];
}
