import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final double horizontalThreshold;
  final bool isFullScreen;
  final VoidCallback? onTap;

  const UserCard({
    super.key,
    required this.user,
    this.horizontalThreshold = 0.0,
    this.isFullScreen = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // Background Image
            _buildBackgroundImage(),
            
            // Content Gradient
            _buildContentGradient(),
            
            // Like/Pass Indicator
            if (!isFullScreen)
              _buildSwipeIndicator(),
              
            // User Details
            _buildUserDetails(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return CachedNetworkImage(
      imageUrl: user.photos.first,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(color: Colors.white),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _buildContentGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.8),
          ],
          stops: const [0.6, 1.0],
        ),
      ),
    );
  }

  Widget _buildSwipeIndicator() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (horizontalThreshold > 0) ...[
            _buildIndicator('LIKE', Colors.green),
            const Spacer(),
          ],
          if (horizontalThreshold < 0) ...[
            const Spacer(),
            _buildIndicator('PASS', Colors.red),
          ],
        ],
      ),
    );
  }

  Widget _buildIndicator(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _buildUserDetails(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and Age
          Text(
            '${user.displayName}, ${user.age}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                const Shadow(
                  blurRadius: 4,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Bio
          if (isFullScreen)
            Text(
              user.bio ?? 'No bio yet',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
                height: 1.4,
              ),
            ),
          
          const SizedBox(height: 12),
          
          // Interests & Hobbies
          if (isFullScreen)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...user.interests.map((interest) => 
                  _buildChip(interest, AppTheme.primaryPink)),
                ...user.hobbies.map((hobby) => 
                  _buildChip(hobby, AppTheme.purple)),
              ],
            ),
            
          const SizedBox(height: 12),
          
          // Location
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: Colors.white.withOpacity(0.8),
              ),
              const SizedBox(width: 4),
              Text(
                '${user.city}, ${user.country}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Relationship Goal
          Row(
            children: [
              Icon(
                Icons.favorite,
                size: 16,
                color: Colors.white.withOpacity(0.8),
              ),
              const SizedBox(width: 4),
              Text(
                user.relationshipTypeDisplay,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Online Status
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: user.isOnline ? Colors.green : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                user.isOnline ? 'Online' : 'Last seen ${user.lastSeen}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
