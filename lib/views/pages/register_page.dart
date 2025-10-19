import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:project_flutter/services/auth_services.dart';
import 'package:project_flutter/views/pages/set_up_profile.dart';
import 'package:project_flutter/views/pages/login_page.dart';

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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Register Account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),

              // Email field
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 18),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),

              // Re-enter email field
              const Text(
                "Re-enter Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 18),
                child: TextFormField(
                  controller: reenterEmailController,
                  decoration: InputDecoration(
                    labelText: 'Re-enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),

              // Password field
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 18),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),

              // Re-enter password
              const Text(
                "Re-enter Password",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 18),
                child: TextFormField(
                  controller: reenterPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Re-enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Checkboxes
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Receive news and updates'),
                value: receiveNews,
                onChanged: (bool? value) {
                  setState(() => receiveNews = value ?? false);
                },
              ),

              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Agree to privacy policy'),
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
                    backgroundColor: const Color.fromARGB(1000, 83, 104, 120),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          final email = emailController.text.trim();
                          final reEmail = reenterEmailController.text.trim();
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
                            final registerResult = await AuthService().register(
                              email,
                              password,
                            );
                            log("User registered: $registerResult");

                            // // ✅ Step 2: Automatically log in user
                            final loginResult = await AuthService().login(
                              email,
                              password,
                            );
                            log("User logged in automatically: $loginResult");

                            // ✅ Step 3: Navigate to main app
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SetUpProfile(),
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
                      : const Text('Register', style: TextStyle(fontSize: 18)),
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
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
