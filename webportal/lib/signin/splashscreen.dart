import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/resize.dart';
import '../services/auth_service.dart';
import 'login.dart';
import '../pages/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();
  }

  Future<void> _initializeAndNavigate() async {
    // Initialize Resize values
    await Future.delayed(Duration.zero, () {
      Resize().setValue(context);
    });

    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Check if user is already logged in
    final isLoggedIn = await AuthService.isLoggedIn();

    // Navigate to appropriate page
    if (mounted) {
      if (isLoggedIn) {
        // User is logged in, go to dashboard
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      } else {
        // User is not logged in, go to login page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1f2937),
              Color(0xFF111827),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with animation
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_filled,
                          color: Color(0xFF1f2937),
                          size: 70,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              // App Name
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Text(
                        'KidzView',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              // Tagline
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Text(
                      'Live Streaming for PlaySchools',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 60),
              // Loading indicator
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1200),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

