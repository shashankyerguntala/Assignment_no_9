class MessageEntity {
  final String message;
  final String senderId;
  final String receiverId;
  final DateTime timestamp;
  final bool isRead;

  MessageEntity({
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
    required this.isRead,
  });
}
