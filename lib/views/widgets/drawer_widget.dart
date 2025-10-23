import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/views/pages/login_page.dart';
import 'package:project_flutter/views/pages/setting_page.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        return ValueListenableBuilder(
          valueListenable: selectedPageNotifier,
          builder: (BuildContext context, dynamic value, Widget? child) {
            return Drawer(
              backgroundColor:
                  dark ? const Color(0xFF121212) : Colors.white, // main bg
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: dark
                          ? const Color(0xFF1E1E1E)
                          : const Color.fromARGB(255, 245, 245, 245),
                    ),
                    child: Center(
                      child: Text(
                        'Temuin_App',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: dark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home,
                        color: dark ? Colors.white : Colors.black),
                    title: Text('Home',
                        style: TextStyle(
                            color: dark ? Colors.white : Colors.black)),
                    onTap: () {
                      Navigator.pop(context);
                      selectedPageNotifier.value = 3;
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.event,
                        color: dark ? Colors.white : Colors.black),
                    title: Text('Event',
                        style: TextStyle(
                            color: dark ? Colors.white : Colors.black)),
                    onTap: () {
                      // Add navigation logic later if needed
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.groups_sharp,
                        color: dark ? Colors.white : Colors.black),
                    title: Text('Community',
                        style: TextStyle(
                            color: dark ? Colors.white : Colors.black)),
                    onTap: () {
                      Navigator.pop(context);
                      selectedPageNotifier.value = 1;
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person,
                        color: dark ? Colors.white : Colors.black),
                    title: Text('Profile',
                        style: TextStyle(
                            color: dark ? Colors.white : Colors.black)),
                    onTap: () {
                      Navigator.pop(context);
                      selectedPageNotifier.value = 0;
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings,
                        color: dark ? Colors.white : Colors.black),
                    title: Text('Settings',
                        style: TextStyle(
                            color: dark ? Colors.white : Colors.black)),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      dark ? Icons.dark_mode : Icons.light_mode,
                      color: dark ? Colors.white : Colors.black,
                    ),
                    title: Text(
                      dark ? 'Dark Mode' : 'Light Mode',
                      style: TextStyle(
                        color: dark ? Colors.white : Colors.black,
                      ),
                    ),
                    onTap: () {
                      isDarkMode.value = !isDarkMode.value;
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout,
                        color: dark ? Colors.white : Colors.black),
                    title: Text('Logout',
                        style: TextStyle(
                            color: dark ? Colors.white : Colors.black)),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
