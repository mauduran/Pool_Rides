part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class VerifyAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignOutAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoginWithFacebookEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoginWithGoogleEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoginWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  LoginWithEmailEvent({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];
}

class RegisterWithEmailEvent extends AuthEvent {
  final DateTime birthdate;
  final String phone;
  final String title;

  RegisterWithEmailEvent(
      {@required this.birthdate, @required this.phone, @required this.title});
  @override
  List<Object> get props => [birthdate, phone, title];
}

class ShowRegisterPageEvent extends AuthEvent {
  ShowRegisterPageEvent();
  @override
  List<Object> get props => [];
}

class ShowRegister2PageEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  ShowRegister2PageEvent(
      {@required this.email, @required this.password, @required this.name});
  @override
  List<Object> get props => [email, password, name];
}

class CancelRegisterEvent extends AuthEvent {
  CancelRegisterEvent();
  @override
  List<Object> get props => [];
}

class ForgotPasswordEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
