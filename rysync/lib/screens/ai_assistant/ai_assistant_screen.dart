import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../services/ai_assistant_service.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final AIAssistantService _aiService = AIAssistantService();
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _addWelcomeMessage() {
    setState(() {
      _messages.add(ChatMessage(
        text: "Hi! I'm your AI dating assistant. I can help you with date ideas, conversation starters, relationship advice, and more. What would you like to know?",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showQuickActions,
            icon: const Icon(Icons.flash_on),
            tooltip: 'Quick Actions',
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessage(message, index);
              },
            ),
          ),

          // Loading indicator
          if (_isLoading)
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppTheme.purple,
                    child: const Icon(
                      Icons.psychology,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'AI is typing...',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightGray,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.purple),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),

          // Input Area
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppTheme.purple,
              child: const Icon(
                Icons.psychology,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: message.isUser ? AppTheme.primaryPink : AppTheme.lightPink.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: message.isUser ? const Radius.circular(20) : const Radius.circular(4),
                  bottomRight: message.isUser ? const Radius.circular(4) : const Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: message.isUser ? Colors.white : AppTheme.darkGray,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: message.isUser 
                          ? Colors.white.withOpacity(0.7) 
                          : AppTheme.lightGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppTheme.primaryPink,
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ],
      ),
    ).animate(delay: (index * 100).ms)
      .fadeIn(duration: 400.ms)
      .slideY(begin: 0.3, end: 0, duration: 400.ms);
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Ask me anything about dating...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppTheme.lightPink.withOpacity(0.2),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              maxLines: null,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            onPressed: _sendMessage,
            backgroundColor: AppTheme.primaryPink,
            foregroundColor: Colors.white,
            mini: true,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isLoading) return;

    // Add user message
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isLoading = true;
    });

    _messageController.clear();

    try {
      // Get AI response based on message content
      AIResponse response;
      
      if (text.toLowerCase().contains('date') && text.toLowerCase().contains('idea')) {
        response = await _aiService.getDateSuggestions(
          user: _getDummyUser(),
          isFirstDate: text.toLowerCase().contains('first'),
        );
      } else if (text.toLowerCase().contains('conversation') || 
                 text.toLowerCase().contains('talk') ||
                 text.toLowerCase().contains('say')) {
        response = await _aiService.getConversationSuggestions(
          user: _getDummyUser(),
        );
      } else {
        response = await _aiService.getRelationshipAdvice(
          user: _getDummyUser(),
          question: text,
        );
      }

      // Add AI response
      setState(() {
        _messages.add(ChatMessage(
          text: response.message,
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });

    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: "I apologize, but I'm having trouble processing your request right now. Please try again.",
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionButton(
                    'Date Ideas',
                    Icons.restaurant,
                    () {
                      Navigator.pop(context);
                      _sendPredefinedMessage('Give me some date ideas');
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQuickActionButton(
                    'Conversation',
                    Icons.chat,
                    () {
                      Navigator.pop(context);
                      _sendPredefinedMessage('Give me conversation starters');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionButton(
                    'First Date',
                    Icons.favorite,
                    () {
                      Navigator.pop(context);
                      _sendPredefinedMessage('I have a first date coming up, any advice?');
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQuickActionButton(
                    'Profile Tips',
                    Icons.person,
                    () {
                      Navigator.pop(context);
                      _sendPredefinedMessage('How can I improve my dating profile?');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                color: AppTheme.primaryPink,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendPredefinedMessage(String message) {
    _messageController.text = message;
    _sendMessage();
  }

  String _formatTime(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Helper method to create dummy user for AI service
  _getDummyUser() {
    return const {}; // Simplified for demo
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
