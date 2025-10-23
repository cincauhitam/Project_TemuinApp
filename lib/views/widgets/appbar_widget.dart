import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/views/pages/messages_page.dart';
import 'package:project_flutter/views/pages/notifications.dart';
import 'package:project_flutter/views/widget_tree.dart';
import '../../data/notifiers.dart'; // adjust path if needed

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        return AppBar(
          backgroundColor:
              dark ? const Color(0xFF121212) : Colors.white, // main bg
          foregroundColor: dark ? Colors.white : Colors.black, // icons & text
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.notification_important,
                color: dark ? Colors.white : Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Notifications(),
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MessagesPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.message,
                color: dark ? Colors.white : Colors.black,
              ),
            ),
          ],
          title: ValueListenableBuilder(
            valueListenable: selectedPageNotifier,
            builder:
                (BuildContext context, int selectedPage, Widget? child) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 52),
                  child: Text(
                    titles.elementAt(selectedPage),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: dark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
