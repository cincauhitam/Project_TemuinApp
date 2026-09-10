import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/views/pages/activity_page.dart';
import 'package:project_flutter/views/pages/community_page.dart';
import 'package:project_flutter/views/pages/home_page.dart';
import 'package:project_flutter/views/pages/profile_page.dart';
import 'package:project_flutter/views/pages/threads.dart';
import 'package:project_flutter/views/widgets/main_scaffold.dart';

List<String> titles = ["Profile", "Community", "Activity", "Home", "Threads"];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});
  @override State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override Widget build(BuildContext context) {
    return MainScaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          switch (selectedPage) {
            case 0: return const ProfilePage();
            case 1: return const CommunityPage();
            case 2: return const ActivityPage();
            case 3: return const HomePage();
            case 4: return const ThreadsPage();
            default: return const HomePage();
          }
        },
      ),
    );
  }
}
