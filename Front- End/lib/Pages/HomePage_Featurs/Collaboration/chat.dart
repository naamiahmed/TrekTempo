// chat.dart
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
  bool isConnecting = true;
  String? error;

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void connectSocket() {
    try {
      socket = IO.io('http://localhost:5000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'reconnection': true,
        'reconnectionDelay': 1000,
        'reconnectionAttempts': 5,
        'extraHeaders': {'Access-Control-Allow-Origin': '*'}
      });

      socket.onConnect((_) {
        setState(() => isConnecting = false);
        socket.emit('joinRoom', {
          'userId': widget.userId,
          'partnerId': widget.partnerId,
        });
      });

      socket.on('message', (data) {
        if (mounted) {
          setState(() {
            messages.add(ChatMessage(
              message: data['message'],
              isMe: data['userId'] == widget.userId,
              userName: data['userName'],
            ));
          });
        }
      });

      socket.onConnectError((data) {
        setState(() {
          error = 'Connection error: $data';
          isConnecting = false;
        });
      });

      socket.onDisconnect((_) {
        if (mounted) {
          setState(() => error = 'Disconnected from server');
        }
      });
    } catch (e) {
      setState(() {
        error = 'Failed to initialize connection: $e';
        isConnecting = false;
      });
    }
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

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Do you wish to proceed to the next step?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Important Instructions:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('1. Your location will be shared'),
              const Text('2. Please ensure your safety'),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapSample(
                        userId: widget.userId,
                        partnerId: widget.partnerId,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'Open Map',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isConnecting) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    error = null;
                    isConnecting = true;
                  });
                  connectSocket();
                },
                child: const Text('Retry Connection'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.userName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            onPressed: _showConfirmationDialog,
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
    controller.dispose();
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
