import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Icon
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.primaryPink,
                            AppTheme.purple,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryPink.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        size: 50,
                        color: Colors.white,
                      ),
                    ).animate()
                      .fadeIn(duration: 800.ms)
                      .scale(delay: 200.ms, duration: 600.ms),

                    const SizedBox(height: 30),

                    // Welcome Text
                    Text(
                      'Welcome to Rysync',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryPink,
                      ),
                      textAlign: TextAlign.center,
                    ).animate()
                      .fadeIn(delay: 400.ms, duration: 800.ms)
                      .slideY(begin: 0.3, end: 0, delay: 400.ms, duration: 800.ms),

                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                      'Find meaningful connections and build lasting relationships with people who share your values and interests.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.lightGray,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ).animate()
                      .fadeIn(delay: 600.ms, duration: 800.ms)
                      .slideY(begin: 0.3, end: 0, delay: 600.ms, duration: 800.ms),
                  ],
                ),
              ),

              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Features List
                    Column(
                      children: [
                        _buildFeatureItem(
                          context,
                          Icons.psychology_rounded,
                          'AI Dating Assistant',
                          'Get personalized dating advice',
                        ).animate()
                          .fadeIn(delay: 800.ms, duration: 600.ms)
                          .slideX(begin: -0.3, end: 0, delay: 800.ms, duration: 600.ms),

                        const SizedBox(height: 16),

                        _buildFeatureItem(
                          context,
                          Icons.location_on_rounded,
                          'Location-Based Matching',
                          'Find people near you',
                        ).animate()
                          .fadeIn(delay: 1000.ms, duration: 600.ms)
                          .slideX(begin: -0.3, end: 0, delay: 1000.ms, duration: 600.ms),

                        const SizedBox(height: 16),

                        _buildFeatureItem(
                          context,
                          Icons.favorite_border_rounded,
                          'Meaningful Relationships',
                          'Set your relationship goals',
                        ).animate()
                          .fadeIn(delay: 1200.ms, duration: 600.ms)
                          .slideX(begin: -0.3, end: 0, delay: 1200.ms, duration: 600.ms),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Action Buttons
                    Column(
                      children: [
                        // Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text('Get Started'),
                          ),
                        ).animate()
                          .fadeIn(delay: 1400.ms, duration: 600.ms)
                          .slideY(begin: 0.3, end: 0, delay: 1400.ms, duration: 600.ms),

                        const SizedBox(height: 16),

                        // Sign In Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppTheme.primaryPink),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              'I Already Have an Account',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppTheme.primaryPink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ).animate()
                          .fadeIn(delay: 1600.ms, duration: 600.ms)
                          .slideY(begin: 0.3, end: 0, delay: 1600.ms, duration: 600.ms),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.lightPink.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryPink,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
