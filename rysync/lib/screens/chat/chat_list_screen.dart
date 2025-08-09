import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Search chats
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: _mockChats.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = _mockChats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat.avatarUrl),
              backgroundColor: AppTheme.lightPink,
            ),
            title: Text(
              chat.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              chat.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: chat.isRead ? AppTheme.lightGray : AppTheme.darkGray,
                fontWeight: chat.isRead ? FontWeight.normal : FontWeight.w600,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.timestamp,
                  style: TextStyle(
                    fontSize: 12,
                    color: chat.isRead ? AppTheme.lightGray : AppTheme.primaryPink,
                    fontWeight: chat.isRead ? FontWeight.normal : FontWeight.w600,
                  ),
                ),
                if (!chat.isRead)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryPink,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            onTap: () {
              // TODO: Navigate to individual chat
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening chat with ${chat.name}')),
              );
            },
          ).animate(delay: (index * 100).ms)
            .fadeIn(duration: 600.ms)
            .slideX(begin: -0.3, end: 0, duration: 600.ms);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Start new conversation
        },
        backgroundColor: AppTheme.primaryPink,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class ChatItem {
  final String name;
  final String lastMessage;
  final String timestamp;
  final String avatarUrl;
  final bool isRead;

  ChatItem({
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    required this.avatarUrl,
    required this.isRead,
  });
}

final List<ChatItem> _mockChats = [
  ChatItem(
    name: 'Emma Smith',
    lastMessage: 'Thanks for the great date! Looking forward to seeing you again 😊',
    timestamp: '2m ago',
    avatarUrl: 'https://picsum.photos/100/100?random=1',
    isRead: false,
  ),
  ChatItem(
    name: 'Sarah Johnson',
    lastMessage: 'That restaurant recommendation was perfect!',
    timestamp: '1h ago',
    avatarUrl: 'https://picsum.photos/100/100?random=2',
    isRead: true,
  ),
  ChatItem(
    name: 'Michelle Brown',
    lastMessage: 'Would love to go hiking together this weekend',
    timestamp: '3h ago',
    avatarUrl: 'https://picsum.photos/100/100?random=3',
    isRead: false,
  ),
  ChatItem(
    name: 'Jessica Wilson',
    lastMessage: 'The movie was amazing, thank you!',
    timestamp: '1d ago',
    avatarUrl: 'https://picsum.photos/100/100?random=4',
    isRead: true,
  ),
  ChatItem(
    name: 'Ashley Davis',
    lastMessage: 'Can\'t wait for our cooking class tomorrow',
    timestamp: '2d ago',
    avatarUrl: 'https://picsum.photos/100/100?random=5',
    isRead: true,
  ),
];
