part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class EmailLoginEvent extends LoginEvent {
  final String email;
  final String password;

  EmailLoginEvent({required this.email, required this.password});
}

class GoogleLoginEvent extends LoginEvent {}

class SignUpEvent extends LoginEvent {
  final String email;
  final String password;
  final String name;

  SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}
