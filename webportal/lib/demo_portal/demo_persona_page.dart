import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'teacher/teacher_dashboard.dart';
import 'admin/admin_dashboard.dart';
import 'finance/finance_dashboard.dart';
import 'hr/hr_dashboard.dart';
import 'demo_login_page.dart';

class DemoPersonaPage extends StatefulWidget {
  const DemoPersonaPage({super.key});

  @override
  State<DemoPersonaPage> createState() => _DemoPersonaPageState();
}

class _DemoPersonaPageState extends State<DemoPersonaPage>
    with SingleTickerProviderStateMixin {
  String? _selectedPersona;
  late AnimationController _hoverController;

  final List<Map<String, dynamic>> _personas = [
    {
      'id': 'teacher',
      'title': 'Teacher',
      'subtitle': 'Class & Live Stream Management',
      'icon': Icons.school,
      'color': const Color(0xFF3B82F6),
      'gradient': [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)],
      'features': [
        'Manage Classes',
        'Control Live Streaming',
        'Student Attendance'
      ],
    },
    {
      'id': 'admin',
      'title': 'Admin',
      'subtitle': 'Full Portal Access',
      'icon': Icons.admin_panel_settings,
      'color': const Color(0xFF8B5CF6),
      'gradient': [const Color(0xFF8B5CF6), const Color(0xFF6D28D9)],
      'features': [
        'Complete Overview',
        'User Management',
        'Analytics Dashboard'
      ],
    },
    {
      'id': 'finance',
      'title': 'Finance Manager',
      'subtitle': 'Fee & Payment Management',
      'icon': Icons.account_balance_wallet,
      'color': const Color(0xFF10B981),
      'gradient': [const Color(0xFF10B981), const Color(0xFF059669)],
      'features': ['Fee Collection', 'Payment Reports', 'Invoice Management'],
    },
    {
      'id': 'hr',
      'title': 'HR Manager',
      'subtitle': 'Staff & Employee Management',
      'icon': Icons.people_alt,
      'color': const Color(0xFFF59E0B),
      'gradient': [const Color(0xFFF59E0B), const Color(0xFFD97706)],
      'features': ['Staff Directory', 'Leave Management', 'Payroll Overview'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isWide = screenWidth > 900;
    final isMobile = screenWidth < 768;

    // Show desktop recommendation on mobile devices
    if (isMobile) {
      return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B5CF6).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.desktop_windows,
                      size: 64, color: Color(0xFF8B5CF6)),
                ),
                const SizedBox(height: 32),
                Text(
                  'Please use Desktop',
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'for better experience',
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: const Color(0xFFF59E0B).withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.info_outline,
                          color: Color(0xFFF59E0B), size: 20),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'This portal is optimized for desktop screens',
                          style: GoogleFonts.spaceGrotesk(
                              fontSize: 13, color: const Color(0xFF92400E)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          // Subtle background pattern
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPatternPainter(),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? screenWidth * 0.08 : 24,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    // Header Section
                    _buildHeader(isWide),
                    SizedBox(height: 20),

                    // School Badge
                    _buildSchoolBadge(),
                    const SizedBox(height: 16),

                    // Persona Grid
                    isWide
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _personas
                                .map((persona) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: _buildPersonaCard(persona, isWide),
                                    ))
                                .toList(),
                          )
                        : Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: _personas
                                .map((persona) =>
                                    _buildPersonaCard(persona, isWide))
                                .toList(),
                          ),
                    const SizedBox(height: 40),

                    // Login Button
                    AnimatedOpacity(
                      opacity: _selectedPersona != null ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: _selectedPersona != null
                          ? _buildLoginButton()
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 40),

                    // Footer
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),

          // Close button
          Positioned(
            top: 24,
            right: 24,
            child: _buildCloseButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isWide) {
    return Column(
      children: [
        // Logo Container
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1F2937).withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1F2937), Color(0xFF374151)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.business,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Title
        Text(
          'MCP Web Portal',
          textAlign: TextAlign.center,
          style: GoogleFonts.spaceGrotesk(
            fontSize: isWide ? 42 : 32,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1F2937),
            letterSpacing: -1,
          ),
        ),

        // Subtitle
        Text(
          'Modern Child Public School & MCPS Junior',
          textAlign: TextAlign.center,
          style: GoogleFonts.spaceGrotesk(
            fontSize: isWide ? 16 : 14,
            color: const Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSchoolBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937).withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                const Icon(Icons.verified, color: Color(0xFF10B981), size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            'Enterprise School Management System',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonaCard(Map<String, dynamic> persona, bool isWide) {
    final isSelected = _selectedPersona == persona['id'];
    final cardWidth =
        isWide ? 230.0 : (MediaQuery.of(context).size.width - 72) / 2;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPersona = persona['id'];
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: cardWidth,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? persona['color'] as Color
                : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: (persona['color'] as Color).withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(colors: persona['gradient'] as List<Color>)
                    : null,
                color: isSelected
                    ? null
                    : (persona['color'] as Color).withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                persona['icon'] as IconData,
                color: isSelected ? Colors.white : persona['color'] as Color,
                size: 32,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              persona['title'] as String,
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 6),

            // Subtitle
            Text(
              persona['subtitle'] as String,
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 16),

            // Divider
            Container(
              height: 1,
              color: const Color(0xFFE5E7EB),
            ),
            const SizedBox(height: 16),

            // Features
            ...((persona['features'] as List<String>)
                .take(3)
                .map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: persona['color'] as Color,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              feature,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 12,
                                color: const Color(0xFF4B5563),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))),

            const SizedBox(height: 8),

            // Selection indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(colors: persona['gradient'] as List<Color>)
                    : null,
                color: isSelected ? null : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isSelected ? Icons.check_circle : Icons.radio_button_off,
                    color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isSelected ? 'Selected' : 'Select Role',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color:
                          isSelected ? Colors.white : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    final selectedInfo = _personas.firstWhere(
      (p) => p['id'] == _selectedPersona,
      orElse: () => _personas[0],
    );

    return GestureDetector(
      onTap: () {
        _navigateToDashboard();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: selectedInfo['gradient'] as List<Color>,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: (selectedInfo['color'] as Color).withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selectedInfo['icon'] as IconData,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              'Enter as ${selectedInfo['title']}',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDashboard() {
    final persona = _personas.firstWhere((p) => p['id'] == _selectedPersona);
    Widget destination;

    if (_selectedPersona == 'teacher') {
      destination = const TeacherDashboard();
    } else if (_selectedPersona == 'admin') {
      destination = const AdminDashboard();
    } else if (_selectedPersona == 'finance') {
      destination = const FinanceDashboard();
    } else if (_selectedPersona == 'hr') {
      destination = const HRDashboard();
    } else {
      // Coming soon for other personas
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${persona['title']} Dashboard coming soon...',
              style: GoogleFonts.spaceGrotesk()),
          backgroundColor: persona['color'] as Color,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DemoLoginPage(
          personaTitle: persona['title'] as String,
          personaColor: persona['color'] as Color,
          gradient: persona['gradient'] as List<Color>,
          icon: persona['icon'] as IconData,
          destination: destination,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.info_outline,
                color: const Color(0xFF6B7280),
                size: 18,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  'Demo portal with sample data for demonstration purposes',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          '© 2026 Modern Child Public School',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 12,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Widget _buildCloseButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.close,
          color: Color(0xFF374151),
          size: 22,
        ),
      ),
    );
  }
}

// Subtle grid pattern painter for professional background
class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE5E7EB).withOpacity(0.5)
      ..strokeWidth = 1;

    const spacing = 40.0;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
