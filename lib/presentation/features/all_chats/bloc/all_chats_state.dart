import 'package:assignment_9/domain/entity/message_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AllChatsState extends Equatable {
  const AllChatsState();

  @override
  List<Object?> get props => [];
}

class AllChatsInitial extends AllChatsState {}

class AllChatsLoading extends AllChatsState {}

class AllChatsLoaded extends AllChatsState {
  final List<MessageEntity> lastMessages;

  const AllChatsLoaded(this.lastMessages);

  @override
  List<Object?> get props => [lastMessages];
}

class AllChatsError extends AllChatsState {
  final String message;

  const AllChatsError(this.message);

  @override
  List<Object?> get props => [message];
}
