import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  static const _accentColor = Color(0xFF9A0002);

  final List<String> _items = [
    "You matched with golf_master_id!",
    "New event 'Weekend Futsal Liga A' is upcoming",
    "Someone liked your post",
    "futsal_demo commented on your post",
    "Welcome to Futsalin! Complete your profile to get started.",
  ];

  bool get _isDark => isDarkMode.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: _accentColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        itemBuilder: (context, index) => _buildNotificationTile(_items[index]),
      ),
    );
  }

  Widget _buildNotificationTile(String message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications_outlined, color: _accentColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: _isDark ? Colors.white70 : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}