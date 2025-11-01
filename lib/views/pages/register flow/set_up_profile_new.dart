import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/auth_services.dart';
import 'package:project_flutter/views/pages/register%20flow/stats_page.dart';

class SetUpProfileNew extends StatefulWidget {
  const SetUpProfileNew({super.key});

  @override
  State<SetUpProfileNew> createState() => _SetUpProfileNewState();
}

class _SetUpProfileNewState extends State<SetUpProfileNew> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  // final TextEditingController _weightController = TextEditingController();
  final TextEditingController _domisiliController = TextEditingController();

  final AuthService _authService = AuthService();
  final ImagePicker _imagePicker = ImagePicker();

  String? _selectedRole;
  String? _selectedLevel;
  // String? _selectedGender;
  XFile? _selectedImage;

  final List<String> _roles = ['pivot', 'Flank', 'anchor', 'goalkeeper'];
  final List<String> _levels = ['beginner', 'amateur', 'semi pro'];
  // final List<String> _genders = ['Male', 'Female', 'Other'];

  // Birth date variables
  int selectedDay = 1;
  int selectedMonth = 1;
  int selectedYear = DateTime.now().year - 20;
  List<int> days = List.generate(31, (index) => index + 1);
  List<int> months = List.generate(12, (index) => index + 1);
  List<int> years = List.generate(100, (index) => DateTime.now().year - index);

  // Height variables
  int selectedHeight = 170;
  List<int> heights = List.generate(111, (index) => index + 140);

  bool _isLoading = false;
  String? _errorMessage;

  // Calculate age from birth date
  int _calculateAge() {
    final birthDate = DateTime(selectedYear, selectedMonth, selectedDay);
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // Validate username format
  bool _isValidUsername(String username) {
    final usernameRegex = r'^[a-zA-Z0-9_]{3,20}$';
    return RegExp(usernameRegex).hasMatch(username);
  }

  // Validate full name
  bool _isValidFullName(String name) {
    return name.length >= 2 && name.length <= 50;
  }

  // Enhanced form validation
  bool _validateForm() {
    setState(() {
      _errorMessage = null;
    });

    final username = _usernameController.text.trim();
    final fullName = _fullNameController.text.trim();
    // final weightText = _weightController.text.trim();

    if (username.isEmpty) {
      _showError('Please enter a username');
      return false;
    }

    if (!_isValidUsername(username)) {
      _showError(
        'Username must be 3-20 characters and can only contain letters, numbers, and underscores',
      );
      return false;
    }

    if (fullName.isEmpty) {
      _showError('Please enter your full name');
      return false;
    }

    if (!_isValidFullName(fullName)) {
      _showError('Full name must be between 2-50 characters');
      return false;
    }

    // if (_selectedGender == null) {
    //   _showError('Please select your gender');
    //   return false;
    // }

    if (_selectedRole == null) {
      _showError('Please select your role');
      return false;
    }

    if (_selectedLevel == null) {
      _showError('Please select your level');
      return false;
    }

    // if (weightText.isEmpty) {
    //   _showError('Please enter your weight');
    //   return false;
    // }

    // final weight = int.tryParse(weightText);
    // if (weight == null) {
    //   _showError('Please enter a valid number for weight');
    //   return false;
    // }

    // if (weight <= 0 || weight > 300) {
    //   _showError('Please enter a weight between 1-300 kg');
    //   return false;
    // }

    // Validate age from birth date
    final age = _calculateAge();
    if (age < 13) {
      _showError('You must be at least 13 years old to use this app');
      return false;
    }

    if (age > 100) {
      _showError('Please enter a valid birth date');
      return false;
    }

    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Pick image from gallery
  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    }
  }

  // Save profile to Supabase
  // Save profile to Supabase
  Future<void> _saveProfile() async {
    if (!_validateForm()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final username = _usernameController.text.trim();
      if (username.isEmpty) {
        throw Exception('Username cannot be empty');
      }

      final isUsernameAvailable = await _authService.isUsernameAvailable(
        username,
      );

      if (!isUsernameAvailable) {
        _showError(
          'Username "$username" is already taken. Please choose another one.',
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Fix the height validation to match your actual range (140-250)
      if (selectedHeight < 140 || selectedHeight > 250) {
        throw Exception('Please enter a valid height between 140-250 cm');
      }

      final age = _calculateAge();
      if (age < 13) {
        throw Exception('You must be at least 13 years old to use this app');
      }
      if (age > 100) {
        throw Exception('Please enter a valid birth date');
      }

      // Additional fields in your profile data - ADD HEIGHT HERE
      final profileData = {
        'username': username,
        'full_name': _fullNameController.text.trim(),
        'age': age,
        'height': selectedHeight, // THIS IS THE KEY FIX
        'role': _selectedRole!,
        'level': _selectedLevel!,
        'date_of_birth':
            '$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-${selectedDay.toString().padLeft(2, '0')}',
        'timezone': DateTime.now().timeZoneName,
        'birth_year': selectedYear,
        'birth_month': selectedMonth,
        'birth_day': selectedDay,
      };

      final validationErrors = _authService.validateProfileData(profileData);
      if (validationErrors != null) {
        final errorMessage = validationErrors.values.join('\n');
        throw Exception(errorMessage);
      }

      // Uncomment your API call when ready
      final result = await _authService.createUserProfile(profileData);

      if (result['error'] != null) {
        final error = result['error'].toString();

        if (error.contains('duplicate key value violates unique constraint')) {
          throw Exception(
            'Username is already taken. Please choose another one.',
          );
        } else if (error.contains('violates check constraint')) {
          throw Exception(
            'Invalid data provided. Please check your information.',
          );
        } else if (error.contains('network') || error.contains('timeout')) {
          throw Exception(
            'Network error. Please check your connection and try again.',
          );
        } else {
          throw Exception('Failed to create profile: $error');
        }
      }

      _showSuccess('Profile created successfully! 🎉');

      await Future.delayed(const Duration(milliseconds: 1500));

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StatsPage(
              selectedLevel: _selectedLevel!,
              selectedRole: _selectedRole!,
            ),
          ),
        );
      }
    } on Exception catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      _showError(e.toString());
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred: $e';
      });
      _showError('An unexpected error occurred. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
    // _weightController.dispose();
    _domisiliController.dispose();
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
                  // Error message
                  if (_errorMessage != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),

                  // Profile Picture Section
                  Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: darkMode
                                  ? const Color.fromARGB(1000, 239, 230, 222)
                                  : const Color.fromARGB(1000, 154, 0, 2),
                              width: 2,
                            ),
                            image: _selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(
                                      File(_selectedImage!.path),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _selectedImage == null
                              ? Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: darkMode
                                      ? const Color.fromARGB(
                                          1000,
                                          239,
                                          230,
                                          222,
                                        )
                                      : const Color.fromARGB(1000, 154, 0, 2),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Profile Picture',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: darkMode
                              ? const Color.fromARGB(1000, 239, 230, 222)
                              : const Color.fromARGB(1000, 154, 0, 2),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Username TextField
                  TextField(
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
                  ),

                  const SizedBox(height: 16),

                  // Full Name TextField
                  TextField(
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
                  ),

                  // const SizedBox(height: 16),

                  // Gender Dropdown
                  // DropdownButtonFormField<String>(
                  //   value: _selectedGender,
                  //   decoration: InputDecoration(
                  //     labelText: 'Gender',
                  //     labelStyle: TextStyle(
                  //       color: darkMode
                  //           ? const Color.fromARGB(1000, 239, 230, 222)
                  //           : const Color.fromARGB(1000, 154, 0, 2),
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //       borderSide: BorderSide(
                  //         color: darkMode
                  //             ? const Color.fromARGB(1000, 239, 230, 222)
                  //             : const Color.fromARGB(1000, 154, 0, 2),
                  //       ),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //       borderSide: BorderSide(
                  //         color: darkMode
                  //             ? const Color.fromARGB(1000, 239, 230, 222)
                  //             : const Color.fromARGB(1000, 154, 0, 2),
                  //         width: 2,
                  //       ),
                  //     ),
                  //   ),
                  //   items: _genders.map((String gender) {
                  //     return DropdownMenuItem<String>(
                  //       value: gender,
                  //       child: Text(
                  //         gender,
                  //         style: TextStyle(
                  //           color: darkMode
                  //               ? const Color.fromARGB(1000, 239, 230, 222)
                  //               : Colors.black,
                  //         ),
                  //       ),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       _selectedGender = newValue;
                  //     });
                  //   },
                  // ),

                  // const SizedBox(height: 16),

                  // Weight TextField
                  // TextField(
                  //   controller: _weightController,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //     labelText: 'Weight (kg)',
                  //     labelStyle: TextStyle(
                  //       color: darkMode
                  //           ? const Color.fromARGB(1000, 239, 230, 222)
                  //           : const Color.fromARGB(1000, 154, 0, 2),
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //       borderSide: BorderSide(
                  //         color: darkMode
                  //             ? const Color.fromARGB(1000, 239, 230, 222)
                  //             : const Color.fromARGB(1000, 154, 0, 2),
                  //       ),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //       borderSide: BorderSide(
                  //         color: darkMode
                  //             ? const Color.fromARGB(1000, 239, 230, 222)
                  //             : const Color.fromARGB(1000, 154, 0, 2),
                  //         width: 2,
                  //       ),
                  //     ),
                  //   ),
                  //   style: TextStyle(
                  //     color: darkMode
                  //         ? const Color.fromARGB(1000, 239, 230, 222)
                  //         : Colors.black,
                  //   ),
                  // ),
                  const SizedBox(height: 16),

                  // Domisili TextField
                  // TextField(
                  //   controller: _domisiliController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Location (Domisili)',
                  //     labelStyle: TextStyle(
                  //       color: darkMode
                  //           ? const Color.fromARGB(1000, 239, 230, 222)
                  //           : const Color.fromARGB(1000, 154, 0, 2),
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //       borderSide: BorderSide(
                  //         color: darkMode
                  //             ? const Color.fromARGB(1000, 239, 230, 222)
                  //             : const Color.fromARGB(1000, 154, 0, 2),
                  //       ),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //       borderSide: BorderSide(
                  //         color: darkMode
                  //             ? const Color.fromARGB(1000, 239, 230, 222)
                  //             : const Color.fromARGB(1000, 154, 0, 2),
                  //         width: 2,
                  //       ),
                  //     ),
                  //   ),
                  //   style: TextStyle(
                  //     color: darkMode
                  //         ? const Color.fromARGB(1000, 239, 230, 222)
                  //         : Colors.black,
                  //   ),
                  // ),

                  // const SizedBox(height: 24),

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
                          const SizedBox(height: 8),
                          Text(
                            'Age: ${_calculateAge()} years',
                            style: TextStyle(
                              fontSize: 14,
                              color: darkMode
                                  ? const Color.fromARGB(1000, 239, 230, 222)
                                  : const Color.fromARGB(1000, 154, 0, 2),
                            ),
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

                  const SizedBox(height: 30),

                  // Role and Level Row
                  Row(
                    children: [
                      // Role Dropdown
                      Expanded(
                        child: SizedBox(
                          height: 60,
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
                                          : const Color.fromARGB(
                                              1000,
                                              154,
                                              0,
                                              2,
                                            ),
                                    ),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
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
                                        : Colors.white,
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
                                                : Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedRole = newValue;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Level Dropdown
                      Expanded(
                        child: SizedBox(
                          height: 60,
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
                                          : const Color.fromARGB(
                                              1000,
                                              154,
                                              0,
                                              2,
                                            ),
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
                                          : const Color.fromARGB(
                                              1000,
                                              154,
                                              0,
                                              2,
                                            ),
                                    ),
                                    dropdownColor: darkMode
                                        ? const Color.fromARGB(255, 0, 0, 0)
                                        : Colors.white,
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

                  const Spacer(),

                  // Save Button
                  SizedBox(
                    width: 180,
                    height: 55,
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                darkMode
                                    ? const Color.fromARGB(1000, 239, 230, 222)
                                    : const Color.fromARGB(1000, 154, 0, 2),
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: _saveProfile,
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
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
