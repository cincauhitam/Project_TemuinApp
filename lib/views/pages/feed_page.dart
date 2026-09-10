import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/app_dummy_data_service.dart';
import 'package:project_flutter/models/app_models.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        final accentColor = const Color(0xFF9A0002);

        return Scaffold(
          backgroundColor: dark ? const Color(0xFF121212) : Colors.white,
          appBar: AppBar(
            title: Text(
              'Feed',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: dark ? const Color(0xFF121212) : Colors.white,
            foregroundColor: dark ? Colors.white : Colors.black,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Create post box
                _createPostBox(accentColor, dark),
                const SizedBox(height: 24),

                // Feed posts
                ...AppDummyDataService.getPosts().map((post) => _buildPostCard(post, accentColor, dark)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _createPostBox(Color accent, bool dark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: accent,
            child: Text(
              'F',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                hintStyle: GoogleFonts.poppins(
                  color: dark ? Colors.white60 : Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(PostModel post, Color accent, bool dark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: accent,
                  child: Text(
                    post.username[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.username,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${post.postType.toUpperCase()} • ${_formatTimeAgo(post.createdAt)}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: dark ? Colors.white60 : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz, color: dark ? Colors.white70 : Colors.black54),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Caption
          if (post.caption != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                post.caption!,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: dark ? Colors.white : Colors.black87,
                ),
              ),
            ),

          // Media image placeholder
          if (post.mediaUrls.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 200,
                  color: dark ? Colors.grey.shade800 : Colors.grey.shade300,
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 48,
                      color: dark ? Colors.white54 : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

          // Actions bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _actionButton(Icons.favorite_border, post.likesCount),
                const SizedBox(width: 24),
                _actionButton(Icons.comment_outlined, post.commentsCount),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, int count) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 6),
          Text(
            count.toString(),
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return '${time.day}/${time.month}/${time.year}';
  }
}