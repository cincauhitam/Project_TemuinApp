import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/views/pages/messages_page.dart';
import 'package:project_flutter/views/pages/notifications.dart';
import 'package:project_flutter/data/notifiers.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        return AppBar(
          backgroundColor: dark ? Color(0xFF121212) : Colors.white,
          foregroundColor: dark ? Colors.white : Colors.black,
          elevation: 0,
          actions: [
            IconButton(icon: Icon(Icons.notification_important), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Notifications()))),
            IconButton(icon: Icon(Icons.message), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MessagesPage()))),
          ],
          title: ValueListenableBuilder<int>(
            valueListenable: selectedPageNotifier,
            builder: (context, sel, _) => Center(child: Padding(padding: EdgeInsets.only(left: 52), child: Text(titles[sel], style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: dark ? Colors.white : Colors.black)))))),
        );
      },
    );
  }

  @override Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

List<String> titles = ['Profile', 'Community', 'Activity', 'Home', 'Threads'];
