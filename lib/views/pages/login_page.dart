import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/auth_services.dart';
import 'package:project_flutter/views/pages/register%20flow/set_up_profile_new.dart';
import 'package:project_flutter/views/pages/register_page.dart';
import 'package:project_flutter/views/widget_tree.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, dark, _) {
        return Scaffold(
          backgroundColor: dark ? const Color(0xFF001010) : Colors.white,
          appBar: AppBar(
            backgroundColor: dark ? const Color(0xFF001010) : Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  dark ? Icons.dark_mode : Icons.light_mode,
                  color: dark ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  isDarkMode.value = !isDarkMode.value;
                },
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Image on top
                    Image.asset(
                      'assets/images/test_icon.png',
                      height: 250,
                      alignment: Alignment.topCenter,
                    ),
                    const SizedBox(height: 50),

                    // Username field
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        } else if (!value.contains('@')) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: dark ? Colors.white70 : Colors.black54,
                        ),
                        filled: true,
                        fillColor: dark
                            ? const Color(0xFF002020)
                            : const Color(0xFFF8F8F8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      style: TextStyle(
                        color: dark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Password field
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: dark ? Colors.white70 : Colors.black54,
                        ),
                        filled: true,
                        fillColor: dark
                            ? const Color(0xFF002020)
                            : const Color(0xFFF8F8F8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      style: TextStyle(
                        color: dark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Remember me
                    CheckboxListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        'Remember me',
                        style: TextStyle(
                          color: dark ? Colors.white : Colors.black,
                        ),
                      ),
                      value: rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    // LOGIN button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: dark
                              ? const Color(0xFFEFE6DE)
                              : const Color(0xFF9A0002),
                          foregroundColor: dark ? Colors.black : Colors.white,
                        ),
                        onPressed: () async {
                          final email = usernameController.text;
                          final password = passwordController.text;

                          try {
                            final result =
                                await AuthService().login(email, password);
                            print("User logged in: $result");

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WidgetTree(),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    // CONTINUE WITH GOOGLE button
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              final authService = AuthService();
                              final result =
                                  await authService.signInWithGoogle();

                              if (result.user != null) {
                                print(
                                    "User logged in with Google: ${result.user!.email}");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SetUpProfileNew(),
                                  ),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Google sign-in failed: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: dark
                                ? const Color(0xFFEFE6DE)
                                : const Color(0xFF9A0002),
                            foregroundColor: dark ? Colors.black : Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 25),
                                  child: Image.asset(
                                    'assets/images/google.png',
                                    height: 35,
                                  ),
                                ),
                                const Text(
                                  "Continue with Google",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Register navigation
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Don\'t have an account? Register',
                        style: TextStyle(
                          color: dark ? Colors.white : Colors.black,
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
