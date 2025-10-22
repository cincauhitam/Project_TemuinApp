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
      valueListenable: selectedPageNotifier,
      builder: (BuildContext context, dynamic value, Widget? child) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.white30),
                child: Center(
                  child: Text('Temuin_App', style: TextStyle(fontSize: 30)),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  // 👇 When tapped, navigate back to LoginPage
                  Navigator.pop(context);
                  selectedPageNotifier.value = 3;
                },
                // onTap: () {
                //   // 👇 When tapped, navigate back to LoginPage
                //   Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage(),));
                // },
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text('Event'),
                onTap: () {
                  // 👇 When tapped, navigate back to LoginPage
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage(),));
                },
              ),
              ListTile(
                leading: const Icon(Icons.groups_sharp),
                title: const Text('Community'),
                onTap: () {
                  // 👇 When tapped, navigate back to LoginPage
                  Navigator.pop(context);
                  selectedPageNotifier.value = 1;
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  // 👇 When tapped, navigate back to LoginPage
                  Navigator.pop(context);
                  selectedPageNotifier.value = 0;
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  // 👇 When tapped, navigate back to LoginPage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SettingPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon( isDarkMode.value ?  Icons.dark_mode : Icons.light_mode),
                title: const Text('Light Mode'),
                onTap: () {
                  isDarkMode.value = !isDarkMode.value;
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  // 👇 When tapped, navigate back to LoginPage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
