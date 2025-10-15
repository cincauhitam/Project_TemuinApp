import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ===== Top “EVENT NEARBY” title =====
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ValueListenableBuilder(
              valueListenable: isDarkMode,
              builder: (context, isDarkMode, _) {
                return Text(
                  "EVENT NEARBY",
                  style: TextStyle(
                    color: isDarkMode
                        ? const Color.fromARGB(
                            1000,
                            239,
                            230,
                            222,
                          ) // light text on dark bg
                        : const Color.fromARGB(
                            1000,
                            154,
                            0,
                            2,
                          ), // dark red text on light bg
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                );
              },
            ),
          ),

          // ===== Three icons row =====
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/glorp.jpg',
                        width: 90,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text("24km"),
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/test_icon.png',
                        width: 90,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text("24km"),
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/glorp.jpg',
                        width: 90,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text("24km"),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ===== Posts =====
          for (int i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile section
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: const AssetImage(
                          'assets/images/glorp.jpg',
                        ),
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Sahroni The Black Mamba",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "dolor lorem ipsum anjay mabar dolor lorem dolor ipsum anjay mabar",
                  ),
                  const SizedBox(height: 10),

                  // Post image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/test_icon.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Action row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.favorite, color: Colors.red),
                          SizedBox(width: 5),
                          Text("69k"),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.mode_comment_outlined),
                          SizedBox(width: 5),
                          Text("6,9k"),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.share),
                          SizedBox(width: 5),
                          Text("6,9k"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
