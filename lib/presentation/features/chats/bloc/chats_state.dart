part of 'chats_bloc.dart';

@immutable
sealed class ChatsState {}

final class ChatInitial extends ChatsState {}

final class ChatLoading extends ChatsState {}

final class MessageSent extends ChatsState {}

final class MessagesLoaded extends ChatsState {
  final List<MessageEntity> messages;
  MessagesLoaded({required this.messages});
}

final class UserChatsLoaded extends ChatsState {
  final List<Map<String, dynamic>> chats;
  UserChatsLoaded({required this.chats});
}

final class ChatError extends ChatsState {
  final String message;
  ChatError(this.message);
}
