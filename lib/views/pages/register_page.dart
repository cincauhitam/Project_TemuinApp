import 'dart:developer'; // Correct import for log function
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

  // Use the same AuthService instance
  final AuthService _authService = AuthService();

  // Show email verification dialog
  void _showEmailVerificationDialog(BuildContext context, String email, String password) {
    // Capture the page context explicitly
    final pageContext = context;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        bool isVerifying = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.email_outlined, color: Colors.blue, size: 28),
                  SizedBox(width: 12),
                  Text('Verify Your Email'),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'We\'ve sent a verification email to:',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Please check your email and click the verification link to activate your account.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'After verifying, click "Continue" below.',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isVerifying ? null : () {
                    if (Navigator.of(dialogContext).canPop()) {
                      Navigator.of(dialogContext).pop();
                    }
                    if (pageContext.mounted) {
                      Navigator.pushReplacement(
                        pageContext,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    }
                  },
                  child: const Text('Back to Login'),
                ),
                ElevatedButton(
                  onPressed: isVerifying ? null : () async {
                    setDialogState(() => isVerifying = true);

                    try {
                      log("Attempting to login after email verification...");
                      final loginResponse = await _authService.login(email, password);
                      log("Login successful: $loginResponse");

                      // Close the dialog FIRST before navigating
                      if (Navigator.of(dialogContext).canPop()) {
                        Navigator.of(dialogContext).pop();
                      }

                      // Small delay to ensure dialog is fully closed
                      await Future.delayed(const Duration(milliseconds: 200));

                      // Use pageContext for navigation to ensure proper context
                      if (pageContext.mounted) {
                        ScaffoldMessenger.of(pageContext).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Email verified! Setting up your profile...",
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(milliseconds: 800),
                          ),
                        );

                        await Future.delayed(const Duration(milliseconds: 800));

                        if (pageContext.mounted) {
                          log("Navigating to SetUpProfileNew...");
                          Navigator.pushReplacement(
                            pageContext,
                            MaterialPageRoute(
                              builder: (context) => const SetUpProfileNew(),
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      log("Login failed: $e");

                      // Only update state if dialog is still mounted
                      if (Navigator.of(dialogContext).canPop()) {
                        setDialogState(() => isVerifying = false);
                      }

                      if (pageContext.mounted) {
                        ScaffoldMessenger.of(pageContext).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.toString().contains('Email not confirmed')
                                  ? 'Please verify your email first'
                                  : 'Login failed: $e',
                            ),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
                    }
                  },
                  child: isVerifying
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Continue'),
                ),
              ],
            );
          },
        );
      },
    );
  }

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
                                // ✅ Step 1: Register new user
                                log("Starting registration for email: $email");
                                final registerResponse = await _authService
                                    .register(email, password);
                                log("User registered successfully: $registerResponse");

                                // Check if email confirmation is required
                                final confirmationRequired = registerResponse['confirmation_required'] == true;

                                if (confirmationRequired) {
                                  // Email verification required
                                  log("Email verification required");
                                  setState(() => isLoading = false);

                                  if (mounted) {
                                    _showEmailVerificationDialog(context, email, password);
                                  }
                                } else {
                                  // No email verification required, proceed directly
                                  log("No email verification required, proceeding to profile setup");

                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Registration successful! Setting up your profile...",
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );

                                    await Future.delayed(const Duration(milliseconds: 500));

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SetUpProfileNew(),
                                      ),
                                    );
                                  }

                                  setState(() => isLoading = false);
                                }
                              } catch (e, stack) {
                                log(
                                  "Registration failed",
                                  error: e,
                                  stackTrace: stack,
                                );
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Registration failed: $e"),
                                    ),
                                  );
                                }
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
