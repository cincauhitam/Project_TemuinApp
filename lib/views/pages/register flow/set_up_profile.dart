import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/views/pages/register%20flow/set_up_traits.dart';

class SetUpProfile extends StatefulWidget {
  const SetUpProfile({super.key});

  @override
  State<SetUpProfile> createState() => _SetUpProfileState();
}

class _SetUpProfileState extends State<SetUpProfile> {
  final TextEditingController _nameController = TextEditingController();

  int selectedDay = 1;
  int selectedMonth = 1;
  int selectedYear = DateTime.now().year;

  List<int> days = List.generate(31, (index) => index + 1);
  List<int> months = List.generate(12, (index) => index + 1);
  List<int> years = List.generate(100, (index) => DateTime.now().year - index);

  void _showDatePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ValueListenableBuilder(
          valueListenable: isDarkMode,
          builder: (context, dark, child) {
            final bgColor =
                dark ? const Color(0xFFEFE6DE) : const Color(0xFF9A0002);
            final textColor =
                dark ? const Color(0xFF9A0002) : const Color(0xFFEFE6DE);

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
                          dark: dark,
                        ),
                        _buildPickerColumn(
                          title: "MONTH",
                          items: months,
                          selected: selectedMonth,
                          onChange: (val) => setState(() => selectedMonth = val),
                          dark: dark,
                        ),
                        _buildPickerColumn(
                          title: "YEAR",
                          items: years,
                          selected: selectedYear,
                          onChange: (val) => setState(() => selectedYear = val),
                          dark: dark,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          dark ? const Color(0xFF9A0002) : const Color(0xFFEFE6DE),
                    ),
                    child: Text(
                      "CONFIRM",
                      style: TextStyle(
                        color: dark
                            ? const Color(0xFFEFE6DE)
                            : const Color(0xFF9A0002),
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
    required bool dark,
  }) {
    final highlightColor =
        dark ? const Color(0xFF9A0002) : const Color(0xFFEFE6DE);

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

  String get formattedDate =>
      '${selectedDay.toString().padLeft(2, '0')}/${selectedMonth.toString().padLeft(2, '0')}/$selectedYear';

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        final bgColor = dark ? const Color(0xFF001010) : Colors.white;
        final textColor = dark ? Colors.white : Colors.black;
        final buttonColor = dark ? const Color(0xFFEFE6DE) : const Color(0xFF9A0002);
        final buttonTextColor = dark ? const Color(0xFF9A0002) : Colors.white;

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            iconTheme: IconThemeData(color: textColor),
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Top image
                Image.asset(
                  'assets/images/waving_cartoon.png',
                  height: 200,
                  width: 300,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30),

                // Name input
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Let us know your name!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        hintStyle:
                            TextStyle(color: textColor.withOpacity(0.5)),
                        fillColor:
                            dark ? const Color(0xFF002020) : const Color(0xFFF7F7F7),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                      ),
                      style: TextStyle(color: textColor),
                    ),
                  ],
                ),

                const Spacer(flex: 1),

                // Birth date section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Your birth date",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDateBox("DAY", selectedDay.toString(), dark),
                        _buildDateBox("MONTH", selectedMonth.toString(), dark),
                        _buildDateBox("YEAR", selectedYear.toString(), dark),
                      ],
                    ),
                  ],
                ),

                const Spacer(flex: 2),

                // Proceed button
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SetUpTraits()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      "PROCEED",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: buttonTextColor,
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

  Widget _buildDateBox(String label, String value, bool dark) {
    final borderColor =
        dark ? Colors.white.withOpacity(0.4) : Colors.grey.shade300;
    final textColor = dark ? Colors.white : Colors.black;

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
                color: Colors.grey,
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

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
