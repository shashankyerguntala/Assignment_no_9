part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeLoading extends HomeEvent {

}

final class HomeError extends HomeEvent {}

final class FetchUsers extends HomeEvent {}

final class FetchChats extends HomeEvent {}
