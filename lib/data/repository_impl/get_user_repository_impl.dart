import 'package:assignment_9/data/data_sources/local_data_sources.dart';
import 'package:assignment_9/domain/entity/user_entity.dart';
import 'package:assignment_9/domain/repository/get_user_repository.dart';

class GetUserRepositoryImpl extends GetUserRepository {
  final LocalDataSources localDataSources;

  GetUserRepositoryImpl({required this.localDataSources});
  @override
  Stream<List<UserEntity>> getUsers() {
    return localDataSources.getUsers();
  }
}
