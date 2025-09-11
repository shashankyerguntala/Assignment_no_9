import 'package:assignment_9/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.name, required super.uid, required super.email});

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }

  UserEntity toEntity() => UserEntity(uid: uid, name: name, email: email);
}
