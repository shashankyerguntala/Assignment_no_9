import 'package:assignment_9/core/constants.dart';
import 'package:assignment_9/presentation/features/home/screens/users_screen.dart';
import 'package:flutter/material.dart';

class HomeChatsScreen extends StatefulWidget {
  const HomeChatsScreen({super.key});

  @override
  State<HomeChatsScreen> createState() => _HomeChatsScreenState();
}

class _HomeChatsScreenState extends State<HomeChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'No Chats yet ',
          style: TextStyle(color: Constants.primary),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UsersScreen()),
          );
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
