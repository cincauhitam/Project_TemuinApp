import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/views/widget_tree.dart';

class SetUpTraits extends StatefulWidget {
  const SetUpTraits({super.key});

  @override
  State<SetUpTraits> createState() => _SetUpTraitsState();
}

class _SetUpTraitsState extends State<SetUpTraits> {
  final List<String> sports = [
    'Football',
    'Basketball',
    'Tennis',
    'Running',
    'Badminton',
  ];
  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> purposes = [
    'Do Sports',
    'Looking for Friend',
    'Looking for Lover',
  ];

  final Set<String> selectedTags = {};

  void toggleTag(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  Widget buildTag(String tag) {
    final bool isSelected = selectedTags.contains(tag);
    return GestureDetector(
      onTap: () => toggleTag(tag),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(1000, 239, 230, 222)
              : const Color.fromARGB(0, 135, 134, 134),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color.fromRGBO(1000, 239, 230, 222)
                : Colors.grey.shade400,
            width: 1.2,
          ),
        ),
        child: Text(
          tag,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildCategory(String title, List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(children: tags.map(buildTag).toList()),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Pick your poison",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 35),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCategory('Sport', sports),
                    buildCategory('Gender', genders),
                    buildCategory('What are you here for?', purposes),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle done action
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const WidgetTree()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(1000, 239, 230, 222),
                    padding: const EdgeInsets.symmetric(vertical: 14,),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: isDarkMode,
                    builder: (context, isDarkMode, _) {
                      return Text(
                        "DONE",
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode
                              ? Color.fromARGB(255, 7, 7, 7)
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
