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
            return Container(
              height: 300,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: dark
                    ? const Color.fromARGB(1000, 239, 230, 222)
                    : const Color.fromARGB(1000, 154, 0, 2),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Select Your Birth Date",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: dark
                          ? const Color.fromARGB(1000, 154, 0, 2)
                          : const Color.fromARGB(1000, 239, 230, 222),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      children: [
                        // Day picker
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "DAY",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: dark
                                      ? const Color.fromARGB(1000, 154, 0, 2)
                                      : const Color.fromARGB(1000, 239, 230, 222),
                                ),
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    ListWheelScrollView(
                                      itemExtent: 40,
                                      perspective: 0.005,
                                      diameterRatio: 1.5,
                                      onSelectedItemChanged: (index) {
                                        setState(() {
                                          selectedDay = days[index];
                                        });
                                      },
                                      children: days.map((day) {
                                        return Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: Text(
                                            day.toString().padLeft(2, '0'),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: selectedDay == day 
                                                  ? FontWeight.bold 
                                                  : FontWeight.normal,
                                              color: dark
                                                  ? const Color.fromARGB(1000, 154, 0, 2)
                                                  : const Color.fromARGB(1000, 239, 230, 222),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    // Highlight box
                                    IgnorePointer(
                                      child: Center(
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: dark
                                                  ? const Color.fromARGB(1000, 154, 0, 2)
                                                  : const Color.fromARGB(1000, 239, 230, 222),
                                              width: 2,
                                            ),
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
                        ),

                        // Month picker
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "MONTH",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: dark
                                      ? const Color.fromARGB(1000, 154, 0, 2)
                                      : const Color.fromARGB(1000, 239, 230, 222),
                                ),
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    ListWheelScrollView(
                                      itemExtent: 40,
                                      perspective: 0.005,
                                      diameterRatio: 1.5,
                                      onSelectedItemChanged: (index) {
                                        setState(() {
                                          selectedMonth = months[index];
                                        });
                                      },
                                      children: months.map((month) {
                                        return Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: Text(
                                            month.toString().padLeft(2, '0'),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: selectedMonth == month 
                                                  ? FontWeight.bold 
                                                  : FontWeight.normal,
                                              color: dark
                                                  ? const Color.fromARGB(1000, 154, 0, 2)
                                                  : const Color.fromARGB(1000, 239, 230, 222),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    // Highlight box
                                    IgnorePointer(
                                      child: Center(
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: dark
                                                  ? const Color.fromARGB(1000, 154, 0, 2)
                                                  : const Color.fromARGB(1000, 239, 230, 222),
                                              width: 2,
                                            ),
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
                        ),

                        // Year picker
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "YEAR",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: dark
                                      ? const Color.fromARGB(1000, 154, 0, 2)
                                      : const Color.fromARGB(1000, 239, 230, 222),
                                ),
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    ListWheelScrollView(
                                      itemExtent: 40,
                                      perspective: 0.005,
                                      diameterRatio: 1.5,
                                      onSelectedItemChanged: (index) {
                                        setState(() {
                                          selectedYear = years[index];
                                        });
                                      },
                                      children: years.map((year) {
                                        return Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: Text(
                                            year.toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: selectedYear == year 
                                                  ? FontWeight.bold 
                                                  : FontWeight.normal,
                                              color: dark
                                                  ? const Color.fromARGB(1000, 154, 0, 2)
                                                  : const Color.fromARGB(1000, 239, 230, 222),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    // Highlight box
                                    IgnorePointer(
                                      child: Center(
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: dark
                                                  ? const Color.fromARGB(1000, 154, 0, 2)
                                                  : const Color.fromARGB(1000, 239, 230, 222),
                                              width: 2,
                                            ),
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
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dark
                          ? const Color.fromARGB(1000, 154, 0, 2)
                          : const Color.fromARGB(1000, 239, 230, 222),
                    ),
                    child: Text(
                      "CONFIRM",
                      style: TextStyle(
                        color: dark
                            ? const Color.fromARGB(1000, 239, 230, 222)
                            : const Color.fromARGB(1000, 154, 0, 2)
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

  String get formattedDate {
    return '${selectedDay.toString().padLeft(2, '0')}/${selectedMonth.toString().padLeft(2, '0')}/$selectedYear';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: isDarkMode,
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Image at the top
                Image.asset(
                  'assets/images/waving_cartoon.png', // Replace with your actual image path
                  height: 200,
                  width: 300,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30),

                // Name Input Section - Centered
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Let us know your name!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: _nameController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "Enter your name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(flex: 1),

                // Birth Date Section - Centered
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Your birth date",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Individual date displays in 3 rows
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Day
                        GestureDetector(
                          onTap: _showDatePicker,
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  "DAY",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  selectedDay.toString().padLeft(2, '0'),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Month
                        GestureDetector(
                          onTap: _showDatePicker,
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  "MONTH",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  selectedMonth.toString().padLeft(2, '0'),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Year
                        GestureDetector(
                          onTap: _showDatePicker,
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  "YEAR",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  selectedYear.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(flex: 2),

                // Proceed Button
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
                      backgroundColor: value
                          ? const Color.fromARGB(1000, 239, 230, 222)
                          : const Color.fromARGB(1000, 154, 0, 2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 20,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: isDarkMode,
                      builder: (context, Dark, _) {
                        return Text(
                          "PROCEED",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Dark
                                ? const Color.fromARGB(1000, 154, 0, 2)
                                : const Color.fromARGB(1000, 239, 230, 222),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}