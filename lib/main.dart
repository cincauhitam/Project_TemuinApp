import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/views/pages/login_page_new.dart';
import 'package:project_flutter/views/widget_tree.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Supabase.initialize(
      url: 'https://ynrlazotnpftjyziovky.supabase.co',
      anonKey: 'sb_publishable_m4emukdfkUxoFHBhi36yPg__1DYqmWb',
    );
    print('Supabase initialized');
  } catch (e) {
    print('Error initializing Supabase: ');
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: isDarkMode,
        builder: (context, dark, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEFE6DE), brightness: dark ? Brightness.light : Brightness.dark),
            useMaterial3: true,
          ),
          home: const AuthRoute(),
        ),
      ),
    );
  }
}

class AuthRoute extends StatelessWidget {
  const AuthRoute({super.key});
  @override Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    return session != null ? const WidgetTree() : const Login();
  }
}
