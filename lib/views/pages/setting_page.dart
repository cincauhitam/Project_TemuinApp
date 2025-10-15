import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/views/widget_tree.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, darkMode, _) {
        return Scaffold(
          backgroundColor: darkMode ? Colors.black : Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WidgetTree()),
                );
              },
            ),
            title: ValueListenableBuilder(
              valueListenable: isDarkMode,
              builder: (context, darkMode, _) {
                return Text(
                  'Settings',
                  style: TextStyle(
                    color: darkMode ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                );
              },
            ),
            backgroundColor: darkMode
                ? Colors.grey[900]
                : const Color.fromARGB(
                    255,
                    255,
                    255,
                    255,
                  ), // theme-based appbar
            iconTheme: IconThemeData(
              color: darkMode
                  ? Colors.white
                  : const Color.fromARGB(255, 0, 0, 0),
            ),
            titleTextStyle: TextStyle(
              color: darkMode
                  ? const Color.fromARGB(255, 0, 0, 0)
                  : const Color.fromARGB(255, 255, 255, 255),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          body: Center(
            child: Text(
              'Settings',
              style: TextStyle(
                color: darkMode ? Colors.white : Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
