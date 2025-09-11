import 'package:assignment_9/domain/entity/user_entity.dart';

abstract class GetUserRepository {
  Stream<List<UserEntity>> getUsers();
}
