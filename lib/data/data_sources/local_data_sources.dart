import 'package:assignment_9/core/utils/firebase_utils.dart';
import 'package:assignment_9/domain/entity/user_entity.dart';

class LocalDataSources {
  final FirebaseUtils firebaseUtils;

  LocalDataSources({required this.firebaseUtils});
  Stream<List<UserEntity>> getUsers() async* {
    yield* firebaseUtils.getUsers();
  }
}
