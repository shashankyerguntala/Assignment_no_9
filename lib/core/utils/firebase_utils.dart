import 'package:assignment_9/data/model/user_model.dart';
import 'package:assignment_9/domain/entity/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtils {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<List<UserEntity>> getUsers() {
    return firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final userModel = UserModel.fromFirestore(doc.data());
        return userModel.toEntity();
      }).toList();
    });
  }
}
