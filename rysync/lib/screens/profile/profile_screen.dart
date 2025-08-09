import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Edit profile
            },
            icon: const Icon(Icons.edit),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'settings':
                  // TODO: Open settings
                  break;
                case 'logout':
                  _showLogoutDialog(context);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(context).animate()
              .fadeIn(duration: 800.ms)
              .slideY(begin: -0.3, end: 0, duration: 800.ms),

            // Profile Stats
            _buildProfileStats(context).animate()
              .fadeIn(delay: 200.ms, duration: 600.ms)
              .slideY(begin: 0.3, end: 0, delay: 200.ms, duration: 600.ms),

            // Profile Options
            _buildProfileOptions(context).animate()
              .fadeIn(delay: 400.ms, duration: 600.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Profile Photo
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://picsum.photos/200/200?random=user'),
                backgroundColor: AppTheme.lightPink,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryPink,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Name and Age
          Text(
            'John Doe, 28',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // Bio
          Text(
            'Software developer who loves hiking, cooking, and meeting new people. Looking for meaningful connections.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.lightGray,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 16),

          // Verification Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified,
                  color: Colors.green,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Verified',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStats(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryPink.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('23', 'Likes'),
          _buildStatItem('12', 'Matches'),
          _buildStatItem('8', 'Chats'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryPink,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.lightGray,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    final options = [
      ProfileOption(
        icon: Icons.person,
        title: 'Edit Profile',
        subtitle: 'Update your photos and information',
        onTap: () {},
      ),
      ProfileOption(
        icon: Icons.settings,
        title: 'Preferences',
        subtitle: 'Dating preferences and filters',
        onTap: () {},
      ),
      ProfileOption(
        icon: Icons.notifications,
        title: 'Notifications',
        subtitle: 'Manage your notification settings',
        onTap: () {},
      ),
      ProfileOption(
        icon: Icons.security,
        title: 'Privacy & Safety',
        subtitle: 'Control your privacy settings',
        onTap: () {},
      ),
      ProfileOption(
        icon: Icons.help,
        title: 'Help & Support',
        subtitle: 'Get help and contact support',
        onTap: () {},
      ),
      ProfileOption(
        icon: Icons.star,
        title: 'Upgrade to Premium',
        subtitle: 'Unlock exclusive features',
        onTap: () {},
        isSpecial: true,
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: options.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final option = options[index];
        return Card(
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: option.isSpecial 
                    ? Colors.orange.withOpacity(0.2)
                    : AppTheme.lightPink.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                option.icon,
                color: option.isSpecial ? Colors.orange : AppTheme.primaryPink,
              ),
            ),
            title: Text(
              option.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: option.isSpecial ? Colors.orange : null,
              ),
            ),
            subtitle: Text(option.subtitle),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: option.onTap,
          ),
        ).animate(delay: (index * 50).ms)
          .fadeIn(duration: 400.ms)
          .slideX(begin: 0.3, end: 0, duration: 400.ms);
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement logout logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class ProfileOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isSpecial;

  ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isSpecial = false,
  });
}
