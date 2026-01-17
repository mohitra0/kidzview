import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../demo_portal/demo_persona_page.dart';

class QuotationPage extends StatefulWidget {
  const QuotationPage({super.key});

  @override
  State<QuotationPage> createState() => _QuotationPageState();
}

class _QuotationPageState extends State<QuotationPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  final int _totalSlides = 5;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    // Responsive heights - mobile needs much more height since cards stack vertically
    final slide1Height = isMobile ? screenHeight * 1.3 : screenHeight * 1.1;
    final slide2Height = isMobile ? screenHeight * 2.48 : screenHeight * 1.1;
    final slide3Height = isMobile ? screenHeight * 4.4 : screenHeight * 1.45;
    final slide4Height = isMobile ? screenHeight * 1.3 : screenHeight;
    final slide5Height = screenHeight;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1224),
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                final page =
                    (notification.metrics.pixels / screenHeight).round();
                if (page != _currentPage && page >= 0 && page < _totalSlides) {
                  setState(() => _currentPage = page);
                }
              }
              return false;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                      height: slide1Height, child: _buildSlide1Introduction()),
                  SizedBox(
                      height: slide2Height, child: _buildSlide2CorePackage()),
                  SizedBox(height: slide3Height, child: _buildSlide3FreeERP()),
                  SizedBox(height: slide4Height, child: _buildSlide4Pricing()),
                  SizedBox(height: slide5Height, child: _buildSlide5CTA()),
                ],
              ),
            ),
          ),
          Positioned(top: 24, right: 24, child: _buildCloseButton()),
          Positioned(
              right: 24, top: 0, bottom: 0, child: _buildPageIndicator()),
        ],
      ),
    );
  }

  // ============ SLIDE 1: Quotation for MCP School ============
  Widget _buildSlide1Introduction() {
    return _slideContainer(
      gradient: const [Color(0xFF0B1224), Color(0xFF1E1B4B)],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final isWide = w > 900;

          return Container(
            width: w,
            padding: EdgeInsets.only(
                left: isWide ? 60 : 30,
                right: isWide ? 60 : 30,
                top: 60,
                bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // School Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF60A5FA), Color(0xFF3B82F6)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF60A5FA).withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.school, color: Colors.white, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        'QUOTATION FOR',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isWide ? h * 0.04 : 20),

                // School Names
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFF60A5FA),
                      Color(0xFFF472B6),
                      Color(0xFF34D399)
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'Modern Child Public School',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: isWide ? 56 : 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFFF472B6),
                      Color(0xFF60A5FA),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    '& MCPS Junior School',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: isWide ? 48 : 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
                SizedBox(height: isWide ? h * 0.02 : 12),

                // School Info
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Color(0xFF60A5FA), size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Punjabi Basti & Ext. 2C, Najafgarh Road, Nangloi, Delhi - 110041',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.school_outlined,
                              color: Color(0xFFF472B6), size: 20),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'CBSE Affiliated • Nursery to Class 12',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isWide ? h * 0.03 : 16),

                // Value Proposition
                Text(
                  'Complete Digital Transformation Package',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: isWide ? 24 : 18,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: isWide ? h * 0.02 : 12),

                // Key Benefits
                Row(
                  children: [
                    Expanded(
                      child: _quotationBenefitCard(
                        Icons.videocam,
                        'Live Streaming',
                        'Parent Peace of Mind',
                        const Color(0xFF60A5FA),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _quotationBenefitCard(
                        Icons.phone_android,
                        'Mobile Apps',
                        'iOS & Android',
                        const Color(0xFFF472B6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _quotationBenefitCard(
                        Icons.dashboard,
                        'Web Portal',
                        'Multi-Persona Access',
                        const Color(0xFF34D399),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _quotationBenefitCard(
                        Icons.card_giftcard,
                        'FREE ERP',
                        '14+ Features Included',
                        const Color(0xFFFBBF24),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Live Streaming ROI Banner
                Container(
                  padding: EdgeInsets.all(isWide ? 24 : 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF60A5FA).withOpacity(0.2),
                        const Color(0xFF3B82F6).withOpacity(0.15),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF60A5FA).withOpacity(0.4),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF60A5FA).withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: isWide
                      ? Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF60A5FA),
                                    Color(0xFF3B82F6)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(Icons.trending_up,
                                  color: Colors.white, size: 32),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ROI Impact',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 24,
                                    runSpacing: 8,
                                    children: [
                                      _roiBenefit(
                                          '6-30% Conversion Rate Boost during Enquiry'),
                                      _roiBenefit('Revenue via New Admissions'),
                                      _roiBenefit(
                                          '2x Fees Potential of what we are charging'),
                                      _roiBenefit(
                                          'Exclusive to your school - Makes you distinct & builds trust'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF60A5FA),
                                        Color(0xFF3B82F6)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.trending_up,
                                      color: Colors.white, size: 24),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'ROI Impact',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _roiBenefit(
                                    '6-30% Conversion Rate Boost during Enquiry'),
                                const SizedBox(height: 6),
                                _roiBenefit('Revenue via New Admissions'),
                                const SizedBox(height: 6),
                                _roiBenefit(
                                    '2x Fees Potential of what we are charging'),
                                const SizedBox(height: 6),
                                _roiBenefit(
                                    'Exclusive to your school - Makes you distinct & builds trust'),
                              ],
                            ),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _roiBenefit(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Color(0xFF60A5FA),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // Special card for Live Streaming with bullet points
  Widget _liveStreamingBenefitCard(
      IconData icon, String title, List<String> benefits, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.15),
            color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT: Icon and Title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 180,
                child: Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          Spacer(), // RIGHT: Benefits List
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: benefits
                  .map((benefit) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 11,
                                color: color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                benefit,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 11,
                                  color: Colors.white70,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quotationBenefitCard(
      IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.15),
            color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }

  // ============ SLIDE 2: Core Package ============
  Widget _buildSlide2CorePackage() {
    return _slideContainer(
      gradient: const [Color(0xFF312E81), Color(0xFF1E3A8A)],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final isWide = w > 900;
          final cardW = isWide
              ? ((w - 120 - 48) / 3).clamp(250.0, 400.0)
              : (w - 60).clamp(250.0, double.infinity);

          return Container(
            width: w,
            padding: EdgeInsets.only(
                left: isWide ? 60 : 30,
                right: isWide ? 60 : 30,
                top: 60,
                bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Premium Features',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: isWide ? 56 : 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF60A5FA), Color(0xFF34D399)],
                  ).createShader(bounds),
                  child: Text(
                    'in Detail',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: isWide ? 56 : 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    _detailedCorePackageCard(
                      Icons.camera,
                      'Live Streaming for PreSchools',
                      [
                        '480P HD Quality Streaming',
                        'Up to 6 Cameras Maximum',
                        '1 Camera per 12 Students',
                        'Teacher Controls: Pause/Resume by Time',
                        'Custom Schedules (e.g., 8-9 AM, 12-1 PM)',
                        'Class-based Access Control',
                        'Add/Remove Individual Students',
                        'Parent Watch Time Limits (5-20 mins/day)',
                        'DVR with 1TB Local Backup',
                        'End-to-End Encryption',
                        'Privacy-First: Only Name & DOB Required',
                      ],
                      const Color(0xFF60A5FA),
                      cardW,
                    ),
                    _detailedCorePackageCard(
                      Icons.laptop,
                      'Multi-Persona Web Portal',
                      [
                        'Parents Dashboard & View',
                        'Teachers Dashboard & Tools',
                        'HR Management Dashboard',
                        'Finance Manager Dashboard',
                        'Admin Super Dashboard (All Access)',
                        'Role-Based Permissions',
                        'Custom School Theme & Branding',
                        'Live Streaming Management',
                        'Student & Staff Analytics',
                        'Bulk Notification System',
                        'Report Generation & Export',
                      ],
                      const Color(0xFFF472B6),
                      cardW,
                    ),
                    _detailedCorePackageCard(
                      Icons.phone_iphone,
                      'Native Mobile App (iOS & Android)',
                      [
                        'Fully Native Apps (Not Web-based)',
                        'Complete Child Activity Tracking',
                        'Watch Live Streaming',
                        'Smart In-App Notifications',
                        'Push & Tray Notifications',
                        'Parent Engagement Analytics',
                        'Custom Theme, Logo & Branding',
                        'Attendance Updates',
                        'Fee Payment Reminders',
                        'Event Calendar Sync',
                        'Secure Parent Login',
                      ],
                      const Color(0xFF34D399),
                      cardW,
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Container(
                  padding: EdgeInsets.all(isWide ? 28 : 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(isWide ? 16 : 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBBF24).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(Icons.stars,
                            color: const Color(0xFFFBBF24),
                            size: isWide ? 32 : 24),
                      ),
                      SizedBox(width: isWide ? 20 : 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enterprise-Grade Infrastructure',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: isWide ? 20 : 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Built for scale, security, and performance. All features work seamlessly together with real-time synchronization.',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: isWide ? 14 : 12,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============ SLIDE 3: Free ERP System ============
  Widget _buildSlide3FreeERP() {
    return _slideContainer(
      gradient: const [Color(0xFF042F2E), Color(0xFF064E3B)],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final isWide = w > 900;
          final cardW = isWide
              ? ((w - 120 - 60) / 4).clamp(180.0, 280.0)
              : (w - 60).clamp(200.0, double.infinity);

          return Container(
            width: w,
            padding: EdgeInsets.only(
                left: isWide ? 60 : 30,
                right: isWide ? 60 : 30,
                top: 60,
                bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF34D399)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B981).withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.card_giftcard,
                              color: Colors.white, size: 28),
                          const SizedBox(width: 12),
                          Text(
                            'ABSOLUTELY FREE',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Complete School',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: isWide ? 56 : 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF10B981), Color(0xFF34D399)],
                  ).createShader(bounds),
                  child: Text(
                    'ERP System',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: isWide ? 56 : 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _erpFeatureCard(
                      Icons.calendar_today,
                      'Attendance Management',
                      'Excel import, Manual updates, RFID integration, Automated reports',
                      const Color(0xFF8B5CF6),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.table_chart,
                      'Time Table Generator',
                      'Auto-generate schedules, Class planning, Teacher allocation',
                      const Color(0xFF3B82F6),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.person,
                      'Student Complete Profile',
                      '360° records, Academic history, Health records, Activity logs',
                      const Color(0xFFEC4899),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.people,
                      'HR & Staff Management',
                      'Teachers, Staff database, Salary, Leave tracking, Reviews',
                      const Color(0xFFF97316),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.badge,
                      'Document Auto-Generator',
                      'ID Cards, Certificates, Report Cards, Bulk generation',
                      const Color(0xFF10B981),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.event,
                      'Calendar & Events',
                      'School events, Holidays, Exam schedules, Automated reminders',
                      const Color(0xFF14B8A6),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.currency_rupee,
                      'Fees Management',
                      'Bulk updates, Online payments, Receipts, Pending alerts',
                      const Color(0xFFFBBF24),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.analytics,
                      'Analytics Dashboard',
                      'Teacher metrics, Student analytics, Attendance trends',
                      const Color(0xFF6366F1),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.folder,
                      'Document Management',
                      'Secure storage, Share with parents, Digital signatures',
                      const Color(0xFFEF4444),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.login,
                      'Admission Workflow',
                      'Online enquiry, Processing, Onboarding, Exit management',
                      const Color(0xFF06B6D4),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.palette,
                      'School Branding App',
                      'Custom colors, Your logo, Branded notifications, White-label',
                      const Color(0xFF8B5CF6),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.chat,
                      'Multi-Channel Communication',
                      'Email, WhatsApp, SMS alerts, Bulk notifications',
                      const Color(0xFF10B981),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.smart_toy,
                      'AI Payment Reminders',
                      'Smart scheduling, Automated follow-ups, Multi-language',
                      const Color(0xFFF59E0B),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.menu_book,
                      'Library Management',
                      'Book inventory, Issue/Return tracking, Reading history',
                      const Color(0xFFD946EF),
                      cardW,
                    ),
                    _erpFeatureCard(
                      Icons.inventory,
                      'Inventory & Assets',
                      'Stock management, Asset tracking, Purchase orders',
                      const Color(0xFF84CC16),
                      cardW,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFF10B981).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'And Much More...',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'We continuously add new features based on your school\'s needs. Custom modules available on request!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============ SLIDE 4: Pricing ============
  Widget _buildSlide4Pricing() {
    return _slideContainer(
      gradient: const [Color(0xFF1E1B4B), Color(0xFF4C1D95)],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final isWide = w > 900;

          return Container(
            width: w,
            padding: EdgeInsets.symmetric(
                horizontal: isWide ? 60 : 30, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                Text(
                  'Simple, Transparent',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: isWide ? 56 : 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                  ).createShader(bounds),
                  child: Text(
                    'Pricing',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: isWide ? 56 : 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.05),

                // Main Content - Side by Side
                if (isWide)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT: Pricing Card
                      Container(
                        width: 400,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFBBF24).withOpacity(0.4),
                              blurRadius: 40,
                              offset: const Offset(0, 16),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                'ALL-INCLUSIVE MONTHLY',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₹',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '15,000',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 72,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    '/mo',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'GST Included • No Hidden Charges',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),

                      // RIGHT: Terms and Zero Risk
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Contract Terms Row
                          Row(
                            children: [
                              _pricingTermCard(
                                Icons.calendar_month,
                                '3 Years',
                                'Lock-in',
                                const Color(0xFF60A5FA),
                                150,
                              ),
                              const SizedBox(width: 16),
                              _pricingTermCard(
                                Icons.schedule,
                                'Pay After',
                                '6 Months',
                                const Color(0xFF34D399),
                                150,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Zero Risk Card
                          Container(
                            width: 316,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF10B981).withOpacity(0.2),
                                  const Color(0xFF34D399).withOpacity(0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF10B981).withOpacity(0.4),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10B981)
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.verified_user,
                                          color: Color(0xFF10B981), size: 24),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'ZERO RISK',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF10B981),
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No Upfront Cost\nNo Setup Fees\nNo Installation Charges',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  // Mobile Layout - Stack Vertically
                  Column(
                    children: [
                      // Pricing Card
                      Container(
                        constraints: BoxConstraints(maxWidth: w - 60),
                        padding: const EdgeInsets.only(top: 32, bottom: 32),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFBBF24).withOpacity(0.4),
                              blurRadius: 40,
                              offset: const Offset(0, 16),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                'ALL-INCLUSIVE MONTHLY',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₹',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '15,000',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 72,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    '/mo',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'GST Included • No Hidden Charges',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _pricingTermCard(
                            Icons.calendar_month,
                            '3 Years',
                            'Lock-in',
                            const Color(0xFF60A5FA),
                            (w - 92) / 2,
                          ),
                          const SizedBox(width: 12),
                          _pricingTermCard(
                            Icons.schedule,
                            'Pay After',
                            '6 Months',
                            const Color(0xFF34D399),
                            (w - 92) / 2,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        constraints: BoxConstraints(maxWidth: w - 60),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF10B981).withOpacity(0.2),
                              const Color(0xFF34D399).withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF10B981).withOpacity(0.4),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.verified_user,
                                    color: Color(0xFF10B981), size: 24),
                                const SizedBox(width: 10),
                                Text(
                                  'ZERO RISK',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF10B981),
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'No Upfront Cost • No Setup Fees\nNo Installation Charges',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: h * 0.04),

                // Important Note about Communication Services
                Container(
                  constraints: BoxConstraints(maxWidth: isWide ? 550 : w - 60),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: const Color(0xFFF59E0B).withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.info_outline,
                            color: Color(0xFFF59E0B), size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Communication Services',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'SMS, WhatsApp, iOS Subscription & Email require separate payment to providers',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 12,
                                color: Colors.white70,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _pricingTermCard(
      IconData icon, String title, String subtitle, Color color, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.15),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.4), width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pricingInclude(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 15,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============ SLIDE 5: CTA ============
  Widget _buildSlide5CTA() {
    return _slideContainer(
      gradient: const [Color(0xFF0B1224), Color(0xFF1E3A8A)],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final isWide = w > 900;

          return Container(
            width: w,
            padding: EdgeInsets.symmetric(
                horizontal: isWide ? 60 : 30, vertical: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ready to Transform',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: isWide ? 64 : 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF60A5FA), Color(0xFFF472B6)],
                  ).createShader(bounds),
                  child: Text(
                    'Your School?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: isWide ? 64 : 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.04),
                Image.asset(
                  'assets/images/EY_Logo.png',
                  height: h * 0.15,
                ),
                SizedBox(height: h * 0.04),
                Text(
                  'Built By Senior EY Tech Consultants',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 20,
                    color: Colors.white60,
                  ),
                ),
                SizedBox(height: h * 0.06),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    _ctaButton(
                      'View Demo Portal',
                      Icons.play_circle_fill,
                      const Color(0xFF60A5FA),
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DemoPersonaPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: h * 0.06),
                Wrap(
                  spacing: 32,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _trustIndicator(
                        Icons.check_circle, '3 Year Lock-in Period'),
                    _trustIndicator(
                        Icons.check_circle, 'No cost upto 6 Months'),
                    _trustIndicator(Icons.check_circle,
                        '85% lower cost than other schools'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper Widgets
  Widget _slideContainer({
    required List<Color> gradient,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.spaceGrotesk(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: const Icon(Icons.close, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_totalSlides, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            width: 8,
            height: _currentPage == index ? 24 : 8,
            decoration: BoxDecoration(
              color: _currentPage == index
                  ? Colors.white
                  : Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }

  Widget _scrollHint() {
    return Column(
      children: [
        Icon(Icons.keyboard_arrow_down,
            color: Colors.white.withOpacity(0.5), size: 32),
        Text(
          'Scroll to explore',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  Widget _corePackageCard(
    IconData icon,
    String title,
    List<String> features,
    Color color,
    double width,
  ) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: color, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        feature,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _detailedCorePackageCard(
    IconData icon,
    String title,
    List<String> features,
    Color color,
    double width,
  ) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.08),
            color.withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.4), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.5), color.withOpacity(0.1)],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.check, color: color, size: 14),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 13,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _erpFeatureCard(
    IconData icon,
    String title,
    String description,
    Color color,
    double width,
  ) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              color: Colors.white60,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ctaButton(
      String text, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trustIndicator(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFF10B981), size: 20),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
