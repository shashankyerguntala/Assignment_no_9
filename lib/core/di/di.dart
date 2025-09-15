import 'package:assignment_9/core/utils/firebase_utils.dart';
import 'package:assignment_9/data/data_sources/chat_data_source.dart';
import 'package:assignment_9/data/data_sources/local_data_sources.dart';
import 'package:assignment_9/data/repository_impl/chat_repo_impl.dart';
import 'package:assignment_9/data/repository_impl/get_user_repository_impl.dart';
import 'package:assignment_9/domain/repository/chat_repository.dart';
import 'package:assignment_9/domain/repository/get_user_repository.dart';
import 'package:assignment_9/domain/usecase/get_all_chats_usecase.dart';
import 'package:assignment_9/domain/usecase/get_message_usecase.dart';
import 'package:assignment_9/domain/usecase/get_user_chats_usecase.dart';
import 'package:assignment_9/domain/usecase/get_users_usecase.dart';
import 'package:assignment_9/domain/usecase/send_message_usecase.dart';
import 'package:assignment_9/presentation/features/all_chats/bloc/all_chats_bloc.dart';

import 'package:assignment_9/presentation/features/chats/bloc/chats_bloc.dart';

import 'package:get_it/get_it.dart';

final di = GetIt.instance;

class Di {
  Future<void> init() async {
    di.registerLazySingleton(() => FirebaseUtils());

    di.registerLazySingleton(() => ChatDataSource(firebaseUtils: di()));
    di.registerLazySingleton(() => LocalDataSources(firebaseUtils: di()));

    di.registerLazySingleton<ChatRepository>(
      () => ChatRepoImpl(dataSource: di()),
    );
    di.registerLazySingleton<GetUserRepository>(
      () => GetUserRepositoryImpl(localDataSources: di()),
    );
    di.registerLazySingleton(
      () => GetAllChatsUseCase(repository: di<ChatRepository>()),
    );
    di.registerLazySingleton(() => GetMessagesUseCase(repository: di()));
    di.registerLazySingleton(() => SendMessageUseCase(repository: di()));
    di.registerLazySingleton(() => GetUserChatsUseCase(repository: di()));
    di.registerLazySingleton(() => GetUsersUsecase(repository: di()));

    di.registerFactory(() => AllChatsBloc(di<GetAllChatsUseCase>()));
    di.registerFactory(
      () => ChatBloc(
        di<SendMessageUseCase>(),
        di<GetMessagesUseCase>(),
        di<GetUserChatsUseCase>(),
      ),
    );
  }
}
