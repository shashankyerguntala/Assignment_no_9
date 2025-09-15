import 'package:assignment_9/domain/entity/message_entity.dart';
import 'package:assignment_9/domain/repository/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase({required this.repository});

  Future<void> sendMessage(MessageEntity message) {
    return repository.sendMessage(message);
  }
}
