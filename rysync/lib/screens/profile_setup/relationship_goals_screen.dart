import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../models/user_model.dart';
import 'preferences_screen.dart';

class RelationshipGoalsScreen extends StatefulWidget {
  final Map<String, dynamic> profileData;

  const RelationshipGoalsScreen({
    super.key,
    required this.profileData,
  });

  @override
  State<RelationshipGoalsScreen> createState() => _RelationshipGoalsScreenState();
}

class _RelationshipGoalsScreenState extends State<RelationshipGoalsScreen> {
  RelationshipType? _selectedRelationshipType;
  final TextEditingController _descriptionController = TextEditingController();

  final Map<RelationshipType, Map<String, dynamic>> _relationshipTypeData = {
    RelationshipType.temporary: {
      'title': 'Temporary Companion',
      'description': 'Looking for companionship for a specific period',
      'icon': Icons.schedule,
      'examples': ['Seasonal relationship', 'Short-term dating', 'Travel companion'],
    },
    RelationshipType.casual: {
      'title': 'Casual Dating',
      'description': 'Keeping things light and fun without commitment',
      'icon': Icons.favorite_border,
      'examples': ['Dating multiple people', 'No pressure', 'Going with the flow'],
    },
    RelationshipType.serious: {
      'title': 'Serious Relationship',
      'description': 'Ready for an exclusive, committed relationship',
      'icon': Icons.favorite,
      'examples': ['Monogamous relationship', 'Building together', 'Long-term commitment'],
    },
    RelationshipType.marriage: {
      'title': 'Marriage',
      'description': 'Looking for a life partner to marry',
      'icon': Icons.favorite,
      'examples': ['Life partnership', 'Starting a family', 'Growing old together'],
    },
    RelationshipType.friendship: {
      'title': 'Friendship',
      'description': 'Seeking meaningful platonic connections',
      'icon': Icons.group,
      'examples': ['Best friends', 'Activity partners', 'Emotional support'],
    },
    RelationshipType.companionship: {
      'title': 'Companionship',
      'description': 'Looking for someone to share life experiences',
      'icon': Icons.people,
      'examples': ['Life companion', 'Shared interests', 'Mutual support'],
    },
  };

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relationship Goals'),
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
                      value: 0.8,
                      backgroundColor: AppTheme.lightPink.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryPink),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '4 / 5',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightGray,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms),

              const SizedBox(height: 32),

              // Title
              Text(
                'What are you looking for?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryPink,
                ),
              ).animate()
                .fadeIn(delay: 200.ms, duration: 800.ms)
                .slideX(begin: -0.3, end: 0, delay: 200.ms, duration: 800.ms),

              const SizedBox(height: 8),

              Text(
                'Be honest about your relationship goals to find compatible matches.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.lightGray,
                ),
              ).animate()
                .fadeIn(delay: 400.ms, duration: 800.ms)
                .slideX(begin: -0.3, end: 0, delay: 400.ms, duration: 800.ms),

              const SizedBox(height: 32),

              // Relationship Type Options
              ...RelationshipType.values.map((type) {
                return _buildRelationshipCard(type);
              }).toList(),

              if (_selectedRelationshipType != null) ...[
                const SizedBox(height: 24),

                // Description Field
                Text(
                  'Tell us more about what you\'re looking for',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ).animate()
                  .fadeIn(delay: 800.ms, duration: 600.ms),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Describe your ideal relationship in detail...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ).animate()
                  .fadeIn(delay: 900.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, delay: 900.ms, duration: 600.ms),
              ],

              const SizedBox(height: 40),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedRelationshipType != null ? _continue : null,
                  child: const Text('Continue'),
                ),
              ).animate()
                .fadeIn(delay: 1000.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, delay: 1000.ms, duration: 600.ms),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRelationshipCard(RelationshipType type) {
    final data = _relationshipTypeData[type]!;
    final isSelected = _selectedRelationshipType == type;
    final index = RelationshipType.values.indexOf(type);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: isSelected ? 8 : 2,
        color: isSelected ? AppTheme.primaryPink : null,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedRelationshipType = type;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? Colors.white.withOpacity(0.2)
                            : AppTheme.lightPink.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        data['icon'],
                        color: isSelected ? Colors.white : AppTheme.primaryPink,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['title'],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data['description'],
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isSelected 
                                  ? Colors.white.withOpacity(0.9)
                                  : AppTheme.lightGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 24,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: (data['examples'] as List<String>).map((example) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? Colors.white.withOpacity(0.2)
                            : AppTheme.lightPink.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        example,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isSelected 
                              ? Colors.white
                              : AppTheme.darkGray,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate(delay: (index * 100).ms)
      .fadeIn(duration: 600.ms)
      .slideX(begin: -0.3, end: 0, duration: 600.ms);
  }

  void _continue() {
    final updatedData = Map<String, dynamic>.from(widget.profileData);
    updatedData['relationshipType'] = _selectedRelationshipType;
    updatedData['relationshipDescription'] = _descriptionController.text;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PreferencesScreen(profileData: updatedData),
      ),
    );
  }
}
