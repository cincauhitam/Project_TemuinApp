import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/app_dummy_data_service.dart';
import 'event_detail_page.dart';
import 'feed_page.dart';

// ============================================================================
// Constants — theme, spacing, sizing shared across the page
// ============================================================================

/// Accent color used across home page widgets.
const Color kAccentColor = Color(0xFF9A0002);

/// Dark card background.
const Color kDarkCardBg = Color(0xFF1E1E1E);

/// Scaffold dark background.
const Color kScaffoldDark = Color(0xFF121212);

/// Default card padding.
const EdgeInsets kCardPadding = const EdgeInsets.all(14);

/// Card margin between items.
const double kCardMargin = 12.0;

/// Small spacing (8px).
const double kSpacingSmall = 8.0;

/// Medium spacing (16px — also the page body padding).
const double kSpacingMedium = 16.0;

/// Large spacing (24px).
const double kSpacingLarge = 24.0;

/// Avatar radius for event cards.
const double kEventAvatarSize = 80.0;

/// Avatar radius for post card avatars.
const double kPostAvatarRadius = 18.0;

// ============================================================================
// HomePage — top-level tab/home screen of the app
// ============================================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<dynamic> _nearbyEvents;
  bool _loading = true;

  @override void initState() {
    super.initState();
    _loadData();
  }

  /// Load nearby events and posts from the dummy data service.
  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _nearbyEvents = AppDummyDataService.getNearbyEvents(maxDaysAhead: 7);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        final accentColor = kAccentColor;
        final textPrimary = dark ? Colors.white : Colors.black;

        return Scaffold(
          backgroundColor: dark ? kScaffoldDark : Colors.white,
          body: RefreshIndicator(
            onRefresh: _loadData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(kSpacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== Section: Activity Nearby Header =====
                  Text(
                    'ACTIVITY NEARBY',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ===== Section: Nearby Events List =====
                  if (_loading)
                    Center(
                      child: CircularProgressIndicator(color: accentColor),
                    )
                  else if (_nearbyEvents.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Text(
                          'No upcoming events nearby',
                          style: GoogleFonts.poppins(
                            color: dark ? Colors.white60 : Colors.grey,
                          ),
                        ),
                      ),
                    )
                  else
                    ..._nearbyEvents.map((e) => _EventCard(event: e, dark: dark)),

                  const SizedBox(height: kSpacingLarge),

                  // ===== Section: Feed Header =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'FEED',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh, color: textPrimary),
                        onPressed: _loadData,
                      ),
                    ],
                  ),
                  const SizedBox(height: kSpacingSmall),

                  // ===== Section: Feed TabBar + Post Cards =====
                  DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          dividerColor: Colors.transparent,
                          labelColor: accentColor,
                          unselectedLabelColor:
                              dark ? Colors.white60 : Colors.black54,
                          indicatorColor: accentColor,
                          tabs: const [
                            Tab(text: 'All'),
                            Tab(text: 'User'),
                            Tab(text: 'Community'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...AppDummyDataService.getPosts().map(
                          (p) => _PostCard(post: p, dark: dark),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ============================================================================
// _EventCard — displays a single event from the "Activity Nearby" section
// ============================================================================

class _EventCard extends StatelessWidget {
  final dynamic event;
  final bool dark;

  const _EventCard({required this.event, required this.dark});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => EventDetailPage(event: event)),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: kCardMargin),
        padding: kCardPadding,
        decoration: BoxDecoration(
          color: dark ? kDarkCardBg : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Event icon placeholder
            _EventIconPlaceholder(),

            const SizedBox(width: 12),

            // Event details column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: dark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: kSpacingSmall),

                  // Location row
                  _InfoRow(
                    icon: Icons.location_on,
                    text: event.place,
                    accentColor: kAccentColor,
                    dark: dark,
                  ),
                  const SizedBox(height: kSpacingSmall),

                  // Date/time row
                  _InfoRow(
                    icon: Icons.event,
                    text: _formatEventDateTime(event.dateTime),
                    accentColor: kAccentColor,
                    dark: dark,
                  ),
                  const SizedBox(height: kSpacingSmall),

                  // Participants row
                  _ParticipantsRow(
                    event: event,
                    accentColor: kAccentColor,
                    dark: dark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Format an [event]'s date/time as 'DD/MM/YYYY HH:mm'.
  String _formatEventDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

// ============================================================================
// Helper widgets extracted from _EventCard for single responsibility
// ============================================================================

/// Event icon placeholder — colored square with soccer ball icon.
class _EventIconPlaceholder extends StatelessWidget {
  const _EventIconPlaceholder();

  @override
  Widget build(BuildContext context) => Container(
        width: kEventAvatarSize,
        height: kEventAvatarSize,
        decoration: BoxDecoration(
          color: kAccentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.sports_soccer,
          color: Colors.white,
          size: 36,
        ),
      );
}

/// A single info row with icon + text (location, date, etc.).
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color accentColor;
  final bool dark;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.accentColor,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, size: 14, color: accentColor),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: dark ? Colors.white70 : Colors.black54,
              ),
            ),
          ),
        ],
      );
}

