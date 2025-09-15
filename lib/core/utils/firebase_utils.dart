import 'package:assignment_9/data/model/message_model.dart';
import 'package:assignment_9/data/model/user_model.dart';
import 'package:assignment_9/domain/entity/message_entity.dart';
import 'package:assignment_9/domain/entity/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Stream<List<UserEntity>> getUsers() {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) {
            final userModel = UserModel.fromFirestore(doc.data());
            return userModel.toEntity();
          })
          .where((user) => user.uid != currentUserId)
          .toList();
    });
  }

  Future<void> sendMessage(MessageEntity message) async {
    final String chatId = getChatId(message.senderId, message.receiverId);
    final messageModel = MessageModel(
      senderId: message.senderId,
      receiverId: message.receiverId,
      message: message.message,
      timestamp: message.timestamp,
      isRead: message.isRead,
    );
    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(messageModel.toFirestore());

    await firestore.collection('chats').doc(chatId).set({
      'participants': [message.senderId, message.receiverId],
      'lastMessage': message.message,
      'lastTimestamp': message.timestamp,
    }, SetOptions(merge: true));
  }

  Stream<List<MessageEntity>> getMessages(String chatId) {
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromFirestore(doc))
              .toList(),
        );
  }

  Stream<List<Map<String, dynamic>>> getUserChats(String userId) {
    return firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastTimestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  getChatId(String senderId, String receiverId) {
    List<String> chatId = [senderId, receiverId]..sort();
    return chatId.join();
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChats(String currentUserId) {
    return firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastTimestamp', descending: true)
        .snapshots();
  }
}
