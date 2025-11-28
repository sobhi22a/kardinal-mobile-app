import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends AuthEvent {
  final String userName;
  final String password;

  const LoginSubmitted({
    required this.userName,
    required this.password,
  });

  @override
  List<Object?> get props => [userName, password];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

class CurrentUserRequested extends AuthEvent {
  const CurrentUserRequested();
}