import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'map.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String userId;
  final String partnerId;

  const ChatPage({
    super.key, 
    required this.userName,
    required this.userId,
    required this.partnerId,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late IO.Socket socket;
  final List<ChatMessage> messages = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void connectSocket() {
    // Connect to socket server
    socket = IO.io('http://localhost:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    // Join chat room
    socket.emit('joinRoom', {
      'userId': widget.userId,
      'partnerId': widget.partnerId,
    });

    // Listen for messages
    socket.on('message', (data) {
      setState(() {
        messages.add(ChatMessage(
          message: data['message'],
          isMe: data['userId'] == widget.userId,
          userName: data['userName'],
        ));
      });
    });
  }

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      socket.emit('sendMessage', {
        'userId': widget.userId,
        'partnerId': widget.partnerId,
        'message': controller.text,
        'userName': widget.userName,
      });
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.userName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapSample()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return MessageBubble(
                  message: message.message,
                  isMe: message.isMe,
                  userName: message.userName,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
}

class ChatMessage {
  final String message;
  final bool isMe;
  final String userName;

  ChatMessage({
    required this.message,
    required this.isMe,
    required this.userName,
  });
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userName;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}