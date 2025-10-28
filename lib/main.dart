
import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/views/pages/login_page.dart';
import 'package:project_flutter/views/pages/profile_page.dart';
import 'package:project_flutter/views/pages/register%20flow/set_up_profile_new.dart';
import 'package:project_flutter/views/pages/register%20flow/set_up_traits.dart';
import 'package:project_flutter/views/pages/register%20flow/stats_page.dart';
import 'package:project_flutter/views/pages/register_page.dart';
import 'package:project_flutter/views/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: isDarkMode,
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 0, 213, 255),
                brightness: value ? Brightness.light : Brightness.dark,
              ),
            ),
            home: RegisterPage(),
          );
        },
      ),
    );
  }
}
