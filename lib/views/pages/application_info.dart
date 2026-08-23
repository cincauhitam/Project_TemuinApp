import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_flutter/views/pages/login_page_new.dart';

class ApplicationInfo extends StatelessWidget {
  const ApplicationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    const maroon = Color.fromARGB(255, 154, 0, 2);
    const cream = Color.fromARGB(255, 239, 230, 222);

    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
              child: Column(
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: cream,
                        size: 28,
                      ),
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login())),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // App Logo / Icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: cream.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'assets/images/futsal.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // App Title
                  Text(
                    'FUTSALIN',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.anton(
                      fontSize: 48,
                      letterSpacing: 1.5,
                      color: cream,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Futsalin is a sport and social app that allow users to begin their sport activity with others',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: cream.withValues(alpha: 0.8),
                      ),
                    
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Version Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Under Development Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      color: cream.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: cream.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.construction_rounded,
                          size: 48,
                          color: cream,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Under Development',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: cream,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Currently working on this app to bring you the best experience.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: cream.withValues(alpha: 0.7),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Footer
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
