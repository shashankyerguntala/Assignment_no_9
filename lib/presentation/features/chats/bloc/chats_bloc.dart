import 'package:assignment_9/domain/entity/message_entity.dart';

import 'package:assignment_9/domain/usecase/get_message_usecase.dart';
import 'package:assignment_9/domain/usecase/get_user_chats_usecase.dart';
import 'package:assignment_9/domain/usecase/send_message_usecase.dart';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatBloc extends Bloc<ChatsEvent, ChatsState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final GetUserChatsUseCase getUserChatsUseCase;

  ChatBloc(
    this.sendMessageUseCase,
    this.getMessagesUseCase,
    this.getUserChatsUseCase,
  ) : super(ChatInitial()) {
    on<SendMessageEvent>(onSendMessage);
    on<FetchMessagesEvent>(onFetchMessages);
  }

  Future<void> onSendMessage(
    SendMessageEvent event,
    Emitter<ChatsState> emit,
  ) async {
    try {
      await sendMessageUseCase.sendMessage(event.message);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> onFetchMessages(
    FetchMessagesEvent event,
    Emitter<ChatsState> emit,
  ) async {
    await emit.forEach<List<MessageEntity>>(
      getMessagesUseCase.getMessages(event.chatId),
      onData: (messages) => MessagesLoaded(messages: messages),
    );
  }
}
