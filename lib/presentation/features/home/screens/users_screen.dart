import 'package:assignment_9/presentation/features/chats/screens/chats_screen.dart';
import 'package:assignment_9/presentation/features/home/bloc/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assignment_9/presentation/features/home/widgets/icon_chip.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "WhatsUp",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        actions: [
          IconChip(icon: Icons.search),
          const SizedBox(width: 8),
          IconChip(icon: Icons.more_vert),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final users = state.users[index];
                return Card(
                  child: GestureDetector(
                    onTap: () {
                      final receiverId = users.uid;
                      final receiverName = users.name;
                      final senderId = FirebaseAuth.instance.currentUser!.uid;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            receiverId: receiverId,
                            receiverName: receiverName,
                            senderId: senderId,
                          ),
                        ),
                      );
                    },

                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Text(
                          users.name.isNotEmpty
                              ? users.name[0].toUpperCase()
                              : "?",
                        ),
                      ),
                      title: Text(users.name),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox(child: Text('nothing here '));
        },
      ),
    );
  }
}
