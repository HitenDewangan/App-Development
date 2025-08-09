import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const RysyncApp());
}

class RysyncApp extends StatelessWidget {
  const RysyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add providers here as needed
      ],
      child: MaterialApp(
        title: 'Rysync - Dating & Relationships',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, // Automatically switch based on system settings
        home: const SplashScreen(),
      ),
    );
  }
}
