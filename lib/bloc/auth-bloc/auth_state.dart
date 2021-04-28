part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AlreadyAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class UnAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoggedOutState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

class RegisterSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

class RegisterPageState extends AuthState {
  @override
  List<Object> get props => [];
}

class RegisterPage2State extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginErrorState extends AuthState {
  final String error;
  final String code;

  LoginErrorState({@required this.error, this.code = "to be defined code"});

  @override
  List<Object> get props => [error, code];
}
