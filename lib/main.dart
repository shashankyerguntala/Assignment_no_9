import 'package:assignment_9/core/constants.dart';
import 'package:assignment_9/core/di/di.dart';
import 'package:assignment_9/domain/usecase/get_all_chats_usecase.dart';
import 'package:assignment_9/domain/usecase/get_message_usecase.dart';
import 'package:assignment_9/domain/usecase/get_user_chats_usecase.dart';
import 'package:assignment_9/domain/usecase/send_message_usecase.dart';
import 'package:assignment_9/firebase_options.dart';
import 'package:assignment_9/presentation/features/all_chats/bloc/all_chats_bloc.dart';
import 'package:assignment_9/presentation/features/chats/bloc/chats_bloc.dart';
import 'package:assignment_9/presentation/features/home/bloc/home_bloc.dart';
import 'package:assignment_9/presentation/features/login/bloc/login_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:assignment_9/presentation/features/login/screens/sign_in_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Di().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => HomeBloc(di())),
        BlocProvider(
          create: (context) => ChatBloc(
            di<SendMessageUseCase>(),
            di<GetMessagesUseCase>(),
            di<GetUserChatsUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => AllChatsBloc(di<GetAllChatsUseCase>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        theme: Constants().lightTheme,
        darkTheme: Constants().darkTheme,
        themeMode: ThemeMode.system,
        home: const SignInScreen(),
      ),
    );
  }
}
