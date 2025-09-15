import 'package:assignment_9/domain/entity/message_entity.dart';

abstract class ChatRepository {
  Future<void> sendMessage(MessageEntity message);

  Stream<List<MessageEntity>> getMessages(String chatId);

  Stream<List<Map<String, dynamic>>> getUserChats(String userId);

  Stream<List<MessageEntity>> getAllChats(String currentUserId);

}
