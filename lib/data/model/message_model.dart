import 'package:assignment_9/domain/entity/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.senderId,
    required super.receiverId,
    required super.timestamp,
    required super.isRead,
    required super.message,
  });

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      senderId: data['senderId'] as String,
      receiverId: data['receiverId'] as String,
      message: data['message'] as String,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      isRead: data['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
      'isRead': isRead,
    };
  }

  factory MessageModel.fromChatDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final participants = List<String>.from(data['participants'] ?? []);

    return MessageModel(
      senderId: participants.isNotEmpty ? participants[0] : '',
      receiverId: participants.length > 1 ? participants[1] : '',
      message: data['lastMessage'] ?? '',
      timestamp: (data['lastTimestamp'] as Timestamp).toDate(),
      isRead: false,
    );
  }

  MessageEntity toEntity() {
    return MessageEntity(
      senderId: senderId,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
      isRead: isRead,
    );
  }
}
