import 'package:flutter/material.dart';
import 'package:project_flutter/views/pages/register%20flow/stats_page.dart';

class SetUpProfileNew extends StatefulWidget {
  const SetUpProfileNew({super.key});

  @override
  State<SetUpProfileNew> createState() => _SetUpProfileNewState();
}

class _SetUpProfileNewState extends State<SetUpProfileNew> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

  String? _selectedRole;
  String? _selectedLevel;

  final List<String> _roles = ['pivot', 'Flank', 'anchor', 'goalkeeper'];
  final List<String> _levels = [
    'beginner',
    'amateur',
    'semi pro',
  ];

  // Birth date variables
  int selectedDay = 1;
  int selectedMonth = 1;
  int selectedYear = DateTime.now().year;
  List<int> days = List.generate(31, (index) => index + 1);
  List<int> months = List.generate(12, (index) => index + 1);
  List<int> years = List.generate(100, (index) => DateTime.now().year - index);

  // Height variables
  int selectedHeight = 170;
  List<int> heights = List.generate(201, (index) => index);

  void _showDatePicker() {
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
                    "Select Your Birth Date",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      children: [
                        _buildPickerColumn(
                          title: "DAY",
                          items: days,
                          selected: selectedDay,
                          onChange: (val) => setState(() => selectedDay = val),
                          darkMode: darkMode,
                        ),
                        _buildPickerColumn(
                          title: "MONTH",
                          items: months,
                          selected: selectedMonth,
                          onChange: (val) =>
                              setState(() => selectedMonth = val),
                          darkMode: darkMode,
                        ),
                        _buildPickerColumn(
                          title: "YEAR",
                          items: years,
                          selected: selectedYear,
                          onChange: (val) => setState(() => selectedYear = val),
                          darkMode: darkMode,
                        ),
                      ],
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

  void _showHeightPicker() {
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
                    "Select Your Height",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _buildPickerColumn(
                      title: "HEIGHT (cm)",
                      items: heights,
                      selected: selectedHeight,
                      onChange: (val) => setState(() => selectedHeight = val),
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

  Widget _buildPickerColumn({
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

  Widget _buildDateBox(String label, String value, bool darkMode) {
    final borderColor = darkMode
        ? const Color.fromARGB(1000, 239, 230, 222)
        : const Color.fromARGB(1000, 154, 0, 2);
    final textColor = darkMode
        ? const Color.fromARGB(1000, 239, 230, 222)
        : const Color.fromARGB(1000, 154, 0, 2);

    return GestureDetector(
      onTap: _showDatePicker,
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
              value.padLeft(2, '0'),
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

  Widget _buildHeightBox(String label, String value, bool darkMode) {
    final borderColor = darkMode
        ? const Color.fromARGB(1000, 239, 230, 222)
        : const Color.fromARGB(1000, 154, 0, 2);
    final textColor = darkMode
        ? const Color.fromARGB(1000, 239, 230, 222)
        : const Color.fromARGB(1000, 154, 0, 2);

    return GestureDetector(
      onTap: _showHeightPicker,
      child: Container(
        width: 120,
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
              value,
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
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    isDarkMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, darkMode, child) {
        return Scaffold(
          backgroundColor: darkMode
              ? const Color.fromARGB(255, 0, 0, 0)
              : const Color.fromARGB(255, 255, 255, 255),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Picture Section
                  Column(
                    children: [
                      // Circle button for profile picture
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(1000, 154, 0, 2),
                            width: 2,
                          ),
                        ),
                        child: Material(
                          shape: const CircleBorder(),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(60),
                            onTap: () {
                              // Add profile picture logic here
                            },
                            child: const Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Color.fromARGB(1000, 154, 0, 2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Profile pic text
                      ValueListenableBuilder<bool>(
                        valueListenable: isDarkMode,
                        builder: (context, darkMode, child) {
                          return Text(
                            'Profile Pic',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkMode
                                  ? const Color.fromARGB(1000, 239, 230, 222)
                                  : const Color.fromARGB(1000, 154, 0, 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Username TextField
                  ValueListenableBuilder<bool>(
                    valueListenable: isDarkMode,
                    builder: (context, darkMode, child) {
                      return TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: darkMode
                                ? const Color.fromARGB(1000, 239, 230, 222)
                                : const Color.fromARGB(1000, 154, 0, 2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: darkMode
                                  ? const Color.fromARGB(1000, 239, 230, 222)
                                  : const Color.fromARGB(1000, 154, 0, 2),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: darkMode
                                  ? const Color.fromARGB(1000, 239, 230, 222)
                                  : const Color.fromARGB(1000, 154, 0, 2),
                              width: 2,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: darkMode
                              ? const Color.fromARGB(1000, 239, 230, 222)
                              : Colors.black,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Full Name TextField
                  ValueListenableBuilder<bool>(
                    valueListenable: isDarkMode,
                    builder: (context, darkMode, child) {
                      return TextField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                            color: darkMode
                                ? const Color.fromARGB(1000, 239, 230, 222)
                                : const Color.fromARGB(1000, 154, 0, 2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: darkMode
                                  ? const Color.fromARGB(1000, 239, 230, 222)
                                  : const Color.fromARGB(1000, 154, 0, 2),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: darkMode
                                  ? const Color.fromARGB(1000, 239, 230, 222)
                                  : const Color.fromARGB(1000, 154, 0, 2),
                              width: 2,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: darkMode
                              ? const Color.fromARGB(1000, 239, 230, 222)
                              : Colors.black,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Birth Date Section
                  ValueListenableBuilder<bool>(
                    valueListenable: isDarkMode,
                    builder: (context, darkMode, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Birth Date",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkMode
                                  ? const Color.fromARGB(1000, 239, 230, 222)
                                  : const Color.fromARGB(1000, 154, 0, 2),
                            ),
                          ),

                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDateBox(
                                "DAY",
                                selectedDay.toString(),
                                darkMode,
                              ),
                              _buildDateBox(
                                "MONTH",
                                selectedMonth.toString(),
                                darkMode,
                              ),
                              _buildDateBox(
                                "YEAR",
                                selectedYear.toString(),
                                darkMode,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Height Section
                  ValueListenableBuilder<bool>(
                    valueListenable: isDarkMode,
                    builder: (context, darkMode, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Height",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkMode
                                  ? const Color.fromARGB(1000, 239, 230, 222)
                                  : const Color.fromARGB(1000, 154, 0, 2),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildHeightBox(
                                "HEIGHT",
                                "$selectedHeight cm",
                                darkMode,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // Role and Level Row
                  Row(
                    children: [
                      // Role Dropdown
                      Expanded(
                        
                        child: SizedBox(
                          height: 65,
                          child: ValueListenableBuilder<bool>(
                            valueListenable: isDarkMode,
                            builder: (context, darkMode, child) {
                              return InputDecorator(
                                
                                decoration: InputDecoration(
                                  labelText: 'Role',
                                  labelStyle: TextStyle(
                                    color: darkMode
                                        ? const Color.fromARGB(
                                            1000,
                                            239,
                                            230,
                                            222,
                                          )
                                        : const Color.fromARGB(1000, 154, 0, 2),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: darkMode
                                          ? const Color.fromARGB(
                                              1000,
                                              239,
                                              230,
                                              222,
                                            )
                                          : const Color.fromARGB(1000, 154, 0, 2),
                                    ),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: ValueListenableBuilder(
                                    valueListenable: isDarkMode,
                                    builder: (context, value, child) {
                                      return DropdownButton<String>(
                                        value: _selectedRole,
                                        isExpanded: true,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: darkMode
                                              ? const Color.fromARGB(
                                                  1000,
                                                  239,
                                                  230,
                                                  222,
                                                )
                                              : const Color.fromARGB(
                                                  1000,
                                                  154,
                                                  0,
                                                  2,
                                                ),
                                        ),
                                        dropdownColor: darkMode
                                            ? const Color.fromARGB(255, 0, 0, 0)
                                            : const Color.fromARGB(
                                                255,
                                                255,
                                                255,
                                                255,
                                              ),
                                        items: _roles.map((String role) {
                                          return DropdownMenuItem<String>(
                                            value: role,
                                            child: Text(
                                              role,
                                              style: TextStyle(
                                                color: darkMode
                                                    ? const Color.fromARGB(
                                                        1000,
                                                        239,
                                                        230,
                                                        222,
                                                      )
                                                    : const Color.fromARGB(
                                                        255,
                                                        0,
                                                        0,
                                                        0,
                                                      ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedRole = newValue;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(width: 30),

                      // Level Dropdown
                      Expanded(
                        child: SizedBox(
                          height: 65,
                          child: ValueListenableBuilder<bool>(
                            valueListenable: isDarkMode,
                            builder: (context, darkMode, child) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Level',
                                  labelStyle: TextStyle(
                                    color: darkMode
                                        ? const Color.fromARGB(
                                            1000,
                                            239,
                                            230,
                                            222,
                                          )
                                        : const Color.fromARGB(1000, 154, 0, 2),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: darkMode
                                          ? const Color.fromARGB(
                                              1000,
                                              239,
                                              230,
                                              222,
                                            )
                                          : const Color.fromARGB(1000, 154, 0, 2),
                                    ),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedLevel,
                                    isExpanded: true,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: darkMode
                                          ? const Color.fromARGB(
                                              1000,
                                              239,
                                              230,
                                              222,
                                            )
                                          : const Color.fromARGB(1000, 154, 0, 2),
                                    ),
                                    dropdownColor: darkMode
                                        ? const Color.fromARGB(255, 0, 0, 0)
                                        : const Color.fromARGB(
                                            255,
                                            255,
                                            255,
                                            255,
                                          ),
                                    items: _levels.map((String level) {
                                      return DropdownMenuItem<String>(
                                        value: level,
                                        child: Text(
                                          level,
                                          style: TextStyle(
                                            color: darkMode
                                                ? const Color.fromARGB(
                                                    1000,
                                                    239,
                                                    230,
                                                    222,
                                                  )
                                                : Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedLevel = newValue;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Spacer to push button to bottom
                  const Spacer(),

                  // Save Button
                  SizedBox(
                    width: 180,
                    height: 55,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: isDarkMode,
                      builder: (context, darkMode, child) {
                        return ElevatedButton(
                          onPressed: () {
                            // Save profile logic Here
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StatsPage(
                                  selectedLevel: _selectedLevel ?? 'beginner',
                                  selectedRole: _selectedRole ?? 'pivot',
                                ),
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
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Save Profile',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}