import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/views/pages/activity_page.dart';
import 'package:project_flutter/views/pages/community_page.dart';
import 'package:project_flutter/views/pages/home_page.dart';
import 'package:project_flutter/views/pages/profile_page.dart';
import 'package:project_flutter/views/pages/messages_page.dart';
import 'package:project_flutter/views/pages/threads.dart';
import 'package:project_flutter/views/widgets/main_scaffold.dart';

List<String> titles = ["Profile", "Community", "Activity", "Home", "Threads","Settings"];

List<Widget> pages = [
  ProfilePage(),
  CommunityPage(),
  ActivityPage(),
  HomePage(),
  ThreadsPage(),
];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (BuildContext context, int selectedPage, Widget? child) {
          return pages.elementAt(selectedPage);
        },
      ),
    );
  }
}
