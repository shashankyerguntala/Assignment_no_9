import 'dart:async';

import 'package:assignment_9/domain/usecase/get_all_chats_usecase.dart';
import 'package:assignment_9/presentation/features/all_chats/bloc/all_chats_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'all_chats_state.dart';

class AllChatsBloc extends Bloc<AllChatsEvent, AllChatsState> {
  final GetAllChatsUseCase getAllChatsUseCase;
  StreamSubscription? chatSubscription;

  AllChatsBloc(this.getAllChatsUseCase) : super(AllChatsInitial()) {
    on<LoadAllChats>(onLoadAllChats);
    on<ChatsUpdated>(onChatsUpdated);
  }

  Future<void> onLoadAllChats(
    LoadAllChats event,
    Emitter<AllChatsState> emit,
  ) async {
    emit(AllChatsLoading());
    await chatSubscription?.cancel();

    chatSubscription = getAllChatsUseCase
        .getAllChats(event.currentUserId)
        .listen(
          (messages) {
            add(ChatsUpdated(messages));
          },
          onError: (e) {
            emit(AllChatsError(e.toString()));
          },
        );
  }

  void onChatsUpdated(ChatsUpdated event, Emitter<AllChatsState> emit) {
    emit(AllChatsLoaded(event.messages));
  }

  @override
  Future<void> close() {
    chatSubscription?.cancel();
    return super.close();
  }
}


