import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import 'relationship_goals_screen.dart';

class InterestsScreen extends StatefulWidget {
  final Map<String, dynamic> profileData;

  const InterestsScreen({
    super.key,
    required this.profileData,
  });

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<String> _selectedInterests = [];
  final List<String> _selectedHobbies = [];

  final List<String> _availableInterests = [
    'Travel',
    'Music',
    'Movies',
    'Sports',
    'Art',
    'Reading',
    'Cooking',
    'Photography',
    'Dancing',
    'Gaming',
    'Fitness',
    'Nature',
    'Technology',
    'Fashion',
    'Food',
    'Comedy',
    'History',
    'Science',
    'Writing',
    'Yoga',
    'Meditation',
    'Hiking',
    'Swimming',
    'Running',
    'Cycling',
    'Tennis',
    'Basketball',
    'Football',
    'Baseball',
    'Golf',
  ];

  final List<String> _availableHobbies = [
    'Playing Guitar',
    'Singing',
    'Painting',
    'Drawing',
    'Blogging',
    'Gardening',
    'Knitting',
    'Board Games',
    'Video Games',
    'Chess',
    'Poker',
    'Collecting',
    'Volunteering',
    'Learning Languages',
    'Wine Tasting',
    'Coffee Brewing',
    'Baking',
    'Crafting',
    'Pottery',
    'Woodworking',
    'Rock Climbing',
    'Surfing',
    'Skiing',
    'Snowboarding',
    'Camping',
    'Fishing',
    'Hunting',
    'Bird Watching',
    'Star Gazing',
    'Geocaching',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interests & Hobbies'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.6,
                      backgroundColor: AppTheme.lightPink.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryPink),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '3 / 5',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightGray,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms),

              const SizedBox(height: 32),

              // Title
              Text(
                'What interests you?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryPink,
                ),
              ).animate()
                .fadeIn(delay: 200.ms, duration: 800.ms)
                .slideX(begin: -0.3, end: 0, delay: 200.ms, duration: 800.ms),

              const SizedBox(height: 8),

              Text(
                'Select at least 5 interests and hobbies to help us find compatible matches.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.lightGray,
                ),
              ).animate()
                .fadeIn(delay: 400.ms, duration: 800.ms)
                .slideX(begin: -0.3, end: 0, delay: 400.ms, duration: 800.ms),

              const SizedBox(height: 32),

              // Interests Section
              Text(
                'Interests',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ).animate()
                .fadeIn(delay: 600.ms, duration: 600.ms),

              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableInterests.map((interest) {
                  final isSelected = _selectedInterests.contains(interest);
                  return FilterChip(
                    label: Text(interest),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          if (_selectedInterests.length < 10) {
                            _selectedInterests.add(interest);
                          }
                        } else {
                          _selectedInterests.remove(interest);
                        }
                      });
                    },
                    selectedColor: AppTheme.primaryPink,
                    checkmarkColor: Colors.white,
                    backgroundColor: AppTheme.lightPink.withOpacity(0.3),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.darkGray,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }).toList(),
              ).animate()
                .fadeIn(delay: 700.ms, duration: 800.ms),

              const SizedBox(height: 32),

              // Hobbies Section
              Text(
                'Hobbies',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ).animate()
                .fadeIn(delay: 800.ms, duration: 600.ms),

              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableHobbies.map((hobby) {
                  final isSelected = _selectedHobbies.contains(hobby);
                  return FilterChip(
                    label: Text(hobby),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          if (_selectedHobbies.length < 10) {
                            _selectedHobbies.add(hobby);
                          }
                        } else {
                          _selectedHobbies.remove(hobby);
                        }
                      });
                    },
                    selectedColor: AppTheme.purple,
                    checkmarkColor: Colors.white,
                    backgroundColor: AppTheme.lightPurple.withOpacity(0.3),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.darkGray,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }).toList(),
              ).animate()
                .fadeIn(delay: 900.ms, duration: 800.ms),

              const SizedBox(height: 32),

              // Selection Counter
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.lightPink.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppTheme.primaryPink,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Selected ${_selectedInterests.length + _selectedHobbies.length} items. You need at least 5 to continue.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.darkGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate()
                .fadeIn(delay: 1000.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, delay: 1000.ms, duration: 600.ms),

              const SizedBox(height: 40),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _canContinue() ? _continue : null,
                  child: const Text('Continue'),
                ),
              ).animate()
                .fadeIn(delay: 1200.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, delay: 1200.ms, duration: 600.ms),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  bool _canContinue() {
    return (_selectedInterests.length + _selectedHobbies.length) >= 5;
  }

  void _continue() {
    final updatedData = Map<String, dynamic>.from(widget.profileData);
    updatedData['interests'] = _selectedInterests;
    updatedData['hobbies'] = _selectedHobbies;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RelationshipGoalsScreen(profileData: updatedData),
      ),
    );
  }
}
