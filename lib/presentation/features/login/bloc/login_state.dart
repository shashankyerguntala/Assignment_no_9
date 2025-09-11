part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final User? user;
  LoginLoaded({required this.user});
}

class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}
