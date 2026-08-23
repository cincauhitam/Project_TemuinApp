import 'dart:developer'; // Correct import for log function
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/auth_services.dart';
import 'package:project_flutter/study.dart';
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
                    final dialogNavigator = Navigator.of(dialogContext);
                    final pageMessenger = ScaffoldMessenger.maybeOf(pageContext);

                    setDialogState(() => isVerifying = true);

                    try {
                      log("Attempting to login after email verification...");
                      final loginResponse = await _authService.login(email, password);
                      log("Login successful: $loginResponse");

                      if (dialogNavigator.canPop()) {
                        dialogNavigator.pop();
                      }

                      await Future.delayed(const Duration(milliseconds: 200));

                      if (!pageContext.mounted) return;

                      pageMessenger?.showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Email verified! Setting up your profile...",
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(milliseconds: 800),
                        ),
                      );

                      await Future.delayed(const Duration(milliseconds: 800));

                      if (!pageContext.mounted) return;

                      log("Navigating to SetUpProfileNew...");
                      Navigator.pushReplacement(
                        pageContext,
                        MaterialPageRoute(
                          builder: (context) => const SetUpProfileNew(),
                        ),
                      );
                    } catch (e) {
                      log("Login failed: $e");

                      if (dialogNavigator.canPop()) {
                        setDialogState(() => isVerifying = false);
                      }

                      if (!pageContext.mounted) return;

                      pageMessenger?.showSnackBar(
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
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WidgetTree(),
                          ),
                        ),
                        // onPressed: isLoading
                        //     ? null
                        //     : () async {
                        //         final currentContext = context;
                        //         final currentMessenger = ScaffoldMessenger.maybeOf(currentContext);
                        //         final currentNavigator = Navigator.of(currentContext);
                        //         final email = emailController.text.trim();
                        //         final reEmail = reenterEmailController.text.trim();
                        //         final password = passwordController.text.trim();
                        //         final rePassword = reenterPasswordController.text.trim();

                        //         if (email != reEmail) {
                        //           currentMessenger?.showSnackBar(
                        //             const SnackBar(
                        //               content: Text("Emails don't match"),
                        //             ),
                        //           );
                        //           return;
                        //         }

                        //         if (password != rePassword) {
                        //           currentMessenger?.showSnackBar(
                        //             const SnackBar(
                        //               content: Text("Passwords don't match"),
                        //             ),
                        //           );
                        //           return;
                        //         }

                        //         if (!privacyPolicy) {
                        //           currentMessenger?.showSnackBar(
                        //             const SnackBar(
                        //               content: Text(
                        //                 "You must agree to the privacy policy",
                        //               ),
                        //             ),
                        //           );
                        //           return;
                        //         }

                        //         setState(() => isLoading = true);

                        //         try {
                        //           log("Starting registration for email: $email");
                        //           final registerResponse = await _authService.register(email, password);
                        //           log("User registered successfully: $registerResponse");

                        //           final confirmationRequired = registerResponse['confirmation_required'] == true;

                        //           if (confirmationRequired) {
                        //             log("Email verification required");
                        //             setState(() => isLoading = false);

                        //             if (mounted) {
                        //               WidgetsBinding.instance.addPostFrameCallback((_) {
                        //                 if (mounted) {
                        //                   _showEmailVerificationDialog(currentContext, email, password);
                        //                 }
                        //               });
                        //             }
                        //           } else {
                        //             log("No email verification required, proceeding to profile setup");

                        //             if (mounted) {
                        //               currentMessenger?.showSnackBar(
                        //                 const SnackBar(
                        //                   content: Text(
                        //                     "Registration successful! Setting up your profile...",
                        //                   ),
                        //                   backgroundColor: Colors.green,
                        //                 ),
                        //               );

                        //               await Future.delayed(const Duration(milliseconds: 500));

                        //               if (!mounted) return;
                        //               currentNavigator.pushReplacement(
                        //                 MaterialPageRoute(
                        //                   builder: (context) => const SetUpProfileNew(),
                        //                 ),
                        //               );
                        //             }

                        //             setState(() => isLoading = false);
                        //           }
                        //         } catch (e, stack) {
                        //           log(
                        //             "Registration failed",
                        //             error: e,
                        //             stackTrace: stack,
                        //           );
                        //           if (mounted) {
                        //             currentMessenger?.showSnackBar(
                        //               SnackBar(
                        //                 content: Text("Registration failed: $e"),
                        //               ),
                        //             );
                        //           }
                        //           setState(() => isLoading = false);
                        //         }
                        //       },
                        child: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(maroon),
                                ),
                              )
                            : Text(
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
