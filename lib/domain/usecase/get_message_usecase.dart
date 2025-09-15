import 'package:assignment_9/domain/entity/message_entity.dart';
import 'package:assignment_9/domain/repository/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase({required this.repository});

  Stream<List<MessageEntity>> getMessages(String chatId) {
    return repository.getMessages(chatId);
  }
}
