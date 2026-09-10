import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/app_dummy_data_service.dart';
import 'package:project_flutter/models/app_models.dart';
import 'package:project_flutter/views/pages/create_post_page.dart';
import 'package:project_flutter/views/pages/feed_page.dart';

class ThreadsPage extends StatefulWidget {
  const ThreadsPage({super.key});

  @override
  State<ThreadsPage> createState() => _ThreadsPageState();
}

class _ThreadsPageState extends State<ThreadsPage> {
  late List<PostModel> _posts;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      _posts = AppDummyDataService.getPosts();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = const Color(0xFF9A0002);
    final textPrimary = isDarkMode.value ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor:
          isDarkMode.value ? const Color(0xFF121212) : Colors.white,
      body: Column(
        children: [
          // Header with FAB
          Container(
            padding: const EdgeInsets.fromLTRB(16, 56, 16, 12),
            decoration: BoxDecoration(
              color: accentColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Threads",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CreatePostPage(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Quick create box
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode.value
                    ? const Color(0xFF1E1E1E)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: accentColor,
                    child: Text(
                      'A',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CreatePostPage(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode.value
                              ? Colors.grey.shade900
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "What's on your mind?",
                          style: GoogleFonts.poppins(
                            color: dark ? Colors.white : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Posts list
          Expanded(
            child: _isLoading
                ?  Center(
                    child: CircularProgressIndicator(
                      color: accentColor,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _posts.length,
                    itemBuilder: (ctx, i) =>
                        _PostCard(post: _posts[i]),
                  ),
          ),
        ],
      ),
    );
  }

  bool get dark => isDarkMode.value;
}

class _PostCard extends StatelessWidget {
  final PostModel post;

  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    final accentColor = const Color(0xFF9A0002);
    final dark = isDarkMode.value;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FeedPage(),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: dark
              ? const Color(0xFF1E1E1E)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: accentColor,
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
                        ),
                      ),
                      Text(
                        "${_typeLabel(post.postType)} \u2022 ${_timeAgo(post.createdAt)}",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: dark
                              ? Colors.white
                              : Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (post.caption != null) ...[
              const SizedBox(height: 10),
              Text(
                post.caption!,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 18,
                  color: dark
                      ? Colors.white54
                      : Colors.black38,
                ),
                const SizedBox(width: 6),
                Text(
                  '${post.likesCount}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.comment,
                  size: 18,
                  color: dark
                      ? Colors.white54
                      : Colors.black38,
                ),
                const SizedBox(width: 6),
                Text(
                  '${post.commentsCount}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _typeLabel(String type) {
    return type == 'group'
        ? 'Group Post'
        : (type == 'community'
            ? 'Community'
            : 'User Post');
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    }

    if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    }

    return '${diff.inDays}d ago';
  }
}