import 'package:flutter/material.dart';
import 'package:project_flutter/views/widgets/appbar_widget.dart';
import 'package:project_flutter/views/widgets/main_scaffold.dart';

class ThreadsPage extends StatefulWidget {
  const ThreadsPage({super.key});

  @override
  State<ThreadsPage> createState() => _ThreadsPageState();
}

class _ThreadsPageState extends State<ThreadsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Center(child: Text('This is the Threads Page'),),],);
  }
}