import 'package:assignment_9/domain/entity/user_entity.dart';
import 'package:assignment_9/domain/repository/get_user_repository.dart';

class GetUsersUsecase {
  final GetUserRepository repository;

  GetUsersUsecase({required this.repository});
  Stream<List<UserEntity>> getUsers() {
    return repository.getUsers();
  }
}
