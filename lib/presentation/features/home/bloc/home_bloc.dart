import 'dart:async';

import 'package:assignment_9/domain/entity/user_entity.dart';
import 'package:assignment_9/domain/usecase/get_users_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsersUsecase getUsersUsecase;
  HomeBloc(this.getUsersUsecase) : super(HomeInitial()) {
    on<FetchUsers>(fetchUsers);
  }

  FutureOr<void> fetchUsers(FetchUsers event, Emitter<HomeState> emit) async {
    emit(UserLoading());
    await emit.forEach<List<UserEntity>>(
      getUsersUsecase.getUsers(),
      onData: (users) => UsersLoaded(users: users),
    );
  }
}
