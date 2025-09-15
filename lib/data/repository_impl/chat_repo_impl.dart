import 'package:assignment_9/domain/entity/message_entity.dart';
import 'package:assignment_9/domain/repository/chat_repository.dart';
import 'package:assignment_9/data/data_sources/chat_data_source.dart';

class ChatRepoImpl extends ChatRepository {
  final ChatDataSource dataSource;

  ChatRepoImpl({required this.dataSource});

  @override
  Future<void> sendMessage(MessageEntity message) {
    return dataSource.sendMessage(message);
  }

  @override
  Stream<List<MessageEntity>> getMessages(String chatId) {
    return dataSource.getMessages(chatId);
  }

  @override
  Stream<List<Map<String, dynamic>>> getUserChats(String userId) {
    return dataSource.getUserChats(userId);
  }

  @override
  Stream<List<MessageEntity>> getAllChats(String currentUserId) {
    return dataSource.getAllChats(currentUserId);
  }
}
