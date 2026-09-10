import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/app_dummy_data_service.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});
  @override
  State<CreatePostPage> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePostPage> {
  final _captionCtrl = TextEditingController();
  String _postType = 'user';
  List<String> _selectedGroups = [];
  bool _hasMedia = false;

  @override
  void dispose() {
    _captionCtrl.dispose();
    super.dispose();
  }

  void _publishPost() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Post published!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _destChip(String label, bool sel) {
    final accentColor = Color(0xFF9A0002);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: sel
            ? accentColor.withValues(alpha: 0.15)
            : (isDarkMode.value ? Color(0xFF1E1E1E) : Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: sel
              ? accentColor
              : isDarkMode.value
              ? Colors.white12
              : Colors.grey.shade300,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontWeight: sel ? FontWeight.bold : FontWeight.normal,
          color: sel
              ? accentColor
              : isDarkMode.value
              ? Colors.white70
              : Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Color(0xFF9A0002);
    final dark = isDarkMode.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark ? Colors.black : Colors.white,
        foregroundColor: dark ? Colors.white : Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: dark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _publishPost,
            child: Text(
              'Publish',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Post',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Destination:',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _destChip('Public', _postType == 'user'),
                _destChip('Community', _postType == 'community'),
                ...AppDummyDataService.getGroups().map(
                  (g) => _destChip(g.name, _selectedGroups.contains(g.id)),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Post Type:',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'user', label: Text('User')),
                ButtonSegment(value: 'group', label: Text('Group')),
                ButtonSegment(value: 'community', label: Text('Community')),
              ],
              selected: {_postType},
              onSelectionChanged: (s) => setState(() => _postType = s.first),
            ),
            SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _captionCtrl,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'What is on your mind?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.poppins(fontSize: 15),
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _hasMedia = !_hasMedia),
                  child: Text(_hasMedia ? 'Remove Photo' : 'Add Photo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasMedia
                        ? accentColor
                        : (dark ? Color(0xFF1E1E1E) : Colors.grey.shade200),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => GroupSelectPage()),
                  ),
                  child: Text('Tag Groups'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dark
                        ? Color(0xFF1E1E1E)
                        : Colors.grey.shade200,
                  ),
                ),
              ],
            ),
            if (_hasMedia) ...[
              SizedBox(height: 12),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(Icons.image, size: 40, color: accentColor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class GroupSelectPage extends StatefulWidget {
  const GroupSelectPage({super.key});
  @override
  State<GroupSelectPage> createState() => _GroupSelectState();
}

class _GroupSelectState extends State<GroupSelectPage> {
  Set<String> selected = {};

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Select Groups'),
      backgroundColor: Color(0xFF9A0002),
      foregroundColor: Colors.white,
    ),
    body: Column(
  children: [
    ...AppDummyDataService.getGroups().map(
      (g) => Expanded(
        child: CheckboxListTile(
          value: selected.contains(g.id),
          onChanged: (v) => setState(() {
            if (v!) {
              selected.add(g.id);
            } else {
              selected.remove(g.id);
            }
          }),
          title: Text(
            g.name,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          subtitle: Text('${g.members.length} members'),
          checkColor: Color(0xFF9A0002),
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          setState(() {});
        },
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF9A0002)),
        child: Text('Done'),
      ),
    ),
  ],
),
  );
}