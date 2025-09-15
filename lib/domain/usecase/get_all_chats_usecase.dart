import 'package:assignment_9/domain/entity/message_entity.dart';
import 'package:assignment_9/domain/repository/chat_repository.dart';

class GetAllChatsUseCase {
  final ChatRepository repository;
  GetAllChatsUseCase({required this.repository});

  Stream<List<MessageEntity>> getAllChats(String currentUserId) {
    return repository.getAllChats(currentUserId);
  }
}