/// Participants count row with optional "Low slots!" warning badge.
class _ParticipantsRow extends StatelessWidget {
  final dynamic event;
  final Color accentColor;
  final bool dark;

  const _ParticipantsRow({
    required this.event,
    required this.accentColor,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(Icons.group, size: 14, color: accentColor),
          const SizedBox(width: 4),
          Text(
            '${event.participants.length}/${event.maxPlayers} players',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: dark ? Colors.white70 : Colors.black54,
            ),
          ),
          if (event.remainingSlots <= 2 && event.remainingSlots > 0) ...[
            const SizedBox(width: 6),
            _LowSlotsBadge(),
          ],
        ],
      );
}

/// Warning badge shown when event has ≤2 remaining slots.
class _LowSlotsBadge extends StatelessWidget {
  const _LowSlotsBadge();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.orange.withAlpha(38),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Low slots!',
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: Colors.orange,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}

// ============================================================================
// _PostCard — displays a single post from the feed section
// ============================================================================

class _PostCard extends StatelessWidget {
  final dynamic post;
  final bool dark;

  const _PostCard({required this.post, required this.dark});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FeedPage()),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: kCardMargin),
          padding: kCardPadding,
          decoration: BoxDecoration(
            color: dark ? kDarkCardBg : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Section: Post Header (avatar + name + type + time) =====
              _PostHeaderRow(post: post, dark: dark),

              // ===== Section: Caption =====
              if (post.caption != null) ...[
                const SizedBox(height: kSpacingSmall),
                Text(
                  post.caption!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: dark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],

              // ===== Section: Likes/Comments Bar =====
              const SizedBox(height: kSpacingMedium),
              _PostStatsRow(post: post, dark: dark),
            ],
          ),
        ),
      );
}

// ============================================================================
// Helper widgets extracted from _PostCard for single responsibility
// ============================================================================

/// Post header row — avatar, username, type label, time-ago.
class _PostHeaderRow extends StatelessWidget {
  final dynamic post;
  final bool dark;

  const _PostHeaderRow({required this.post, required this.dark});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          CircleAvatar(
            radius: kPostAvatarRadius,
            backgroundColor: kAccentColor,
            child: Text(
              post.username[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.username,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  _typeLabel(post.postType),
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: _postTypeColor(post.postType),
                  ),
                ),
              ],
            ),
          ),
          Text(
            _timeAgo(post.createdAt),
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: dark ? Colors.white60 : Colors.black54,
            ),
          ),
        ],
      );

  String _typeLabel(String t) => switch (t) {
        'group' => 'Group Post',
        'community' => 'Community',
        _ => 'User Post',
      };

  Color _postTypeColor(String t) => switch (t) {
        'group' => Colors.blue,
        'community' => Colors.purple,
        _ => kAccentColor,
      };

  String _timeAgo(DateTime dt) {
    final d = DateTime.now().difference(dt);
    if (d.inMinutes < 60) return '${d.inMinutes}m ago';
    if (d.inHours < 24) return '${d.inHours}h ago';
    return '${d.inDays}d ago';
  }
}

/// Likes and comments stats row at the bottom of a post card.
class _PostStatsRow extends StatelessWidget {
  final dynamic post;
  final bool dark;

  const _PostStatsRow({required this.post, required this.dark});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(Icons.favorite, size: 20, color: _likesColor),
          const SizedBox(width: 6),
          Text(post.likesCount.toString()),
          const SizedBox(width: 24),
          Icon(Icons.comment, size: 20, color: _commentsColor),
          const SizedBox(width: 6),
          Text(post.commentsCount.toString()),
        ],
      );

  Color get _likesColor => post.isLiked ? kAccentColor : (dark ? Colors.white54 : Colors.grey.shade400);
  Color get _commentsColor => dark ? Colors.white54 : Colors.grey.shade400;
}
