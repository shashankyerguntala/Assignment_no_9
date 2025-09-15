import 'package:assignment_9/domain/entity/message_entity.dart';
import 'package:assignment_9/presentation/features/chats/bloc/chats_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String senderId;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.senderId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();

  late final String chatId;

  @override
  void initState() {
    super.initState();

    final ids = [widget.senderId, widget.receiverId]..sort();
    chatId = ids.join();

    context.read<ChatBloc>().add(FetchMessagesEvent(chatId));
  }

  void sendMessage() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    final message = MessageEntity(
      senderId: widget.senderId,
      receiverId: widget.receiverId,
      message: text,
      timestamp: DateTime.now(),
      isRead: false,
    );

    context.read<ChatBloc>().add(SendMessageEvent(message));
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverName), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatsState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MessagesLoaded) {
                  final messages = state.messages;
                  if (messages.isEmpty) {
                    return const Center(child: Text("No messages yet"));
                  }

                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(12),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isMe = msg.senderId == widget.senderId;

                      return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isMe
                                ? Colors.green.shade300
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            msg.message,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ChatError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.green),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
