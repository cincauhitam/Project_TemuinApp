import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/app_dummy_data_service.dart';
import 'package:project_flutter/models/app_models.dart';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/// Accent color used across followers and badge pages.
const Color kAccentColor = Color(0xFF9A0002);

/// Default avatar radius.
const double kAvatarRadius = 24;

/// Badge grid spacing.
const double kBadgeSpacing = 12.0;

// ---------------------------------------------------------------------------
// FollowersPage — shows a list of followers or following users
// ---------------------------------------------------------------------------

class FollowersPage extends StatefulWidget {
  final String type; // 'followers' or 'following'

  const FollowersPage({super.key, required this.type});

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  /// List of users fetched based on the page type.
  late final List<UserModel> _users;

  String get _pageTitle =>
      widget.type == 'followers' ? 'Followers' : 'Following';

  String get _buttonText =>
      widget.type == 'followers' ? 'Follow Back' : 'Unfollow';

  @override
  void initState() {
    super.initState();
    _users = _loadUsers();
  }

  /// Load followers or following users depending on [widget.type].
  List<UserModel> _loadUsers() {
    final currentUserId = AppDummyDataService.currentUser.id;
    return widget.type == 'followers'
        ? AppDummyDataService.getFollowers(currentUserId)
        : AppDummyDataService.getFollowing(currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageTitle,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: kAccentColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(children: _users.map(_buildUserListTile).toList()),
          ),
          // ===== Section: Total Count Footer =====
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Total: ${_users.length}',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build a single user list tile for the followers/following list.
  Widget _buildUserListTile(UserModel user) {
    return ListTile(
      leading: CircleAvatar(
        radius: kAvatarRadius,
        backgroundColor: kAccentColor,
        child: Text(
          user.username[0],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        user.fullName,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      subtitle: Text('@', style: GoogleFonts.poppins(fontSize: 12)),
      trailing: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: kAccentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Text(_buttonText),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// BadgeGridPage — shows a grid of badges and achievements
// ---------------------------------------------------------------------------

class BadgeGridPage extends StatelessWidget {
  const BadgeGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = isDarkMode.value;
    final badges = AppDummyDataService.getAllBadges();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Badges & Achievements',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: kAccentColor,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(kBadgeSpacing),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: kBadgeSpacing,
          mainAxisSpacing: kBadgeSpacing,
          childAspectRatio: 0.85,
        ),
        itemCount: badges.length,
        itemBuilder: (context, index) => _buildBadgeCard(badges[index], dark),
      ),
    );
  }

  /// Build a single badge card widget.
  Widget _buildBadgeCard(BadgeModel badge, bool dark) {
    return Container(
      decoration: BoxDecoration(
        color: badge.isAchieved
            ? (dark ? const Color(0xFF1E1E1E) : Colors.grey.shade100)
            : Colors.grey.shade200.withAlpha(102),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Badge Icon
          Icon(
            badge.icon,
            size: 48,
            color: badge.isAchieved ? kAccentColor : Colors.grey.shade400,
          ),
          const SizedBox(height: 12),

          // Badge Name
          Text(
            badge.name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),

          // Requirement
          Text(
            badge.requirement,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: dark ? Colors.white54 : Colors.grey,
            ),
          ),

          // Progress indicator for unachieved badges
          if (!badge.isAchieved) ...[
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: badge.isAchieved ? 1.0 : 0.3,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation(kAccentColor),
            ),
            Text(
              '30% done',
              style: GoogleFonts.poppins(fontSize: 10, color: kAccentColor),
            ),
          ],
        ],
      ),
    );
  }
}
