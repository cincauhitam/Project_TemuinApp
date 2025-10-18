import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/services/auth_services.dart';
import 'package:project_flutter/views/pages/register_page.dart';
import 'package:project_flutter/views/widget_tree.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;
  bool privacyPolicy = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Login Page")),
        actions: [
          IconButton(
            icon: ValueListenableBuilder<bool>(
              valueListenable: isDarkMode,
              builder: (context, value, _) =>
                  Icon(value ? Icons.dark_mode : Icons.light_mode),
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
                  height: 200,
                  alignment: Alignment.topCenter,
                ),
                const SizedBox(height: 35),

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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password field
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Remember me
                CheckboxListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text('Remember me'),
                  value: rememberMe,
                  onChanged: (bool? value) {
                    setState(() {
                      rememberMe = value ?? false;
                    });
                  },
                ),

                // Privacy policy
                CheckboxListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text('On some privacy shiiii'),
                  value: privacyPolicy,
                  onChanged: (bool? value) {
                    setState(() {
                      privacyPolicy = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // LOGIN button (dark mode adaptive)
                ValueListenableBuilder<bool>(
                  valueListenable: isDarkMode,
                  builder: (context, dark, _) {
                    return SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: dark
                              ? const Color.fromARGB(1000, 239, 230, 222)
                              : const Color.fromARGB(1000, 154, 0, 2),
                          foregroundColor:
                              dark ? Colors.black : Colors.white,
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
                                  builder: (context) => WidgetTree()),
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
                    );
                  },
                ),

                // CONTINUE WITH GOOGLE button (dark mode adaptive)
                ValueListenableBuilder<bool>(
                  valueListenable: isDarkMode,
                  builder: (context, dark, _) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Google login logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: dark
                                ? const Color.fromARGB(1000, 239, 230, 222)
                                : const Color.fromARGB(1000, 154, 0, 2),
                            foregroundColor:
                                dark ? Colors.black : Colors.white,
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
                    );
                  },
                ),

                // Register navigation
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    'Don\'t have an account? Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
