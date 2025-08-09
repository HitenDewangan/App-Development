import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../models/user_model.dart';
import 'photos_screen.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _ageController = TextEditingController();
  final _cityController = TextEditingController();

  Gender _selectedGender = Gender.preferNotToSay;
  Gender _interestedIn = Gender.preferNotToSay;

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Information'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress indicator
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.2,
                        backgroundColor: AppTheme.lightPink.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryPink),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '1 / 5',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightGray,
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 600.ms),

                const SizedBox(height: 32),

                // Title
                Text(
                  'Tell us about yourself',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPink,
                  ),
                ).animate()
                  .fadeIn(delay: 200.ms, duration: 800.ms)
                  .slideX(begin: -0.3, end: 0, delay: 200.ms, duration: 800.ms),

                const SizedBox(height: 8),

                Text(
                  'This information will help us find better matches for you.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.lightGray,
                  ),
                ).animate()
                  .fadeIn(delay: 400.ms, duration: 800.ms)
                  .slideX(begin: -0.3, end: 0, delay: 400.ms, duration: 800.ms),

                const SizedBox(height: 40),

                // Display Name
                TextFormField(
                  controller: _displayNameController,
                  decoration: const InputDecoration(
                    labelText: 'Display Name',
                    hintText: 'How should others see you?',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your display name';
                    }
                    return null;
                  },
                ).animate()
                  .fadeIn(delay: 600.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, delay: 600.ms, duration: 600.ms),

                const SizedBox(height: 20),

                // Age
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    hintText: 'How old are you?',
                    prefixIcon: Icon(Icons.cake),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 18 || age > 100) {
                      return 'Please enter a valid age (18-100)';
                    }
                    return null;
                  },
                ).animate()
                  .fadeIn(delay: 700.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, delay: 700.ms, duration: 600.ms),

                const SizedBox(height: 20),

                // City
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    hintText: 'Where are you located?',
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ).animate()
                  .fadeIn(delay: 800.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, delay: 800.ms, duration: 600.ms),

                const SizedBox(height: 32),

                // Gender Selection
                Text(
                  'Gender',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ).animate()
                  .fadeIn(delay: 900.ms, duration: 600.ms),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: Gender.values.map((gender) {
                    return ChoiceChip(
                      label: Text(gender.name.toUpperCase()),
                      selected: _selectedGender == gender,
                      onSelected: (selected) {
                        setState(() {
                          _selectedGender = gender;
                        });
                      },
                      selectedColor: AppTheme.primaryPink,
                      backgroundColor: AppTheme.lightPink.withOpacity(0.3),
                      labelStyle: TextStyle(
                        color: _selectedGender == gender 
                            ? Colors.white 
                            : AppTheme.darkGray,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }).toList(),
                ).animate()
                  .fadeIn(delay: 1000.ms, duration: 600.ms),

                const SizedBox(height: 32),

                // Interested In
                Text(
                  'Interested In',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ).animate()
                  .fadeIn(delay: 1100.ms, duration: 600.ms),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: Gender.values.map((gender) {
                    return ChoiceChip(
                      label: Text(gender.name.toUpperCase()),
                      selected: _interestedIn == gender,
                      onSelected: (selected) {
                        setState(() {
                          _interestedIn = gender;
                        });
                      },
                      selectedColor: AppTheme.primaryPink,
                      backgroundColor: AppTheme.lightPink.withOpacity(0.3),
                      labelStyle: TextStyle(
                        color: _interestedIn == gender 
                            ? Colors.white 
                            : AppTheme.darkGray,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }).toList(),
                ).animate()
                  .fadeIn(delay: 1200.ms, duration: 600.ms),

                const SizedBox(height: 32),

                // Bio
                TextFormField(
                  controller: _bioController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Bio',
                    hintText: 'Tell us a bit about yourself...',
                    prefixIcon: Icon(Icons.edit),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please write a short bio about yourself';
                    }
                    return null;
                  },
                ).animate()
                  .fadeIn(delay: 1300.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, delay: 1300.ms, duration: 600.ms),

                const SizedBox(height: 40),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _continue,
                    child: const Text('Continue'),
                  ),
                ).animate()
                  .fadeIn(delay: 1400.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, delay: 1400.ms, duration: 600.ms),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _continue() {
    if (_formKey.currentState!.validate()) {
      if (_selectedGender == Gender.preferNotToSay) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select your gender')),
        );
        return;
      }

      if (_interestedIn == Gender.preferNotToSay) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select who you\'re interested in')),
        );
        return;
      }

      // Navigate to photos screen with basic info
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PhotosScreen(
            basicInfo: {
              'displayName': _displayNameController.text,
              'bio': _bioController.text,
              'age': int.parse(_ageController.text),
              'city': _cityController.text,
              'gender': _selectedGender,
              'interestedIn': _interestedIn,
            },
          ),
        ),
      );
    }
  }
}
