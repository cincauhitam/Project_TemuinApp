import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';

class MatchPage extends StatefulWidget {
  final dynamic candidate;

  const MatchPage({super.key, required this.candidate});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  static const _accentColor = Color(0xFF9A0002);

  bool _matched = false;
  bool _isMatching = false;

  Future<void> _doMatch() async {
    setState(() => _isMatching = true);

    await Future.delayed(const Duration(seconds: 1));
    setState(() => _matched = true);

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Matched with ${_username(context)}!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  String _username(BuildContext context) {
    return widget.candidate.user.username as String;
  }

  bool get _isDark => isDarkMode.value;

  @override
  Widget build(BuildContext context) {
    final user = widget.candidate.user;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const Spacer(),
            Expanded(
              child: Center(
                child: _matched ? _buildMatchedContent(user) : _buildVersusContent(user),
              ),
            ),
            const Spacer(),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: _isDark ? Colors.white : Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Match?',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchedContent(dynamic user) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.favorite_rounded, size: 120, color: _accentColor),
        const SizedBox(height: 16),
        Text(
          "IT'S A MATCH!",
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: _accentColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'You and ${user.username} want to play together',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildVersusContent(dynamic user) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: _accentColor,
              child: Text(
                (user.username as String)[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _accentColor.withValues(alpha: 0.3),
                  width: 3,
                ),
              ),
              child: const Icon(Icons.sports_soccer, size: 50, color: _accentColor),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'vs',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: _isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 24),
        CircleAvatar(
          radius: 80,
          backgroundColor: _accentColor.withValues(alpha: 0.5),
          child: Icon(
            Icons.person,
            size: 50,
            color: _isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          if (!_matched) ...[
            SizedBox(
              width: double.infinity,
              height: _isMatching ? null : 48,
              child: _isMatching
                  ? const CircularProgressIndicator(color: _accentColor)
                  : ElevatedButton(
                      onPressed: _doMatch,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accentColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'YES, MATCH!',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 12),
          ],
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _isDark ? Colors.grey[900] : Colors.grey.shade200,
              foregroundColor: _isDark ? Colors.white : Colors.black,
            ),
            child: const Text('Not interested'),
          ),
        ],
      ),
    );
  }
}

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  static const _accentColor = Color(0xFF9A0002);

  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isDark => isDarkMode.value;

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // TODO: append the message to the chat's message list and persist it.
    setState(() => _controller.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat with golf_master_id',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: _accentColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(context)),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    const messages = [
      'Hey! Want to join our session Friday?',
      'Sure! What time?',
      'Hey! Want to join our session Friday?',
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final isMe = index % 2 == 1;

        return Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isMe
                  ? _accentColor
                  : (_isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              messages[index],
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isMe
                    ? Colors.white
                    : (_isDark ? Colors.white70 : Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputBar() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: _isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: _sendMessage,
            style: ElevatedButton.styleFrom(
              backgroundColor: _accentColor,
              padding: const EdgeInsets.all(14),
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}