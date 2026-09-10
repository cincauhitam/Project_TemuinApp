import 'dart:developer'; // Correct import for log function
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';
// import 'package:project_flutter/services/auth_services.dart'; // Commented out for dummy version
// Removed mock_auth_service per PRD v2.0
import 'package:project_flutter/views/pages/login_page.dart';
import 'package:project_flutter/views/pages/login_page_new.dart';
import 'package:project_flutter/views/pages/register%20flow/set_up_profile_new.dart';
import 'package:project_flutter/views/widget_tree.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool receiveNews = false;
  bool privacyPolicy = false;
  // bool isLoading = false;  // REMOVED: auth loading state not needed for dummy version

  final TextEditingController emailController = TextEditingController();
  final TextEditingController reenterEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reenterPasswordController =
      TextEditingController();

  // DEMO: Use mock auth service instead of real Supabase auth
  // final AuthService _authService = AuthService();

  // REMOVED FOR DUMMY VERSION — all authentication functions commented out per request
  // void _showEmailVerificationDialog(BuildContext context, String email, String password) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext dialogContext) { ... },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    const maroon = Color.fromARGB(1000, 154, 0, 2);
    const cream = Color.fromARGB(1000, 239, 230, 222);

    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        final backgroundColor = maroon;
        final textColor = cream;
        final hintColor = cream.withValues(alpha: 0.7);
        final buttonColor = cream;
        final buttonTextColor = maroon;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                   
                    const SizedBox(height: 12),
                    Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: textColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 28),

                    Text(
                      'Email',
                      style: GoogleFonts.poppins(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.poppins(color: textColor, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: GoogleFonts.poppins(color: hintColor, fontSize: 14),
                        filled: true,
                        fillColor: Colors.transparent,
                        prefixIcon: const Icon(Icons.email_outlined, color: cream),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: cream, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: cream, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: cream, width: 1.8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    Text(
                      'Re-enter Email',
                      style: GoogleFonts.poppins(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: reenterEmailController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.poppins(color: textColor, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Re-enter your email',
                        hintStyle: GoogleFonts.poppins(color: hintColor, fontSize: 14),
                        filled: true,
                        fillColor: Colors.transparent,
                        prefixIcon: const Icon(Icons.email_outlined, color: cream),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: cream, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: cream, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: cream, width: 1.8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    Text(
                      'Password',
                      style: GoogleFonts.poppins(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      style: GoogleFonts.poppins(color: textColor, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: GoogleFonts.poppins(color: hintColor, fontSize: 14),
                        filled: true,
                        fillColor: Colors.transparent,
                        prefixIcon: const Icon(Icons.lock_outline, color: cream),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: cream, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: cream, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: cream, width: 1.8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    Text(
                      'Re-enter Password',
                      style: GoogleFonts.poppins(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: reenterPasswordController,
                      obscureText: true,
                      style: GoogleFonts.poppins(color: textColor, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Re-enter your password',
                        hintStyle: GoogleFonts.poppins(color: hintColor, fontSize: 14),
                        filled: true,
                        fillColor: Colors.transparent,
                        prefixIcon: const Icon(Icons.lock_outline, color: cream),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: cream, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: cream, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: cream, width: 1.8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: cream,
                        checkboxTheme: CheckboxThemeData(
                          fillColor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Color.fromARGB(232, 239, 230, 222);
                            }
                            return Colors.transparent;
                          }),
                        ),
                      ),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'Receive news and updates',
                          style: GoogleFonts.poppins(color: textColor, fontSize: 13),
                        ),
                        value: receiveNews,
                        onChanged: (bool? value) {
                          setState(() => receiveNews = value ?? false);
                        },
                        activeColor: cream,
                        checkColor: maroon,
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: cream,
                        checkboxTheme: CheckboxThemeData(
                          fillColor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.selected)) {
                              return cream;
                            }
                            return Colors.transparent;
                          }),
                        ),
                      ),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'Agree to privacy policy',
                          style: GoogleFonts.poppins(color: textColor, fontSize: 13),
                        ),
                        value: privacyPolicy,
                        onChanged: (bool? value) {
                          setState(() => privacyPolicy = value ?? false);
                        },
                        activeColor: cream,
                        checkColor: maroon,
                      ),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          foregroundColor: buttonTextColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () async {
                          final currentMessenger = ScaffoldMessenger.of(context);
                          final currentNavigator = Navigator.of(context);

                          // SIMULATED REGISTRATION — no actual auth (dummy version)
                          await Future.delayed(const Duration(seconds: 1)); // Simulate delay

                          if (!mounted) return;

                          currentMessenger.showSnackBar(
                            const SnackBar(
                              content: Text("Registration successful! Setting up your profile..."),
                              backgroundColor: Colors.green,
                              duration: Duration(milliseconds: 800),
                            ),
                          );

                          await Future.delayed(const Duration(milliseconds: 800));

                          if (!mounted) return;
                          currentNavigator.pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SetUpProfileNew(),
                            ),
                          );
                        },
                        child: Text(
                          'Register',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: buttonTextColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: Text(
                          'Already have an account? Login',
                          style: GoogleFonts.poppins(
                            color: textColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


