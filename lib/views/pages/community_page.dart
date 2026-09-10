import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/app_dummy_data_service.dart';
import 'match_page.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        final accentColor = const Color(0xFF9A0002);

        return Scaffold(
          backgroundColor: dark ? const Color(0xFF121212) : Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PROFILE MATCHER',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Find teammates who complement your play style',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: dark ? Colors.white60 : Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                ...AppDummyDataService.getMatchCandidates(AppDummyDataService.currentUser.id).map(
                  (c) => _matchCard(c, dark, accentColor),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'GROUPS',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline, color: accentColor),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const GroupCreatePage()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...AppDummyDataService.getGroups().map((g) => _groupCard(g, dark, accentColor)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _matchCard(dynamic c, bool dark, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: accent,
            child: Text(
              c.user.username[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.user.fullName,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                Text(
                  '@${c.user.username}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: dark ? Colors.white60 : Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    _chip(
                      Icons.fitness_center,
                      c.user.role is Map
                          ? (c.user.role as dynamic)['primary_role']?.toString() ?? ''
                          : '',
                      accent,
                    ),
                    const SizedBox(width: 6),
                    _chip(Icons.emoji_events, c.user.level, accent),
                    if (c.compatibilityScore > 0.5) ...[
                      const SizedBox(width: 6),
                      _chip(
                        Icons.star, // Added missing icon parameter
                        '${(c.compatibilityScore * 100).toStringAsFixed(0)}% match',
                        Colors.green,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(IconData icon, String label, Color clr) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: clr.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: clr),
          const SizedBox(width: 4),
          Text(label, style: GoogleFonts.poppins(fontSize: 11, color: clr)),
        ],
      ),
    );
  }

  Widget _groupCard(dynamic g, bool dark, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: accent,
                child: Icon(Icons.group_work, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      g.name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${g.members.length} members', // Fixed string interpolation
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: dark ? Colors.white60 : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            g.description,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: dark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(backgroundColor: accent),
            child: const Text('Joined'),
          ),
        ],
      ),
    );
  }
}

class GroupCreatePage extends StatefulWidget {
  const GroupCreatePage({super.key});

  @override
  State<GroupCreatePage> createState() => _GroupCreateState();
}

class _GroupCreateState extends State<GroupCreatePage> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  bool _controlByAdmin = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Group',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF9A0002),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descCtrl,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              value: _controlByAdmin,
              onChanged: (v) => setState(() => _controlByAdmin = v),
              title: Text('Admin controls post visibility'),
              secondary: Icon(Icons.admin_panel_settings),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Group created!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9A0002),
              ),
              child: Text('Create Group'),
            ),
          ],
        ),
      ),
    );
  }
}