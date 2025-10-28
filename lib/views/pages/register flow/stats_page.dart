import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/views/pages/register%20flow/set_up_profile_new.dart';
import 'package:project_flutter/views/pages/register%20flow/set_up_traits.dart';
import 'package:project_flutter/views/widget_tree.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  // Stats variables
  int pace = 50;
  int shooting = 50;
  int passing = 50;
  int dribbling = 50;
  int defending = 50;
  int physical = 50;

  List<int> statsRange = List.generate(101, (index) => index);

  void _showStatPicker(String statName, int currentValue, Function(int) onStatChanged) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ValueListenableBuilder<bool>(
          valueListenable: isDarkMode,
          builder: (context, darkMode, child) {
            final bgColor = darkMode 
                ? const Color.fromARGB(1000, 239, 230, 222)
                : const Color.fromARGB(1000, 154, 0, 2);
            final textColor = darkMode 
                ? const Color.fromARGB(1000, 154, 0, 2)
                : const Color.fromARGB(1000, 239, 230, 222);

            return Container(
              height: 300,
              padding: const EdgeInsets.all(20),
              color: bgColor,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Select $statName",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _buildStatPickerColumn(
                      title: statName.toUpperCase(),
                      items: statsRange,
                      selected: currentValue,
                      onChange: onStatChanged,
                      darkMode: darkMode,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkMode 
                          ? const Color.fromARGB(1000, 154, 0, 2)
                          : const Color.fromARGB(1000, 239, 230, 222),
                    ),
                    child: Text(
                      "CONFIRM",
                      style: TextStyle(
                        color: darkMode
                            ? const Color.fromARGB(1000, 239, 230, 222)
                            : const Color.fromARGB(1000, 154, 0, 2),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatPickerColumn({
    required String title,
    required List<int> items,
    required int selected,
    required Function(int) onChange,
    required bool darkMode,
  }) {
    final highlightColor = darkMode 
        ? const Color.fromARGB(1000, 154, 0, 2)
        : const Color.fromARGB(1000, 239, 230, 222);

    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: highlightColor,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                ListWheelScrollView(
                  itemExtent: 40,
                  perspective: 0.005,
                  diameterRatio: 1.5,
                  onSelectedItemChanged: (index) => onChange(items[index]),
                  children: items.map((item) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        item.toString().padLeft(2, '0'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: selected == item
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: highlightColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                IgnorePointer(
                  child: Center(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: highlightColor, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, int value, bool darkMode, Function() onTap) {
    final borderColor = darkMode 
        ? const Color.fromARGB(1000, 239, 230, 222)
        : const Color.fromARGB(1000, 154, 0, 2);
    final textColor = darkMode 
        ? const Color.fromARGB(1000, 239, 230, 222)
        : const Color.fromARGB(1000, 154, 0, 2);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: textColor.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode ,
      builder: (context, dark, _) {
        return Scaffold(
          backgroundColor: dark ? const Color(0xFF121212) : Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: isDarkMode,
                  builder: (context, darkMode, child) {
                    return Text(
                      'Player Stats',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: darkMode
                            ? const Color.fromARGB(1000, 239, 230, 222)
                            : const Color.fromARGB(1000, 154, 0, 2),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                
                // Attacking and Defensive Stats side by side
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Attacking Stats Column
                    Expanded(
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isDarkMode,
                        builder: (context, darkMode, child) {
                          return Column(
                            children: [
                              Text(
                                "Attacking Stats",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: darkMode
                                      ? const Color.fromARGB(1000, 239, 230, 222)
                                      : const Color.fromARGB(1000, 154, 0, 2),
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildStatBox("PACE", pace, darkMode, () {
                                _showStatPicker("Pace", pace, (newValue) {
                                  setState(() => pace = newValue);
                                });
                              }),
                              const SizedBox(height: 16),
                              _buildStatBox("SHOOTING", shooting, darkMode, () {
                                _showStatPicker("Shooting", shooting, (newValue) {
                                  setState(() => shooting = newValue);
                                });
                              }),
                              const SizedBox(height: 16),
                              _buildStatBox("PASSING", passing, darkMode, () {
                                _showStatPicker("Passing", passing, (newValue) {
                                  setState(() => passing = newValue);
                                });
                              }),
                            ],
                          );
                        },
                      ),
                    ),
        
                    const SizedBox(width: 20),
        
                    // Defensive Stats Column
                    Expanded(
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isDarkMode,
                        builder: (context, darkMode, child) {
                          return Column(
                            children: [
                              Text(
                                "Defensive Stats",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: darkMode
                                      ? const Color.fromARGB(1000, 239, 230, 222)
                                      : const Color.fromARGB(1000, 154, 0, 2),
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildStatBox("DRIBBLING", dribbling, darkMode, () {
                                _showStatPicker("Dribbling", dribbling, (newValue) {
                                  setState(() => dribbling = newValue);
                                });
                              }),
                              const SizedBox(height: 16),
                              _buildStatBox("DEFENDING", defending, darkMode, () {
                                _showStatPicker("Defending", defending, (newValue) {
                                  setState(() => defending = newValue);
                                });
                              }),
                              const SizedBox(height: 16),
                              _buildStatBox("PHYSICAL", physical, darkMode, () {
                                _showStatPicker("Physical", physical, (newValue) {
                                  setState(() => physical = newValue);
                                });
                              }),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
        
                const Spacer(),
        
                SizedBox(
                  width: double.infinity,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isDarkMode,
                    builder: (context, darkMode, child) {
                      return ElevatedButton(
                        onPressed: () {
                          // Save profile logic Here
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SetUpTraits(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkMode
                              ? const Color.fromARGB(1000, 239, 230, 222)
                              : const Color.fromARGB(1000, 154, 0, 2),
                          foregroundColor: darkMode
                              ? const Color.fromARGB(1000, 154, 0, 2)
                              : const Color.fromARGB(1000, 239, 230, 222),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Save Profile',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}