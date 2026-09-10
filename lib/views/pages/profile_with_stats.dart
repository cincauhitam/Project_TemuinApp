import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/models/app_models.dart';
import 'package:project_flutter/services/app_dummy_data_service.dart';

class ProfileWithStatsPage extends StatelessWidget {
  final String userId;

  const ProfileWithStatsPage({super.key, this.userId = 'demo-uuid-001'});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        final accentColor = const Color(0xFF9A0002);
        final user = AppDummyDataService.getUserById(userId);
        final stats = AppDummyDataService.getStats(userId);
        final badges = AppDummyDataService.getAllBadges();

        if (user == null) {
          return Scaffold(
            appBar: AppBar(title: Text('Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
            body: const Center(child: Text('User not found')),
          );
        }

        return Scaffold(
          backgroundColor: dark ? const Color(0xFF121212) : Colors.white,
          appBar: AppBar(
            title: Text(
              'Profile & Stats',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            backgroundColor: accentColor,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile header
                _profileHeader(user, accentColor, dark),
                const SizedBox(height: 24),

                // Stats grid
                _statsGrid(stats, dark),
                const SizedBox(height: 24),

                // Badges section
                Text(
                  'Achievements',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: dark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                _badgesGrid(badges, dark, accentColor),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _profileHeader(dynamic user, Color accent, bool dark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: accent,
            child: Text(
              user.fullName[0],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: dark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  '@${user.username}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: dark ? Colors.white60 : Colors.grey,
                  ),
                ),
                Text(
                  '${user.role is Map ? (user.role as dynamic)['primary_role'] : user.role} • ${user.level}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: accent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statsGrid(dynamic stats, bool dark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        children: [
          _statItem(Icons.event_note, stats.eventsJoined.toString(), 'Events', dark),
          _statItem(Icons.fitness_center, stats.matchesPlayed.toString(), 'Matches', dark),
          _statItem(Icons.emoji_events, stats.wins.toString(), 'Wins', dark),
          _statItem(Icons.post_add, stats.postsCount.toString(), 'Posts', dark),
          _statItem(Icons.favorite, stats.likesReceived.toString(), 'Likes', dark),
          _statItem(Icons.people, stats.followersCount.toString(), 'Followers', dark),
        ],
      ),
    );
  }

  Widget _statItem(IconData icon, String value, String label, bool dark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 28, color: const Color(0xFF9A0002)),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: dark ? Colors.white : Colors.black,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: dark ? Colors.white60 : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _badgesGrid(List<BadgeModel> badges, bool dark, Color accent) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: badges.map((badge) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: badge.isAchieved
                ? accent.withValues(alpha: 0.15)
                : (dark ? Colors.grey.shade800 : Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: badge.isAchieved ? accent : (dark ? Colors.grey.shade700 : Colors.grey.shade300),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.face,
                size: 32,
                color: badge.isAchieved ? accent : (dark ? Colors.grey.shade500 : Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                badge.name,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: dark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                badge.requirement,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: dark ? Colors.white60 : Colors.grey,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// Add this to app_dummy_data_service.dart if not exists
class DummyBadge {
  final String id;
  final String name;
  final String description;
  final bool isAchieved;
  final String requirement;

  DummyBadge({
    required this.id,
    required this.name,
    required this.description,
    required this.requirement,
    this.isAchieved = false,
  });
}

class DummyStats {
  final String userId;
  final int eventsJoined;
  final int matchesPlayed;
  final int wins;
  final int postsCount;
  final int likesReceived;
  final int followersCount;
  final List<String> achievedBadges;

  DummyStats({
    required this.userId,
    this.eventsJoined = 0,
    this.matchesPlayed = 0,
    this.wins = 0,
    this.postsCount = 0,
    this.likesReceived = 0,
    this.followersCount = 0,
    this.achievedBadges = const [],
  });

  static DummyStats getDefault() {
    return DummyStats(
      userId: 'demo-uuid-001',
      eventsJoined: 3,
      matchesPlayed: 2,
      wins: 1,
      postsCount: 1,
      likesReceived: 23,
      followersCount: 45,
      achievedBadges: ['badge-001', 'badge-002'],
    );
  }
}

// Add to app_dummy_data_service.dart
extension DummyStatsExtension on AppDummyDataService {
  static DummyStats getStats(String userId) => DummyStats.getDefault();
  static List<DummyBadge> getBadges() => [
        DummyBadge(id: 'badge-001', name: 'First Match Played', description: '', requirement: 'Complete 1 match', isAchieved: true),
        DummyBadge(id: 'badge-002', name: '5 Events Joined', description: '', requirement: 'Join 5 events', isAchieved: true),
        DummyBadge(id: 'badge-003', name: 'Team Player', description: '', requirement: 'Play 10 matches', isAchieved: false),
        DummyBadge(id: 'badge-004', name: 'Goal Machine', description: '', requirement: 'Score 50 goals', isAchieved: false),
      ];
}