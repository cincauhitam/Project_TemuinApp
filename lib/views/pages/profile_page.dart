import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        return Scaffold(
          backgroundColor:
              dark ? const Color.fromARGB(255, 18, 18, 18) : Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/glorp.jpg',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  heightFactor: 3,
                  child: Text(
                    "USER_PATOWUMBOO",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: dark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
