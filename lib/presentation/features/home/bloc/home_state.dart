part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class UserLoading extends HomeState {}

final class UsersLoaded extends HomeState {
  final List<UserEntity> users;

  UsersLoaded({required this.users});
}
