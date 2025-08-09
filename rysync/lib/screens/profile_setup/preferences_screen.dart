import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../home/home_screen.dart';

class PreferencesScreen extends StatefulWidget {
  final Map<String, dynamic> profileData;

  const PreferencesScreen({
    super.key,
    required this.profileData,
  });

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  double _minAge = 18;
  double _maxAge = 35;
  double _maxDistance = 50;
  bool _showOnlineStatus = true;
  bool _allowLocationSharing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dating Preferences'),
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
                      value: 1.0,
                      backgroundColor: AppTheme.lightPink.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryPink),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '5 / 5',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightGray,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms),

              const SizedBox(height: 32),

              // Title
              Text(
                'Set your preferences',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryPink,
                ),
              ).animate()
                .fadeIn(delay: 200.ms, duration: 800.ms)
                .slideX(begin: -0.3, end: 0, delay: 200.ms, duration: 800.ms),

              const SizedBox(height: 8),

              Text(
                'Help us find the perfect matches for you by setting your preferences.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.lightGray,
                ),
              ).animate()
                .fadeIn(delay: 400.ms, duration: 800.ms)
                .slideX(begin: -0.3, end: 0, delay: 400.ms, duration: 800.ms),

              const SizedBox(height: 40),

              // Age Range
              _buildPreferenceCard(
                title: 'Age Range',
                icon: Icons.cake,
                child: Column(
                  children: [
                    Text(
                      '${_minAge.round()} - ${_maxAge.round()} years old',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryPink,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Minimum Age: ${_minAge.round()}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Slider(
                      value: _minAge,
                      min: 18,
                      max: 80,
                      divisions: 62,
                      activeColor: AppTheme.primaryPink,
                      onChanged: (value) {
                        setState(() {
                          _minAge = value;
                          if (_minAge >= _maxAge) {
                            _maxAge = _minAge + 1;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Maximum Age: ${_maxAge.round()}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Slider(
                      value: _maxAge,
                      min: 19,
                      max: 99,
                      divisions: 80,
                      activeColor: AppTheme.primaryPink,
                      onChanged: (value) {
                        setState(() {
                          _maxAge = value;
                          if (_maxAge <= _minAge) {
                            _minAge = _maxAge - 1;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ).animate()
                .fadeIn(delay: 600.ms, duration: 800.ms)
                .slideY(begin: 0.3, end: 0, delay: 600.ms, duration: 800.ms),

              const SizedBox(height: 24),

              // Distance Range
              _buildPreferenceCard(
                title: 'Maximum Distance',
                icon: Icons.location_on,
                child: Column(
                  children: [
                    Text(
                      'Up to ${_maxDistance.round()} km away',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryPink,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: _maxDistance,
                      min: 1,
                      max: 200,
                      divisions: 199,
                      activeColor: AppTheme.primaryPink,
                      onChanged: (value) {
                        setState(() {
                          _maxDistance = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1 km',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.lightGray,
                          ),
                        ),
                        Text(
                          '200+ km',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.lightGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate()
                .fadeIn(delay: 700.ms, duration: 800.ms)
                .slideY(begin: 0.3, end: 0, delay: 700.ms, duration: 800.ms),

              const SizedBox(height: 24),

              // Privacy Settings
              _buildPreferenceCard(
                title: 'Privacy Settings',
                icon: Icons.privacy_tip,
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Show online status'),
                      subtitle: const Text('Let others see when you\'re active'),
                      value: _showOnlineStatus,
                      activeColor: AppTheme.primaryPink,
                      onChanged: (value) {
                        setState(() {
                          _showOnlineStatus = value;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    const Divider(),
                    SwitchListTile(
                      title: const Text('Share location'),
                      subtitle: const Text('Allow location-based matching'),
                      value: _allowLocationSharing,
                      activeColor: AppTheme.primaryPink,
                      onChanged: (value) {
                        setState(() {
                          _allowLocationSharing = value;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ).animate()
                .fadeIn(delay: 800.ms, duration: 800.ms)
                .slideY(begin: 0.3, end: 0, delay: 800.ms, duration: 800.ms),

              const SizedBox(height: 40),

              // Complete Profile Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _completeProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryPink,
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Complete Profile',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.celebration, size: 20),
                    ],
                  ),
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

  Widget _buildPreferenceCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.lightPink.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: AppTheme.primaryPink,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  void _completeProfile() async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryPink),
            ),
            const SizedBox(height: 16),
            const Text('Creating your profile...'),
          ],
        ),
      ),
    );

    // Simulate profile creation
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.of(context).pop(); // Close loading dialog

      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryPink,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Profile Complete!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryPink,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome to Rysync! Start exploring and find your perfect match.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightGray,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close success dialog
                    
                    // Navigate to home screen
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text('Start Matching'),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
