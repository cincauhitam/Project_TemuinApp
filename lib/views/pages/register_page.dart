import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/auth_services.dart';
import 'package:project_flutter/views/pages/login_page.dart';
import 'package:project_flutter/views/pages/register%20flow/set_up_profile_new.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool receiveNews = false;
  bool privacyPolicy = false;
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController reenterEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reenterPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        final backgroundColor = dark ? const Color(0xFF001010) : Colors.white;
        final textColor = dark ? Colors.white : Colors.black;
        final inputFillColor = dark
            ? const Color(0xFF002020)
            : const Color(0xFFF7F7F7);
        final buttonColor = dark
            ? const Color(0xFFEFE6DE)
            : const Color(0xFF9A0002);
        final buttonTextColor = dark ? Colors.black : Colors.white;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Register Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Email field
                  Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 18),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Enter your email',
                        labelStyle: TextStyle(
                          color: textColor.withOpacity(0.6),
                        ),
                        filled: true,
                        fillColor: inputFillColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      style: TextStyle(color: textColor),
                    ),
                  ),

                  // Re-enter email field
                  Text(
                    "Re-enter Email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 18),
                    child: TextFormField(
                      controller: reenterEmailController,
                      decoration: InputDecoration(
                        labelText: 'Re-enter your email',
                        labelStyle: TextStyle(
                          color: textColor.withOpacity(0.6),
                        ),
                        filled: true,
                        fillColor: inputFillColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      style: TextStyle(color: textColor),
                    ),
                  ),

                  // Password field
                  Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 18),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Enter your password',
                        labelStyle: TextStyle(
                          color: textColor.withOpacity(0.6),
                        ),
                        filled: true,
                        fillColor: inputFillColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      style: TextStyle(color: textColor),
                    ),
                  ),

                  // Re-enter password
                  Text(
                    "Re-enter Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 18),
                    child: TextFormField(
                      controller: reenterPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Re-enter your password',
                        labelStyle: TextStyle(
                          color: textColor.withOpacity(0.6),
                        ),
                        filled: true,
                        fillColor: inputFillColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      style: TextStyle(color: textColor),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Checkboxes
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      'Receive news and updates',
                      style: TextStyle(color: textColor),
                    ),
                    value: receiveNews,
                    onChanged: (bool? value) {
                      setState(() => receiveNews = value ?? false);
                    },
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      'Agree to privacy policy',
                      style: TextStyle(color: textColor),
                    ),
                    value: privacyPolicy,
                    onChanged: (bool? value) {
                      setState(() => privacyPolicy = value ?? false);
                    },
                  ),

                  const SizedBox(height: 24),

                  // Register button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: buttonTextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () async {
                              final email = emailController.text.trim();
                              final reEmail = reenterEmailController.text
                                  .trim();
                              final password = passwordController.text.trim();
                              final rePassword = reenterPasswordController.text
                                  .trim();

                              if (email != reEmail) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Emails don't match"),
                                  ),
                                );
                                return;
                              }

                              if (password != rePassword) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Passwords don't match"),
                                  ),
                                );
                                return;
                              }

                              if (!privacyPolicy) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "You must agree to the privacy policy",
                                    ),
                                  ),
                                );
                                return;
                              }

                              setState(() => isLoading = true);

                              try {
                                // // ✅ Step 1: Register new user
                                final registerResult = await AuthService().register(
                                  email,
                                  password,
                                );
                                log("User registered: $registerResult");

                                // // // ✅ Step 2: Automatically log in user
                                final loginResult = await AuthService().login(
                                  email,
                                  password,
                                );
                                log("User logged in automatically: $loginResult");

                                // ✅ Step 3: Navigate to main app
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SetUpProfileNew(),
                                  ),
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Registration successful! Logged in automatically.",
                                    ),
                                  ),
                                );
                              } catch (e, stack) {
                                log(
                                  "Registration failed",
                                  error: e,
                                  stackTrace: stack,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Registration failed: $e"),
                                  ),
                                );
                              } finally {
                                setState(() => isLoading = false);
                              }
                            },
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Back to login
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Already have an account? Login',
                        style: TextStyle(color: textColor),
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
