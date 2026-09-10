import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/app_dummy_data_service.dart';
import 'package:project_flutter/models/app_models.dart';
import 'package:project_flutter/views/pages/followers_page.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const _accentColor = Color(0xFF9A0002);

  UserModel? _user;
  StatsModel? _stats;
  List<BadgeModel> _badges = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _user = AppDummyDataService.currentUser;
      _stats = AppDummyDataService.getStats(AppDummyDataService.currentUser.id);
      _badges = AppDummyDataService.getAllBadges();
    });
  }

  bool get _isDark => isDarkMode.value;
  Color get _textPrimary => _isDark ? Colors.white : Colors.black;
  Color get _textSecondary => _isDark ? Colors.white60 : Colors.black54;
  Color get _cardBg => _isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100;

  @override
  Widget build(BuildContext context) {
    if (_user == null || _stats == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: _accentColor)),
      );
    }

    final user = _user!;
    final stats = _stats!;

    return Scaffold(
      backgroundColor: _isDark ? const Color(0xFF121212) : Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(color: _accentColor),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProfileHeader(user),
                  const SizedBox(height: 20),
                  _buildStatsRow(stats),
                  const SizedBox(height: 16),
                  _buildDetailsCard(user),
                  const SizedBox(height: 16),
                  _buildFollowRow(context, stats),
                  const SizedBox(height: 16),
                  _buildBadgesSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(UserModel user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, size: 50, color: _accentColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullName,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              Text(
                "@${user.username}",
                style: GoogleFonts.poppins(fontSize: 14, color: _textSecondary),
              ),
              Row(
                children: [
                  Text(
                    "Age: ${user.age}  |  ",
                    style: GoogleFonts.poppins(fontSize: 12, color: _textSecondary),
                  ),
                  Text(
                    user.level.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: _accentColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _isDark ? Colors.white : _accentColor,
            foregroundColor: _isDark ? Colors.black : Colors.white,
          ),
          child: const Text('Edit'),
        ),
      ],
    );
  }

  Widget _buildStatsRow(StatsModel stats) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _statCard(Icons.event_note, '${stats.eventsJoined}', 'Events'),
        _statCard(Icons.fitness_center, '${stats.matchesPlayed}', 'Matches'),
        _statCard(Icons.emoji_events, '${stats.wins}', 'Wins'),
        _statCard(Icons.chat_bubble, '${stats.postsCount}', 'Posts'),
        _statCard(Icons.favorite, '${stats.likesReceived}', 'Likes'),
      ],
    );
  }

  Widget _buildDetailsCard(UserModel user) {
    final interests = user.interests as List?;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailRow(Icons.cake, 'Age', '${user.age}'),
          _detailRow(Icons.height, 'Height', '${user.height} cm'),
          if (user.weight != null)
            _detailRow(Icons.monitor_weight, 'Weight', '${user.weight} kg'),
          if (user.domisili != null)
            _detailRow(Icons.location_on, 'Location', user.domisili!),
          if (interests != null && interests.isNotEmpty)
            _detailRow(Icons.emoji_emotions, 'Interests', interests.join(', ')),
        ],
      ),
    );
  }

  Widget _buildFollowRow(BuildContext context, StatsModel stats) {
    return Row(
      children: [
        Expanded(
          child: _followCard(
            '${stats.followersCount}',
            'Followers',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FollowersPage(type: 'followers')),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _followCard(
            '${stats.followingCount}',
            'Following',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FollowersPage(type: 'following')),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadgesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Badges & Achievements",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _textPrimary,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BadgeGridPage()),
                ),
                child: Text('View All', style: GoogleFonts.poppins(color: _accentColor)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _badges.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _badgeChip(_badges[index]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statCard(IconData icon, String value, String label) {
    return Container(
      width: (MediaQuery.of(context).size.width - 52) / 3,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: _accentColor),
          const SizedBox(height: 6),
          Text(value, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: GoogleFonts.poppins(fontSize: 11, color: _textSecondary)),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: _accentColor),
          const SizedBox(width: 12),
          Text("$label: ", style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          Expanded(child: Text(value, style: GoogleFonts.poppins())),
        ],
      ),
    );
  }

  Widget _followCard(String count, String label, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(count, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: GoogleFonts.poppins(color: _textSecondary)),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            child: const Text('View'),
          ),
        ],
      ),
    );
  }

  Widget _badgeChip(BadgeModel badge) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: badge.isAchieved ? _cardBg : Colors.grey.shade200.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            badge.icon,
            size: 36,
            color: badge.isAchieved ? _accentColor : Colors.grey.shade400,
          ),
          const SizedBox(height: 6),
          Text(
            badge.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}