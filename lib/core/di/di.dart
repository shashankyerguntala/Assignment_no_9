import 'package:assignment_9/core/utils/firebase_utils.dart';
import 'package:assignment_9/data/data_sources/local_data_sources.dart';
import 'package:assignment_9/data/repository_impl/get_user_repository_impl.dart';
import 'package:assignment_9/domain/repository/get_user_repository.dart';
import 'package:assignment_9/domain/usecase/get_users_usecase.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

class Di {
  Future<void> init() async {
    di.registerLazySingleton(() => FirebaseUtils());
    di.registerLazySingleton(() => LocalDataSources(firebaseUtils: di()));
    di.registerLazySingleton<GetUserRepository>(
      () => GetUserRepositoryImpl(localDataSources: di()),
    );
    di.registerLazySingleton(() => GetUsersUsecase(repository: di()));
  }
}
