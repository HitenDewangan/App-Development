import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../core/theme/app_theme.dart';
import 'interests_screen.dart';

class PhotosScreen extends StatefulWidget {
  final Map<String, dynamic> basicInfo;

  const PhotosScreen({
    super.key,
    required this.basicInfo,
  });

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final List<XFile?> _photos = List.filled(6, null);
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Photos'),
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
                      value: 0.4,
                      backgroundColor: AppTheme.lightPink.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryPink),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '2 / 5',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightGray,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms),

              const SizedBox(height: 32),

              // Title
              Text(
                'Show your best self',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryPink,
                ),
              ).animate()
                .fadeIn(delay: 200.ms, duration: 800.ms)
                .slideX(begin: -0.3, end: 0, delay: 200.ms, duration: 800.ms),

              const SizedBox(height: 8),

              Text(
                'Add at least 2 photos to continue. Your first photo will be your main profile picture.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.lightGray,
                ),
              ).animate()
                .fadeIn(delay: 400.ms, duration: 800.ms)
                .slideX(begin: -0.3, end: 0, delay: 400.ms, duration: 800.ms),

              const SizedBox(height: 40),

              // Photos Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _buildPhotoCard(index);
                },
              ).animate()
                .fadeIn(delay: 600.ms, duration: 800.ms),

              const SizedBox(height: 40),

              // Photo Tips
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.lightPink.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: AppTheme.primaryPink,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Photo Tips',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.primaryPink,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildTip('Use high-quality, recent photos'),
                    _buildTip('Show your face clearly'),
                    _buildTip('Smile and look approachable'),
                    _buildTip('Include variety in your photos'),
                  ],
                ),
              ).animate()
                .fadeIn(delay: 800.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, delay: 800.ms, duration: 600.ms),

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
                .fadeIn(delay: 1000.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, delay: 1000.ms, duration: 600.ms),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoCard(int index) {
    final photo = _photos[index];
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _addPhoto(index),
        child: photo != null
            ? Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(photo.path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (index == 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryPink,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'MAIN',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(Icons.close, size: 16, color: Colors.white),
                        onPressed: () => _removePhoto(index),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 48,
                    color: AppTheme.lightGray,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    index == 0 ? 'Add Main Photo' : 'Add Photo',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightGray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    ).animate(delay: (index * 100).ms)
      .fadeIn(duration: 600.ms)
      .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0));
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              color: AppTheme.primaryPink,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.darkGray,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addPhoto(int index) async {
    try {
      final ImageSource? source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        ),
      );

      if (source != null) {
        final XFile? image = await _picker.pickImage(source: source);
        if (image != null) {
          setState(() {
            _photos[index] = image;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _photos[index] = null;
    });
  }

  bool _canContinue() {
    return _photos.where((photo) => photo != null).length >= 2;
  }

  void _continue() {
    final photoUrls = _photos
        .where((photo) => photo != null)
        .map((photo) => photo!.path)
        .toList();

    final updatedInfo = Map<String, dynamic>.from(widget.basicInfo);
    updatedInfo['photos'] = photoUrls;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InterestsScreen(profileData: updatedInfo),
      ),
    );
  }
}
