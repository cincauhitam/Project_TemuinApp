import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:project_flutter/data/notifiers.dart';
import 'followers_page.dart';

/// Accent color used across the activity page.
const Color kAccentColor = Color(0xFF9A0002);

/// Theme-aware primary text color from dark mode notifier.
Color get kPrimaryTextColor => isDarkMode.value ? Colors.white : Colors.black87;

/// Theme-aware secondary/subtitle text color.
Color get kSecondaryTextColor =>
    isDarkMode.value ? Colors.white60 : Colors.grey;

/// Static stat entries for display (hardcoded for now).
const List<_StatEntry> kStaticStats = [
  _StatEntry('Total Sessions', '5'),
  _StatEntry('Total Time', '4h 32m'),
  _StatEntry('Avg Duration', '54m'),
  _StatEntry('Calories Burned (est.)', '~380 kcal'),
];

/// A small data class to hold a stat label/value pair.
class _StatEntry {
  final String label;
  final String value;
  const _StatEntry(this.label, this.value);
}

// ---------------------------------------------------------------------------
// Spacing constants — ensure consistent padding / sizing throughout the page
// ---------------------------------------------------------------------------
const double kSpacingSmall = 8.0;
const double kSpacingMedium = 12.0;
const double kSpacingDefault = 20.0;
const double kSpacingLarge = 30.0;

/// Radius of the circular timer widget.
const double kCircularTimerRadius = 140;

// ---------------------------------------------------------------------------
// Timer state management — encapsulates the active-timer lifecycle
// ---------------------------------------------------------------------------

/// Manages start/stop/dispose of a periodic timer that increments elapsed
/// seconds via [onTick].
class _ActivityTimer {
  bool isActive = false;
  int elapsedSeconds = 0;
  final VoidCallback onTick;
  Timer? _timer;

  _ActivityTimer({required this.onTick});

  /// Start or restart the activity timer.
  void start() {
    stop(); // ensure previous timer is cleaned up
    isActive = true;
    elapsedSeconds = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (_) => onTick());
  }

  /// Stop and reset the timer.
  void stop() {
    _timer?.cancel();
    _timer = null;
    isActive = false;
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    isActive = false;
    elapsedSeconds = 0;
  }
}

/// Page that tracks a solo futsal (futsal-only per PRD) activity session.
class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  // The timer helper instance.
  late final _ActivityTimer _timer;

  @override
  void initState() {
    super.initState();
    _timer = _ActivityTimer(onTick: () => setState(() {}));
  }

  @override
  void dispose() {
    _timer.dispose();
    super.dispose();
  }

  /// Format elapsed seconds into [HH]:[MM]:[SS].
  String _formatDuration(int totalSeconds) {
    final h = (totalSeconds / 3600).floor();
    final m = ((totalSeconds % 3600) / 60).floor();
    final s = totalSeconds % 60;
    return [
      h.toString().padLeft(2, '0'),
      m.toString().padLeft(2, '0'),
      s.toString().padLeft(2, '0'),
    ].join(':');
  }

  void _handleStartActivity() {
    _timer.start();
    setState(() {}); // notify to update the button text immediately
  }

  void _handleEndActivity() {
    final duration = _formatDuration(_timer.elapsedSeconds);
    _timer.stop();
    if (mounted) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Session ended! Duration: $duration'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode.value;

    return Scaffold(
      backgroundColor: isDark ? Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kSpacingDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Section: Title =====
              Text(
                'SOLO ACTIVITY',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: kSpacingSmall),
              Text(
                'Track your futsal activity alone (futsal only per PRD)',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: isDark ? Colors.white60 : Colors.grey,
                ),
              ),

              SizedBox(height: kSpacingLarge),

              // ===== Section: Circular Timer Display =====
              Center(
                child: Container(
                  width: kCircularTimerRadius * 2,
                  height: kCircularTimerRadius * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kAccentColor,
                      width: _timer.isActive ? 4 : 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _formatDuration(_timer.elapsedSeconds),
                      style: GoogleFonts.poppins(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: kAccentColor,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: kSpacingLarge),

              // ===== Section: Start / End Button =====
              Center(
                child: ElevatedButton(
                  onPressed: _timer.isActive
                      ? _handleEndActivity
                      : _handleStartActivity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _timer.isActive
                        ? Colors.red
                        : kAccentColor,
                    padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  ),
                  child: Text(
                    _timer.isActive ? 'End Activity' : 'Start Activity',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: kSpacingLarge),

              // ===== Section: Recent Stats Title =====
              Text(
                'Your Recent Stats',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: kSpacingMedium),

              // ===== Section: Stat Rows =====
              ...kStaticStats.map((e) => _buildStatRow(e.label, e.value)),

              SizedBox(height: kSpacingDefault),

              // ===== Section: Action Buttons (Share / Badges) =====
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Stats shared to your feed!')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: kAccentColor),
                      ),
                      child: Text('Share Stats'),
                    ),
                  ),
                  SizedBox(width: kSpacingMedium),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BadgeGridPage()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kAccentColor,
                    ),
                    child: Icon(Icons.emoji_events),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build a single stat label/value row.
  Widget _buildStatRow(String label, String value) => Padding(
    padding: EdgeInsets.only(bottom: kSpacingMedium),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14)),
        Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
