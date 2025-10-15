import 'package:flutter/material.dart';

class Study extends StatefulWidget {
  const Study({super.key});

  @override
  State<Study> createState() => _StudyState();
}

class _StudyState extends State<Study> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("memew")),),
      body: Center(child: Column(
        children: [Text("study in")],
      ),),
    );
  }
}
