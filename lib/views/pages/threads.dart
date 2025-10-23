import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';

class ThreadsPage extends StatefulWidget {
  const ThreadsPage({super.key});

  @override
  State<ThreadsPage> createState() => _ThreadsPageState();
}

class _ThreadsPageState extends State<ThreadsPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        return Scaffold(
          backgroundColor: dark
              ? const Color.fromARGB(255, 18, 18, 18)
              : Colors.white,
          body: Column(children: [Center()]),
        );
      }
    );
  }
}
