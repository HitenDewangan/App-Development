import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_theme.dart';
import 'auth/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
  }

  _navigateToWelcome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryPink,
              AppTheme.purple,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Icon/Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  size: 60,
                  color: AppTheme.primaryPink,
                ),
              ).animate()
                .fadeIn(duration: 800.ms)
                .scale(delay: 200.ms, duration: 600.ms),
              
              const SizedBox(height: 30),
              
              // App Name
              Text(
                'Rysync',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                ),
              ).animate()
                .fadeIn(delay: 600.ms, duration: 800.ms)
                .slideY(begin: 0.3, end: 0, delay: 600.ms, duration: 800.ms),
              
              const SizedBox(height: 10),
              
              // Tagline
              Text(
                'Find Your Perfect Match',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w300,
                ),
              ).animate()
                .fadeIn(delay: 1000.ms, duration: 800.ms)
                .slideY(begin: 0.3, end: 0, delay: 1000.ms, duration: 800.ms),
              
              const SizedBox(height: 50),
              
              // Loading indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ).animate()
                .fadeIn(delay: 1400.ms, duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}
