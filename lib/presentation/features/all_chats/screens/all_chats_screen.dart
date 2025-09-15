import 'package:assignment_9/core/constants.dart';
import 'package:assignment_9/presentation/features/all_chats/bloc/all_chats_bloc.dart';
import 'package:assignment_9/presentation/features/all_chats/bloc/all_chats_event.dart';
import 'package:assignment_9/presentation/features/all_chats/bloc/all_chats_state.dart';
import 'package:assignment_9/presentation/features/chats/screens/chats_screen.dart';
import 'package:assignment_9/presentation/features/home/screens/users_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({super.key});

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    context.read<AllChatsBloc>().add(LoadAllChats(currentUser.uid));
  }

  Future<String> _getUserName(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    if (doc.exists && doc.data() != null) {
      return doc['name'] ?? 'Unknown';
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllChatsBloc, AllChatsState>(
        builder: (context, state) {
          if (state is AllChatsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AllChatsLoaded) {
            if (state.lastMessages.isEmpty) {
              return Center(
                child: Text(
                  "Start chatting",
                  style: TextStyle(color: Constants.primary, fontSize: 16),
                ),
              );
            }

            final messages = state.lastMessages;

            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];

                final receiverId = msg.senderId == currentUser.uid
                    ? msg.receiverId
                    : msg.senderId;

                return FutureBuilder<String>(
                  future: _getUserName(receiverId),
                  builder: (context, snapshot) {
                    final name = snapshot.data ?? "Loading...";

                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(name),
                      subtitle: Text(msg.message),
                      trailing: Text(
                        "${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              receiverId: receiverId,
                              receiverName: name,
                              senderId: currentUser.uid,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UsersScreen()),
          );
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
