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
      child: ValueListenableBuilder(
        valueListenable: isDarkMode,
        builder: (context, dark, _) {
          final borderColor = dark ? Colors.white : Colors.black;
          final textColor = dark ? const Color(0xFFEFE6DE) : Colors.black;
          final selectedBg = dark
              ? const Color(0xFF9A0002)
              : const Color(0xFF9A0002).withOpacity(0.1);

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? selectedBg : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: borderColor, width: 1.2),
            ),
            child: Text(
              tag,
              style: TextStyle(
                color: isSelected
                    ? (dark ? const Color(0xFFEFE6DE) : const Color(0xFF9A0002))
                    : textColor,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCategory(String title, List<String> tags) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        final titleColor = dark ? const Color(0xFFEFE6DE) : Colors.black;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(children: tags.map(buildTag).toList()),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        final bgColor = dark ? const Color(0xFF001010) : Colors.white;
        final textColor = dark ? const Color(0xFFEFE6DE) : Colors.black;
        final buttonColor =
            dark ? const Color(0xFFEFE6DE) : const Color(0xFF9A0002);
        final buttonTextColor =
            dark ? const Color(0xFF9A0002) : const Color(0xFFEFE6DE);

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            iconTheme: IconThemeData(color: textColor),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Pick your poison",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WidgetTree(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Save Traits",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: buttonTextColor,
                        ),
                      ),
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
