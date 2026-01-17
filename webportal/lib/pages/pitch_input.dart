import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:math';
import '../utils/resize.dart';
import 'pitch_presentation.dart';

class PitchInputPage extends StatefulWidget {
  const PitchInputPage({super.key});

  @override
  State<PitchInputPage> createState() => _PitchInputPageState();
}

enum InputState { form, loading }

class _PitchInputPageState extends State<PitchInputPage>
    with TickerProviderStateMixin {
  final _schoolNameController = TextEditingController();
  final _numStudentsController = TextEditingController();
  final _passwordController = TextEditingController();
  final Resize resize = Resize();
  
  InputState _currentState = InputState.form;
  bool _obscurePassword = true;
  String? _errorMessage;
  
  // Loading animation
  late AnimationController _loadingController;
  int _loadingTextIndex = 0;
  final List<String> _loadingTexts = [
    'Analyzing school growth potential...',
    'Finding cost-saving opportunities...',
    'Calculating competitive advantage...',
    'Preparing customized solution...',
    'Finalizing your presentation...',
  ];

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    _schoolNameController.dispose();
    _numStudentsController.dispose();
    _passwordController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  void _generatePitch() {
    setState(() => _errorMessage = null);
    
    if (_schoolNameController.text.trim().isEmpty) {
      setState(() => _errorMessage = 'Please enter school name');
      return;
    }

    final numStudents = int.tryParse(_numStudentsController.text.trim());
    if (numStudents == null || numStudents <= 0) {
      setState(() => _errorMessage = 'Please enter valid number of students');
      return;
    }

    if (_passwordController.text != 'Mohit@123') {
      setState(() => _errorMessage = 'Invalid password');
      return;
    }

    // Start loading animation
    setState(() => _currentState = InputState.loading);
    
    // Animate through loading texts
    int textCount = 0;
    Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (textCount < _loadingTexts.length - 1) {
        setState(() => _loadingTextIndex = textCount + 1);
        textCount++;
      } else {
        timer.cancel();
        // Navigate to presentation after animation
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PitchPresentationPage(
                schoolName: _schoolNameController.text.trim(),
                numStudents: numStudents,
              ),
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentState == InputState.loading) {
      return _buildLoadingScreen();
    }
    return _buildFormScreen();
  }

  Widget _buildFormScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECEF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1f2937),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_circle_filled,
                  color: Color(0xFF1f2937),
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'KidzView',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: resize.width * 0.15, vertical: resize.height * 0.04),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(resize.width * 0.012),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(resize.width * 0.012),
              ),
              padding: EdgeInsets.only(
                  left: resize.width * 0.04,
                  right: resize.width * 0.04,
                  top: resize.width * 0.03,
                  bottom: resize.width * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: resize.height * 0.1,
                            height: resize.height * 0.1,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.trending_up,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          SizedBox(height: resize.height * 0.02),
                          Text(
                            'Transform Your School Business',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.heading2,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F1419),
                            ),
                          ),
                          SizedBox(height: resize.height * 0.008),
                          Text(
                            'Get your personalized growth strategy in seconds',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: resize.fontSizeSmall,
                              color: const Color(0xFF667085),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: resize.height * 0.03),

                    // School Name Field
                    Text(
                      'School Name',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.fontSizebase,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F1419),
                      ),
                    ),
                    SizedBox(height: resize.height * 0.01),
                    TextField(
                      controller: _schoolNameController,
                      decoration: InputDecoration(
                        hintText: 'e.g., Little Stars PlaySchool',
                        hintStyle: GoogleFonts.spaceGrotesk(
                          color: const Color(0xFF98A2B3),
                          fontSize: resize.fontSizeSmall,
                        ),
                        prefixIcon: Icon(
                          Icons.school,
                          color: const Color(0xFF667085),
                          size: resize.iconSize,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF9FAFB),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(resize.width * 0.006),
                          borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(resize.width * 0.006),
                          borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(resize.width * 0.006),
                          borderSide: const BorderSide(
                              color: Color(0xFF8B5CF6), width: 2),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: resize.width * 0.01,
                          vertical: resize.height * 0.014,
                        ),
                      ),
                    ),
                    SizedBox(height: resize.height * 0.02),

                    // Number of Students Field
                    Text(
                      'Number of Students',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.fontSizebase,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F1419),
                      ),
                    ),
                    SizedBox(height: resize.height * 0.01),
                    TextField(
                      controller: _numStudentsController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: 'e.g., 60',
                        hintStyle: GoogleFonts.spaceGrotesk(
                          color: const Color(0xFF98A2B3),
                          fontSize: resize.fontSizeSmall,
                        ),
                        prefixIcon: Icon(
                          Icons.people,
                          color: const Color(0xFF667085),
                          size: resize.iconSize,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF9FAFB),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(resize.width * 0.006),
                          borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(resize.width * 0.006),
                          borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(resize.width * 0.006),
                          borderSide: const BorderSide(
                              color: Color(0xFF8B5CF6), width: 2),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: resize.width * 0.01,
                          vertical: resize.height * 0.014,
                        ),
                      ),
                    ),
                    SizedBox(height: resize.height * 0.02),

                    // Password Field
                    Text(
                      'Access Password',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.fontSizebase,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F1419),
                      ),
                    ),
                    SizedBox(height: resize.height * 0.01),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter password',
                        hintStyle: GoogleFonts.spaceGrotesk(
                          color: const Color(0xFF98A2B3),
                          fontSize: resize.fontSizeSmall,
                        ),
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          color: const Color(0xFF667085),
                          size: resize.iconSize,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF667085),
                          ),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF9FAFB),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(resize.width * 0.006),
                          borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(resize.width * 0.006),
                          borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(resize.width * 0.006),
                          borderSide: const BorderSide(
                              color: Color(0xFF8B5CF6), width: 2),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: resize.width * 0.01,
                          vertical: resize.height * 0.014,
                        ),
                      ),
                      onSubmitted: (_) => _generatePitch(),
                    ),
                    
                    // Error message
                    if (_errorMessage != null) ...[
                      SizedBox(height: resize.height * 0.015),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFFCA5A5)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 18),
                            const SizedBox(width: 8),
                            Text(
                              _errorMessage!,
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFFEF4444),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    SizedBox(height: resize.height * 0.025),

                    // Generate Button
                    SizedBox(
                      width: double.infinity,
                      height: resize.height * 0.055,
                      child: ElevatedButton(
                        onPressed: _generatePitch,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B5CF6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(resize.width * 0.006),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Show Me How to Grow My School',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: resize.fontSizebase,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: resize.width * 0.01),
                            const Icon(Icons.auto_awesome, size: 20),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: resize.height * 0.015),

                    // Info Card
                    Container(
                      padding: EdgeInsets.all(resize.width * 0.012),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF0FDF4), Color(0xFFDCFCE7)],
                        ),
                        borderRadius: BorderRadius.circular(resize.width * 0.006),
                        border:
                            Border.all(color: const Color(0xFF86EFAC), width: 2),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            color: Color(0xFF16A34A),
                            size: 22,
                          ),
                          SizedBox(width: resize.width * 0.01),
                          Expanded(
                            child: Text(
                              'Get instant ROI calculation, competitive advantage insights, and complete growth strategy tailored for your school',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: resize.fontSizeSmall * 0.9,
                                color: const Color(0xFF16A34A),
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1224),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated circles
              SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer rotating ring
                    AnimatedBuilder(
                      animation: _loadingController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _loadingController.value * 2 * pi,
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors: [
                                  const Color(0xFF8B5CF6).withOpacity(0),
                                  const Color(0xFF8B5CF6),
                                  const Color(0xFFEC4899),
                                  const Color(0xFF34D399),
                                  const Color(0xFF8B5CF6).withOpacity(0),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Middle ring
                    AnimatedBuilder(
                      animation: _loadingController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: -_loadingController.value * 2 * pi,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
                            ),
                            child: CustomPaint(
                              painter: _ArcPainter(
                                progress: _loadingController.value,
                                color: const Color(0xFFEC4899),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Inner background
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0B1224),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Center icon
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8B5CF6).withOpacity(0.5),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.auto_awesome, color: Colors.white, size: 32),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 56),
              
              // Animated text
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _loadingTexts[_loadingTextIndex],
                  key: ValueKey(_loadingTextIndex),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              
              // Progress dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final isActive = index <= _loadingTextIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: isActive ? 36 : 12,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: isActive 
                        ? const LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)])
                        : null,
                      color: isActive ? null : Colors.white.withOpacity(0.2),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 48),
              
              Text(
                'Preparing your personalized growth strategy',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 17,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter for arc animation
class _ArcPainter extends CustomPainter {
  final double progress;
  final Color color;

  _ArcPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(rect, -pi / 2, pi * 1.5 * progress, false, paint);
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
