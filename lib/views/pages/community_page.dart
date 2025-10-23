import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        return Scaffold(
          backgroundColor: dark
              ? const Color.fromARGB(255, 18, 18, 18)
              : Colors.white,
          body: Center(
            child: Text(
              'Community Page',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
