import 'package:assignment_9/core/utils/firebase_utils.dart';
import 'package:assignment_9/data/model/message_model.dart';

import 'package:assignment_9/domain/entity/message_entity.dart';

class ChatDataSource {
  final FirebaseUtils firebaseUtils;

  ChatDataSource({required this.firebaseUtils});

  Future<void> sendMessage(MessageEntity message) {
    return firebaseUtils.sendMessage(message);
  }

  Stream<List<MessageEntity>> getMessages(String chatId) {
    return firebaseUtils.getMessages(chatId);
  }

  Stream<List<Map<String, dynamic>>> getUserChats(String userId) {
    return firebaseUtils.getUserChats(userId);
  }

  Stream<List<MessageEntity>> getAllChats(String currentUserId) {
    return firebaseUtils.getAllChats(currentUserId).map((snapshots) {
      return snapshots.docs.map((doc) {
        return MessageModel.fromChatDoc(doc).toEntity();
      }).toList();
    });
  }
}
