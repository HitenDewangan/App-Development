import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../core/theme/app_theme.dart';
import '../../models/user_model.dart';
import '../ai_assistant/ai_assistant_screen.dart';
import '../chat/chat_list_screen.dart';
import '../profile/profile_screen.dart';
import 'widgets/user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardSwiperController _cardController = CardSwiperController();
  int _currentIndex = 0;
  
  // Mock users for demonstration
  final List<UserModel> _potentialMatches = [
    UserModel(
      id: '1',
      email: 'emma@example.com',
      username: 'emma_smith',
      displayName: 'Emma Smith',
      bio: 'Love traveling, cooking, and meeting new people. Looking for someone who shares my passion for adventure and meaningful conversations.',
      photos: ['https://picsum.photos/400/600?random=1'],
      age: 26,
      gender: Gender.female,
      interestedIn: Gender.male,
      relationshipType: RelationshipType.serious,
      interests: ['Travel', 'Cooking', 'Photography', 'Yoga'],
      hobbies: ['Hiking', 'Reading', 'Dancing'],
      minAge: 24,
      maxAge: 35,
      maxDistance: 30,
      lastSeen: DateTime.now().subtract(const Duration(hours: 2)),
      city: 'New York',
      country: 'USA',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      id: '2',
      email: 'sarah@example.com',
      username: 'sarah_johnson',
      displayName: 'Sarah Johnson',
      bio: 'Artist by day, dreamer by night. I believe in deep connections and authentic conversations. Let\'s create something beautiful together!',
      photos: ['https://picsum.photos/400/600?random=2'],
      age: 29,
      gender: Gender.female,
      interestedIn: Gender.male,
      relationshipType: RelationshipType.casual,
      interests: ['Art', 'Music', 'Coffee', 'Books'],
      hobbies: ['Painting', 'Guitar Playing', 'Writing'],
      minAge: 26,
      maxAge: 40,
      maxDistance: 25,
      lastSeen: DateTime.now().subtract(const Duration(minutes: 30)),
      city: 'Los Angeles',
      country: 'USA',
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      id: '3',
      email: 'michelle@example.com',
      username: 'michelle_brown',
      displayName: 'Michelle Brown',
      bio: 'Fitness enthusiast and foodie. I love exploring new restaurants and staying active. Looking for someone to join me on adventures!',
      photos: ['https://picsum.photos/400/600?random=3'],
      age: 24,
      gender: Gender.female,
      interestedIn: Gender.male,
      relationshipType: RelationshipType.marriage,
      interests: ['Fitness', 'Food', 'Travel', 'Health'],
      hobbies: ['Running', 'Cooking', 'Yoga'],
      minAge: 22,
      maxAge: 32,
      maxDistance: 40,
      lastSeen: DateTime.now().subtract(const Duration(hours: 1)),
      city: 'Chicago',
      country: 'USA',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Card Stack
            Expanded(
              child: _potentialMatches.isEmpty
                  ? _buildNoMoreCards()
                  : _buildCardStack(),
            ),
            
            // Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Discover',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryPink,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // TODO: Open filters
                },
                icon: const Icon(Icons.tune),
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.lightPink.withOpacity(0.3),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AIAssistantScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.psychology),
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.purple.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildCardStack() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CardSwiper(
        controller: _cardController,
        cardsCount: _potentialMatches.length,
        onSwipe: _onSwipe,
        onUndo: _onUndo,
        numberOfCardsDisplayed: 3,
        backCardOffset: const Offset(40, 40),
        padding: const EdgeInsets.all(24.0),
        cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage) {
          return UserCard(
            user: _potentialMatches[index],
            horizontalThreshold: horizontalThresholdPercentage.toDouble(),
            onTap: () => _showUserDetails(_potentialMatches[index]),
          );
        },
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 800.ms);
  }

  Widget _buildNoMoreCards() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppTheme.lightPink.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_outline,
              size: 64,
              color: AppTheme.primaryPink,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No more profiles',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryPink,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for new matches or try expanding your search criteria.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.lightGray,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // TODO: Open search settings
            },
            child: const Text('Adjust Preferences'),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms);
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Pass Button
          _buildActionButton(
            icon: Icons.close,
            color: Colors.grey,
            onPressed: () => _cardController.swipe(CardSwiperDirection.left),
          ),
          
          // Super Like Button
          _buildActionButton(
            icon: Icons.star,
            color: Colors.blue,
            onPressed: () => _cardController.swipe(CardSwiperDirection.top),
            size: 48,
          ),
          
          // Like Button
          _buildActionButton(
            icon: Icons.favorite,
            color: AppTheme.primaryPink,
            onPressed: () => _cardController.swipe(CardSwiperDirection.right),
          ),
          
          // Rewind Button
          _buildActionButton(
            icon: Icons.replay,
            color: Colors.orange,
            onPressed: () => _cardController.undo(),
            size: 40,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms, duration: 600.ms);
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    double size = 56,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size * 0.4),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        
        switch (index) {
          case 0:
            // Already on home
            break;
          case 1:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ChatListScreen(),
              ),
            );
            break;
          case 2:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppTheme.primaryPink,
      unselectedItemColor: AppTheme.lightGray,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    final user = _potentialMatches[previousIndex];
    
    switch (direction) {
      case CardSwiperDirection.left:
        _handlePass(user);
        break;
      case CardSwiperDirection.right:
        _handleLike(user);
        break;
      case CardSwiperDirection.top:
        _handleSuperLike(user);
        break;
      case CardSwiperDirection.bottom:
        // Not used
        break;
      case CardSwiperDirection.none:
        // No action needed
        break;
    }
    
    return true;
  }

  bool _onUndo(int? previousIndex, int currentIndex, CardSwiperDirection direction) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Undo successful!'),
        duration: Duration(seconds: 1),
      ),
    );
    return true;
  }

  void _handlePass(UserModel user) {
    // TODO: Save pass action to backend
    print('Passed on ${user.displayName}');
  }

  void _handleLike(UserModel user) {
    // TODO: Save like action to backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You liked ${user.displayName}!'),
        backgroundColor: AppTheme.primaryPink,
        duration: const Duration(seconds: 2),
      ),
    );
    
    // Check for match (in real app, this would come from backend)
    if (DateTime.now().millisecond % 3 == 0) {
      _showMatchDialog(user);
    }
  }

  void _handleSuperLike(UserModel user) {
    // TODO: Save super like action to backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You super liked ${user.displayName}!'),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showMatchDialog(UserModel user) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'It\'s a Match!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryPink,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'You and ${user.displayName} liked each other',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Keep Swiping'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ChatListScreen(),
                          ),
                        );
                      },
                      child: const Text('Say Hi'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUserDetails(UserModel user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UserCard(
        user: user,
        isFullScreen: true,
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }
}
