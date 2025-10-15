import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                fit: BoxFit.cover, // Fills the circle, may crop
              ),
            ),
          ),
          Center(
            heightFactor: 3,
            child: Text(
              "USER_PATOWUMBOO",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
