import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: dark
                ? const Color.fromARGB(1000, 239, 230, 222)
                : const Color.fromARGB(1000, 154, 0, 2),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop(); // Go back to previous page
              },
            ),
            title: const Text('Notifications'),
          ),
          backgroundColor: dark
              ? const Color.fromARGB(255, 18, 18, 18)
              : Colors.white,
          body: const Center(child: Text('This is the Messages Page')),
        );
      }
    );
  }
}
