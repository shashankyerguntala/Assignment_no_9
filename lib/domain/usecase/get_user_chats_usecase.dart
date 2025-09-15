import 'package:assignment_9/domain/repository/chat_repository.dart';

class GetUserChatsUseCase {
  final ChatRepository repository;

  GetUserChatsUseCase({required this.repository});

  Stream<List<Map<String, dynamic>>> getUserChats(String userId) {
    return repository.getUserChats(userId);
  }
}
