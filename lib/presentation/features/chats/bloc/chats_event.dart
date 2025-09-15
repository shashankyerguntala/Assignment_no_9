part of 'chats_bloc.dart';

@immutable
sealed class ChatsEvent {}

class SendMessageEvent extends ChatsEvent {
  final MessageEntity message;
  SendMessageEvent(this.message);
}

class FetchMessagesEvent extends ChatsEvent {
  final String chatId;
  FetchMessagesEvent(this.chatId);
}
