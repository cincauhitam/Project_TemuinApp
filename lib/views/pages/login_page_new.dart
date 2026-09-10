import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/views/pages/forgot_password.dart';
import 'package:project_flutter/views/pages/register%20flow/set_up_profile_new.dart';
import 'package:project_flutter/views/pages/register_page.dart';
import 'package:project_flutter/views/pages/application_info.dart';
import 'package:project_flutter/views/widget_tree.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void _handleLogin() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WidgetTree()),
      );

  void _handleGoogleLogin() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WidgetTree()),
      );

  void _handleForgotPassword() => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
      );

  void _handleCreateAccount() => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RegisterPage()),
      );

  void _handleApplicationInfo() => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ApplicationInfo()),
      );

  @override
  Widget build(BuildContext context) {
    const maroon = Color(0xFF9A0002);
    const cream = Color(0xFFEFF0DE);
    const creamSoft = Color(0xFFEFF0DE);

    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 4,
              right: 12,
              child: Text(
                '*dummy version (Under Development)',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: const Color.fromARGB(232, 255, 255, 255)
                      .withValues(alpha: 0.5),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    //Three Dots Option
                    child: GestureDetector(
                      onTap: _handleApplicationInfo,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(0, 255, 255, 255),
                          shape: BoxShape.circle,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            return Container(
                              width: 5,
                              height: 5,
                              margin: EdgeInsets.only(
                                left: index == 0 ? 0 : 2,
                                right: index == 2 ? 0 : 2,
                              ),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(232, 239, 230, 222),
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Image.asset(
                          'assets/images/futsal.png',
                          width: 350,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'FUTSALIN',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.anton(
                            fontSize: 42,
                            letterSpacing: 1.2,
                            color: const Color.fromARGB(232, 239, 230, 222),
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.poppins(
                                color: cream,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: 'Email or Phone',
                                hintStyle: GoogleFonts.poppins(
                                  color: cream.withValues(alpha: 0.7),
                                  fontSize: 14,
                                ),
                                prefixIcon: const Icon(
                                  Icons.person_outline,
                                  color: cream,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: cream,
                                    width: 1.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: cream,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: cream,
                                    width: 1.8,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              style: GoogleFonts.poppins(
                                color: cream,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: 'Password',
                                hintStyle: GoogleFonts.poppins(
                                  color: cream.withValues(alpha: 0.7),
                                  fontSize: 14,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: cream,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: cream,
                                    width: 1.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: cream,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: cream,
                                    width: 1.8,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: false,
                                  onChanged: (_) {},
                                  activeColor: cream,
                                  checkColor: maroon,
                                ),
                                Text(
                                  'Remember Me',
                                  style: GoogleFonts.poppins(
                                    color: cream,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),

                            // LOGIN BUTTON
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: cream,
                                  disabledBackgroundColor: creamSoft,
                                  foregroundColor: maroon,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'LOGIN',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.8,
                                    color: maroon,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            GestureDetector(
                              onTap: _handleForgotPassword,
                              child: Text(
                                'Forgot Password?',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: cream,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Bottom section — must be Positioned, otherwise Stack places it
            // at its default alignment (top-left) instead of anchoring it
            // to the bottom of the screen.
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                height: 160,
                decoration: const BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(28, 20, 28, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleGoogleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: maroon,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Continue with Google',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'or',
                      style: GoogleFonts.poppins(
                        color: maroon,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleCreateAccount,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: maroon,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Create an account',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}