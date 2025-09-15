import 'package:equatable/equatable.dart';
import 'package:assignment_9/domain/entity/message_entity.dart'; 



abstract class AllChatsEvent extends Equatable {
  const AllChatsEvent();

  @override
  List<Object?> get props => [];
}

/// Event dispatched from the UI to start loading the chat streams.
class LoadAllChats extends AllChatsEvent {
  final String currentUserId;

  const LoadAllChats(this.currentUserId);

  @override
  List<Object?> get props => [currentUserId];
}

/// Internal event used by the BLoC to process new data from the stream.
class ChatsUpdated extends AllChatsEvent {
  final List<MessageEntity> messages;

  const ChatsUpdated(this.messages);

  @override
  List<Object?> get props => [messages];
}