import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/views/pages/create_post_page.dart';
import 'package:project_flutter/views/pages/login_page_new.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  static const _accentColor = Color(0xFF9A0002);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        return Drawer(
          backgroundColor: dark ? const Color(0xFF121212) : Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(),
              _buildMenuItem(
                dark: dark,
                icon: Icons.home,
                label: 'Home',
                onTap: () => _navigateToPage(context, 3),
              ),
              _buildMenuItem(
                dark: dark,
                icon: Icons.event,
                label: 'Events',
                subtitle: 'Activity Nearby',
                onTap: () => _navigateToPage(context, 3),
              ),
              _buildMenuItem(
                dark: dark,
                icon: Icons.groups_sharp,
                label: 'Community',
                onTap: () => _navigateToPage(context, 1),
              ),
              _buildMenuItem(
                dark: dark,
                icon: Icons.person,
                label: 'Profile',
                onTap: () => _navigateToPage(context, 0),
              ),
              _buildMenuItem(
                dark: dark,
                icon: Icons.fitness_center,
                label: 'Activity',
                onTap: () => _navigateToPage(context, 2),
              ),
              _buildMenuItem(
                dark: dark,
                icon: Icons.add_circle_outline,
                iconColor: _accentColor,
                label: 'Create Post',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ThreadsWithCreate()),
                  );
                },
              ),
              Divider(color: dark ? Colors.white12 : Colors.grey.shade300),
              _buildMenuItem(
                dark: dark,
                icon: dark ? Icons.dark_mode : Icons.light_mode,
                label: dark ? 'Dark Mode' : 'Light Mode',
                subtitle: dark ? 'Enabled' : 'Disabled',
                onTap: () => isDarkMode.value = !isDarkMode.value,
              ),
              _buildMenuItem(
                dark: dark,
                icon: Icons.logout,
                iconColor: Colors.red,
                textColor: Colors.red,
                label: 'Logout',
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(color: _accentColor),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sports_soccer,
              size: 50,
              color: Colors.white.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 8),
            const Text(
              'FUTSALIN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required bool dark,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    String? subtitle,
    Color? iconColor,
    Color? textColor,
  }) {
    final defaultColor = dark ? Colors.white70 : Colors.black54;
    return ListTile(
      leading: Icon(icon, color: iconColor ?? defaultColor),
      title: Text(label, style: TextStyle(color: textColor ?? defaultColor)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      onTap: onTap,
    );
  }

  void _navigateToPage(BuildContext context, int index) {
    Navigator.pop(context);
    selectedPageNotifier.value = index;
  }
}

class ThreadsWithCreate extends StatelessWidget {
  const ThreadsWithCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreatePostPage();
  }
}