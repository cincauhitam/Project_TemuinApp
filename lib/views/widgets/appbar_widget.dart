import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/views/widget_tree.dart';
import '../../data/notifiers.dart'; // adjust path if needed

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: ValueListenableBuilder(
            valueListenable: isDarkMode,
            builder: (context, darkMode, _) {
              return Icon(darkMode ? Icons.dark_mode : Icons.light_mode);
            },
          ),
          onPressed: () {
            isDarkMode.value = !isDarkMode.value;
          },
        ),
      ],
      title: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (BuildContext context, int selectedPage, Widget? child) {
          return Center(
            child: Text(
              titles.elementAt(selectedPage),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Needed when using a custom AppBar widget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
