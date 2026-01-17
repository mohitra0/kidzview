import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class PitchPresentationPage extends StatefulWidget {
  final String schoolName;
  final int numStudents;

  const PitchPresentationPage({
    super.key,
    required this.schoolName,
    required this.numStudents,
  });

  @override
  State<PitchPresentationPage> createState() => _PitchPresentationPageState();
}

class _PitchPresentationPageState extends State<PitchPresentationPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  late AnimationController _pulseController;

  int get numCameras => (widget.numStudents / 12).ceil();
  int get pricePerStudent => (15000 / widget.numStudents).ceil();

  final int _totalSlides = 7;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
                  SizedBox(height: screenHeight, child: _buildSlide1()),
                  SizedBox(height: screenHeight, child: _buildSlide2()),
                  Stack(
                    children: [
                      SizedBox(height: screenHeight, child: _buildSlide3()),
                      Positioned.fill(
                        top: 20,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.35,
                              bottom: 10),
                          alignment: Alignment.topLeft,
                          child: Lottie.asset(
                            "assets/lottie/shake.json",
                            height: MediaQuery.of(context).size.height * 0.4,
                            fit: BoxFit.contain,
                            repeat: true,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFFBBF24).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Icon(Icons.priority_high_rounded,
                                      size: 120,
                                      color: const Color(0xFFFBBF24)
                                          .withOpacity(0.3)),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                      height: screenHeight,
                      child: _buildSlide4PricingAndProvide()),
                  Stack(
                    children: [
                      SizedBox(
                          height: screenHeight * 1.1,
                          child: _buildSlide7Security()),
                      Positioned.fill(
                        top: -90,
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Lottie.asset(
                            "assets/lottie/Camera.json",
                            height: MediaQuery.of(context).size.height * 0.4,
                            fit: BoxFit.contain,
                            repeat: true,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFFBBF24).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Icon(Icons.priority_high_rounded,
                                      size: 120,
                                      color: const Color(0xFFFBBF24)
                                          .withOpacity(0.3)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight, child: _buildSlide5Risk()),
                  SizedBox(height: screenHeight, child: _buildSlide6Deal()),
                ],
              ),
            ),
          ),
          Positioned(top: 24, right: 24, child: _buildCloseButton()),
          Positioned(
              right: 24, top: 0, bottom: 0, child: _buildPageIndicator()),
          // Positioned(bottom: 32, left: 0, right: 0, child: _buildNavigation()),
        ],
      ),
    );
  }

  // ============ SLIDE 1: What is KIDZVIEW ============
  Widget _buildSlide1() {
    return _slideContainer(
      gradient: const [Color(0xFF0B1224), Color(0xFF1E1B4B)],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final isWide = w > 900;
          final cardW = isWide ? (w - 120) / 2 : w - 60;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isWide ? 60 : 30, vertical: 60),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Lottie.asset(
                    "assets/lottie/School.json",
                    height: h * 0.6,
                    fit: BoxFit.contain,
                    repeat: true,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: h * 0.5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBBF24).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Icon(Icons.priority_high_rounded,
                              size: 120,
                              color: const Color(0xFFFBBF24).withOpacity(0.3)),
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _badge('Introducing', const Color(0xFF60A5FA)),
                    SizedBox(height: h * 0.04),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFF60A5FA),
                          Color(0xFFF472B6),
                          Color(0xFF34D399)
                        ],
                      ).createShader(bounds),
                      child: Text(
                        'What is KIDZVIEW?',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: isWide ? 72 : 44,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.025),
                    Text(
                      'PREMIUM digital platform providing seamless interaction between parents and school',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: isWide ? 28 : 20,
                        color: Colors.white.withOpacity(0.75),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: h * 0.065),
                    Row(
                      children: [
                        Column(
                          children: [
                            _featureCard(
                                Icons.live_tv_rounded,
                                'Live Streaming',
                                'Real-time CCTV access for parents & administration',
                                const Color(0xFF60A5FA),
                                cardW),
                            SizedBox(height: h * 0.045),
                            _featureCard(
                                Icons.money_off_rounded,
                                'Zero Capex Model',
                                'We deploy & maintain—school pays monthly',
                                const Color(0xFF34D399),
                                cardW),
                          ],
                        ),
                        SizedBox(width: h * 0.045),
                        Column(
                          children: [
                            _featureCard(
                                Icons.school_rounded,
                                'School-Level Deployment',
                                'Entire facility covered, not optional add-on',
                                const Color(0xFFF472B6),
                                cardW),
                            SizedBox(height: h * 0.045),
                            _featureCard(
                                Icons.verified_user_rounded,
                                'Regulatory Compliant',
                                'DPDP Act & data privacy standards built-in',
                                const Color(0xFFFBBF24),
                                cardW),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    _scrollHint(),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============ SLIDE 2: Why Preschools Need This (with Lottie) ============
  Widget _buildSlide2() {
    return _slideContainer(
      gradient: const [Color(0xFF1E1B4B), Color(0xFF312E81)],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final isWide = w > 900;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isWide ? 60 : 30, vertical: 60),
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left side - content
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _badge('Perfect Timing', const Color(0xFFFBBF24)),
                            const SizedBox(height: 24),
                            Text(
                              'Why Premium Schools Need',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 56,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  height: 1.1),
                            ),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                  colors: [
                                    Color(0xFFFBBF24),
                                    Color(0xFFF97316)
                                  ]).createShader(bounds),
                              child: Text('This NOW',
                                  style: GoogleFonts.spaceGrotesk(
                                      fontSize: 56,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      height: 1.1)),
                            ),
                            const SizedBox(height: 40),
                            _bulletLarge(
                                Icons.favorite_rounded,
                                'Parents Want Peace of Mind',
                                'Give parents the gift of staying connected to their child throughout the day',
                                const Color(0xFF8B5CF6)),
                            const SizedBox(height: 20),
                            _bulletLarge(
                                Icons.auto_awesome_rounded,
                                'Get Tomorrow\'s Luxury Today',
                                'Offer a feature now that will be standard in every school after 10 years',
                                const Color(0xFFEC4899)),
                            const SizedBox(height: 20),
                            _bulletLarge(
                                Icons.stars_rounded,
                                'Stand Out as Premium',
                                'This feature completely distinguishes you from other schools in the area',
                                const Color(0xFFF97316)),
                            const SizedBox(height: 20),
                            _bulletLarge(
                                Icons.verified_rounded,
                                'Join Leading Schools',
                                'IKidz (120+ centers), Footprints (200+ centers), Petals (35+ centers) already trust this',
                                const Color(0xFF06B6D4)),
                          ],
                        ),
                      ),
                      // Right side - Lottie
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Lottie.asset(
                            "assets/lottie/two-people-thinking.json",
                            height: h * 0.6,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: h * 0.5,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFFBBF24).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Icon(Icons.priority_high_rounded,
                                      size: 120,
                                      color: const Color(0xFFFBBF24)
                                          .withOpacity(0.3)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _badge('Perfect Timing', const Color(0xFFFBBF24)),
                      const SizedBox(height: 20),
                      Text('Why Premium Schools Need',
                          style: GoogleFonts.spaceGrotesk(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFFFBBF24), Color(0xFFF97316)])
                            .createShader(bounds),
                        child: Text('This NOW',
                            style: GoogleFonts.spaceGrotesk(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: Colors.white)),
                      ),
                      const SizedBox(height: 28),
                      _bulletLarge(
                          Icons.favorite_rounded,
                          'Parents Want Peace of Mind',
                          'Give parents connection to their child',
                          const Color(0xFF8B5CF6)),
                      const SizedBox(height: 18),
                      _bulletLarge(
                          Icons.auto_awesome_rounded,
                          'Get Tomorrow\'s Luxury Today',
                          'Feature that will be standard in 10 years',
                          const Color(0xFFEC4899)),
                      const SizedBox(height: 18),
                      _bulletLarge(
                          Icons.stars_rounded,
                          'Stand Out as Premium',
                          'Distinguish from other schools',
                          const Color(0xFFF97316)),
                      const SizedBox(height: 18),
                      _bulletLarge(
                          Icons.verified_rounded,
                          'Join Leading Schools',
                          'IKidz, Footprints, Petals already use this',
                          const Color(0xFF06B6D4)),
                    ],
                  ),
          );
        },
      ),
    );
  }

  // ============ SLIDE 3: Why Partner ============
  Widget _buildSlide3() {
    return _slideContainer(
      gradient: const [Color(0xFF042F2E), Color(0xFF0F3D3C)],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final isWide = w > 900;
          final cardW = isWide ? (w - 140) / 2 : w - 60;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isWide ? 60 : 30, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _badge('Partnership Benefits', const Color(0xFF10B981)),
                const SizedBox(height: 24),
                Text('Benefits to School',
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: isWide ? 64 : 40,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1)),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF34D399)])
                      .createShader(bounds),
                  child: Text('BY KIDZVIEW?',
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: isWide ? 64 : 40,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.1)),
                ),
                const Spacer(),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _benefitCard(
                        Icons.monetization_on_rounded,
                        'Multiple Revenue Streams',
                        'Generate income from new admissions, add-on fees, and higher conversion rates during enquiries',
                        const Color(0xFF10B981),
                        cardW),
                    _benefitCard(
                        Icons.workspace_premium_rounded,
                        'Exclusive Area Positioning',
                        'Build premium reputation with area exclusivity—we partner with only you in this area (First-time tag!)',
                        const Color(0xFF8B5CF6),
                        cardW),
                    _benefitCard(
                        Icons.campaign_rounded,
                        'Powerful Marketing Asset',
                        'Stand out in school tours, website, and brochures with this cutting-edge parent feature',
                        const Color(0xFFFBBF24),
                        cardW),
                    _benefitCard(
                        Icons.security_rounded,
                        'Zero Cost, Zero Risk',
                        'No upfront hardware/software fees—first payment only after 6 months. Try risk-free!',
                        const Color(0xFFEC4899),
                        cardW),
                  ],
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============ SLIDE 4: Pricing + What We Provide (Full Content) ============
  Widget _buildSlide4PricingAndProvide() {
    return _slideContainer(
      gradient: const [Color(0xFF1E1B4B), Color(0xFF4C1D95)],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final isWide = w > 900;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isWide ? 60 : 30, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Simple price comparison banner
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFBBF24).withOpacity(0.15),
                        const Color(0xFFF59E0B).withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFFBBF24).withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Other Schools Charge: ',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: isWide ? 18 : 16,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        '₹1,000',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: isWide ? 48 : 44,
                          fontWeight: FontWeight.w800,
                          color: Colors.red.shade300,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: const Color(0xFFFBBF24),
                          size: isWide ? 32 : 28,
                        ),
                      ),
                      Text(
                        'You Pay: ',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: isWide ? 18 : 16,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        '₹$pricePerStudent',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: isWide ? 32 : 28,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF34D399),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF34D399).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${((1000 - pricePerStudent) / 1000 * 100).round()}% LESS',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: isWide ? 14 : 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF34D399),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Side by side on wide screens
                if (isWide)
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // LEFT: Price card
                        SizedBox(
                          width: 400,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _badge('Customized for ${widget.schoolName}',
                                  const Color(0xFFA855F7)),
                              const SizedBox(height: 20),
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(colors: [
                                  Color(0xFFFBBF24),
                                  Color(0xFFF59E0B)
                                ]).createShader(bounds),
                                child: Text('Your Pricing',
                                    style: GoogleFonts.spaceGrotesk(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white)),
                              ),
                              Text('Based on ${widget.numStudents} students',
                                  style: GoogleFonts.spaceGrotesk(
                                      fontSize: 18, color: Colors.white60)),
                              const SizedBox(height: 24),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 32, horizontal: 28),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color(0xFFFBBF24),
                                    Color(0xFFF59E0B)
                                  ]),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xFFFBBF24)
                                            .withOpacity(0.35),
                                        blurRadius: 40,
                                        offset: const Offset(0, 16))
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white24,
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Text(
                                          '${widget.numStudents} STUDENTS',
                                          style: GoogleFonts.spaceGrotesk(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white)),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('₹',
                                            style: GoogleFonts.spaceGrotesk(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white)),
                                        Text('$pricePerStudent',
                                            style: GoogleFonts.spaceGrotesk(
                                                fontSize: 64,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,
                                                height: 1)),
                                      ],
                                    ),
                                    Text('per student / month',
                                        style: GoogleFonts.spaceGrotesk(
                                            fontSize: 16,
                                            color:
                                                Colors.white.withOpacity(0.9))),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        const SizedBox(width: 40),
                        // RIGHT: What's Included
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("What's Included",
                                  style: GoogleFonts.spaceGrotesk(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white)),
                              const SizedBox(height: 20),
                              _provideCompact(
                                  Icons.dashboard_rounded,
                                  'Web Portal',
                                  'Basic analytics • Parent notifications • Student-camera management • Live streaming view • Theme & logo customization',
                                  const Color(0xFF60A5FA)),
                              const SizedBox(height: 14),
                              _provideCompact(
                                  Icons.phone_iphone_rounded,
                                  'Mobile App for Parents',
                                  'Live streaming • School details • Notifications from school',
                                  const Color(0xFFF472B6)),
                              const SizedBox(height: 14),
                              _provideCompact(
                                  Icons.videocam_rounded,
                                  '$numCameras Live Streaming Cameras',
                                  '480P • 1 camera per 12 students',
                                  const Color(0xFF34D399)),
                              const SizedBox(height: 14),
                              _provideCompact(
                                  Icons.storage_rounded,
                                  'DVR Player',
                                  '1TB Local storage at school',
                                  const Color(0xFFFBBF24)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else ...[
                  // Mobile: stacked layout
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)]),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(16)),
                          child: Text('${widget.numStudents} STUDENTS',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('₹',
                                style: GoogleFonts.spaceGrotesk(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                            Text('$pricePerStudent',
                                style: GoogleFonts.spaceGrotesk(
                                    fontSize: 56,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1)),
                          ],
                        ),
                        Text('per student / month',
                            style: GoogleFonts.spaceGrotesk(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9))),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text("What's Included",
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                  const SizedBox(height: 16),
                  _provideCompact(
                      Icons.dashboard_rounded,
                      'Web Portal',
                      'Analytics • Notifications • Live streaming • Customization',
                      const Color(0xFF60A5FA)),
                  const SizedBox(height: 10),
                  _provideCompact(
                      Icons.phone_iphone_rounded,
                      'Mobile App for Parents',
                      'Live streaming • School details • Notifications',
                      const Color(0xFFF472B6)),
                  const SizedBox(height: 10),
                  _provideCompact(
                      Icons.videocam_rounded,
                      '$numCameras Live Streaming Cameras',
                      '1 camera per 12 students',
                      const Color(0xFF34D399)),
                  const SizedBox(height: 10),
                  _provideCompact(Icons.storage_rounded, 'DVR Player',
                      'Local storage at school', const Color(0xFFFBBF24)),
                  const Spacer(),
                  _noHiddenFees(),
                ],
                _noHiddenFees(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _provideCompact(
      IconData icon, String title, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                Text(desc,
                    style:
                        GoogleFonts.spaceGrotesk(fontSize: 14, color: color)),
              ],
            ),
          ),
          Icon(Icons.check_circle, color: color, size: 22),
        ],
      ),
    );
  }

  Widget _noHiddenFees() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.35)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Zero equipment or installation charges',
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                Text('Flat Monthly Tech Fee. Billed half-yearly or yearly.',
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 14, color: Colors.white60)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============ SLIDE 5: Financial Risk ============
  Widget _buildSlide5Risk() {
    return _slideContainer(
      gradient: const [Color(0xFF450A0A), Color(0xFF7F1D1D)],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final isWide = w > 900;
          final cardW = isWide ? (w - 160) / 3 : w - 60;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isWide ? 60 : 30, vertical: 60),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Lottie.asset(
                    "assets/lottie/fire.json",
                    height: h * 0.6,
                    fit: BoxFit.contain,
                    repeat: true,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: h * 0.5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBBF24).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Icon(Icons.priority_high_rounded,
                              size: 120,
                              color: const Color(0xFFFBBF24).withOpacity(0.3)),
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _badge('Hidden Costs Exposed', const Color(0xFFEF4444)),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Text('Financial Risk of ',
                            style: GoogleFonts.spaceGrotesk(
                                fontSize: isWide ? 56 : 36,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.1)),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Color(0xFFEF4444),
                                Color(0xFFF97316)
                              ]).createShader(bounds),
                          child: Text('"In House" Solutions',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: isWide ? 56 : 36,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  height: 1.1)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: [
                        _riskCard(
                            Icons.attach_money_rounded,
                            'Massive Upfront Development Cost (> ₹10 Lakhs)',
                            '> ₹10 Lakhs',
                            'It’s not just hardware. You need to hire specialized software engineers to build custom solution.',
                            const Color(0xFFEF4444),
                            cardW),
                        _riskCard(
                            Icons.cloud_upload_rounded,
                            'High Monthly Recurring Costs (OPEX)',
                            'Server Costs',
                            '''Streaming high-definition video to hundreds of parents simultaneously requires expensive cloud server infrastructure and high-bandwidth business internet lines.''',
                            const Color(0xFFF97316),
                            cardW),
                        _riskCard(
                            Icons.build_circle_rounded,
                            'Perpetual Maintenance & IT Headaches',
                            'Maintenance',
                            'Who fixes it when the app crashes during school hours? Who handles firmware updates and security patches? You would need dedicated IT staff on payroll to manage this complex infrastructure',
                            const Color(0xFFFBBF24),
                            cardW),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.lightbulb_rounded,
                              color: Color(0xFFFBBF24), size: 26),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              'With KIDZVIEW, you get enterprise-grade infrastructure at a fraction of the cost with zero hassle.',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============ SLIDE 6: Deal Structure ============
  Widget _buildSlide6Deal() {
    return _slideContainer(
      gradient: const [Color(0xFF0C1929), Color(0xFF1E3A5F)],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final isWide = w > 900;
          final cardW = isWide ? (w - 140) / 2 : w - 60;

          return Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: w * 0.45, top: 10),
                alignment: Alignment.topLeft,
                child: Lottie.asset(
                  "assets/lottie/property.json",
                  height: h * 0.4,
                  fit: BoxFit.contain,
                  repeat: true,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: h * 0.5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBBF24).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Icon(Icons.priority_high_rounded,
                            size: 120,
                            color: const Color(0xFFFBBF24).withOpacity(0.3)),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: w,
                padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 60 : 30, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _badge('Clear Terms', const Color(0xFF3B82F6)),
                    const SizedBox(height: 24),
                    Text('The Deal Structure',
                        style: GoogleFonts.spaceGrotesk(
                            fontSize: isWide ? 64 : 40,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.1)),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)])
                          .createShader(bounds),
                      child: Text('We Provide',
                          style: GoogleFonts.spaceGrotesk(
                              fontSize: isWide ? 64 : 40,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.1)),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Column(children: [
                          _dealCard(
                              Icons.lock_clock_rounded,
                              '3-Year Lock-in',
                              'Guaranteed service continuity with long-term partnership',
                              const Color(0xFF3B82F6),
                              cardW),
                          SizedBox(height: h * 0.045),
                          _dealCard(
                              Icons.location_city_rounded,
                              'Exclusivity Clause',
                              'We won\'t sell to competing schools in your area',
                              const Color(0xFF8B5CF6),
                              cardW),
                        ]),
                        SizedBox(width: h * 0.045),
                        Column(children: [
                          _dealCard(
                              Icons.calendar_month_rounded,
                              'Flexible Billing',
                              'Half-yearly or yearly billing—your choice',
                              const Color(0xFF10B981),
                              cardW),
                          SizedBox(height: h * 0.045),
                          _dealCard(
                              Icons.shield_rounded,
                              'Zero Risk',
                              'We handle all infrastructure, updates & support',
                              const Color(0xFFFBBF24),
                              cardW),
                        ]),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ============ SLIDE 7: Security ============
  Widget _buildSlide7Security() {
    return _slideContainer(
      gradient: const [Color(0xFF022C22), Color(0xFF064E3B)],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final isWide = w > 900;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isWide ? 60 : 30, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _badge('Privacy & Protection', const Color(0xFF10B981)),
                const SizedBox(height: 24),
                Text('Security for',
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: isWide ? 56 : 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1)),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF34D399)])
                      .createShader(bounds),
                  child: Text('Everyone',
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: isWide ? 56 : 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.1)),
                ),
                // const SizedBox(height: 40),

                // Two-column layout for wide screens, single column for narrow
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Children's Privacy Section
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.child_care_rounded,
                                        color: const Color(0xFF10B981),
                                        size: 28),
                                    const SizedBox(width: 12),
                                    Text('Children\'s Privacy',
                                        style: GoogleFonts.spaceGrotesk(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF10B981))),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _securityCard(
                                  Icons.storage_rounded,
                                  'Your Data Stays at School',
                                  'All video footage is stored locally at your school. We only provide the secure connection—we cannot access your videos.',
                                  const Color(0xFF10B981),
                                ),
                                const SizedBox(height: 14),
                                _securityCard(
                                  Icons.verified_user_rounded,
                                  'Only Parents Can Watch',
                                  'Parents must verify their identity before accessing videos. Only authorized guardians of specific children can view.',
                                  const Color(0xFF3B82F6),
                                ),
                                const SizedBox(height: 14),
                                _securityCard(
                                  Icons.shield_rounded,
                                  'No Child Tracking',
                                  'We never track, profile, or collect data about children. Their safety and privacy come first.',
                                  const Color(0xFFA855F7),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Teacher's Privacy Section
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.school_rounded,
                                        color: const Color(0xFFFBBF24),
                                        size: 28),
                                    const SizedBox(width: 12),
                                    Text('Teacher\'s Privacy',
                                        style: GoogleFonts.spaceGrotesk(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFFFBBF24))),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _securityCard(
                                  Icons.gavel_rounded,
                                  'Protection from False Allegations',
                                  'High transparency protects teachers. Video evidence prevents misunderstandings and false claims from parents.',
                                  const Color(0xFFFBBF24),
                                ),
                                const SizedBox(height: 14),
                                _securityCard(
                                  Icons.volume_off_rounded,
                                  'No Audio Recording',
                                  'Cameras record video only—no audio. All verbal communication stays completely private and confidential.',
                                  const Color(0xFFF97316),
                                ),
                                const SizedBox(height: 14),
                                _securityCard(
                                  Icons.settings_rounded,
                                  'Full Camera Control',
                                  'Teachers and admin can turn cameras on/off, limit parent viewing hours, and temporarily remove students from view when needed.',
                                  const Color(0xFFEC4899),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Children's Privacy Section (mobile)
                          Row(
                            children: [
                              Icon(Icons.child_care_rounded,
                                  color: const Color(0xFF10B981), size: 28),
                              const SizedBox(width: 12),
                              Text('Children\'s Privacy',
                                  style: GoogleFonts.spaceGrotesk(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF10B981))),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _securityCard(
                            Icons.storage_rounded,
                            'Your Data Stays at School',
                            'All video footage is stored locally at your school. We only provide the secure connection—we cannot access your videos.',
                            const Color(0xFF10B981),
                          ),
                          const SizedBox(height: 14),
                          _securityCard(
                            Icons.verified_user_rounded,
                            'Only Parents Can Watch',
                            'Parents must verify their identity before accessing videos. Only authorized guardians of specific children can view.',
                            const Color(0xFF3B82F6),
                          ),
                          const SizedBox(height: 14),
                          _securityCard(
                            Icons.shield_rounded,
                            'No Child Tracking',
                            'We never track, profile, or collect data about children. Their safety and privacy come first.',
                            const Color(0xFFA855F7),
                          ),
                          const SizedBox(height: 32),
                          // Teacher's Privacy Section (mobile)
                          Row(
                            children: [
                              Icon(Icons.school_rounded,
                                  color: const Color(0xFFFBBF24), size: 28),
                              const SizedBox(width: 12),
                              Text('Teacher\'s Privacy',
                                  style: GoogleFonts.spaceGrotesk(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFFFBBF24))),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _securityCard(
                            Icons.gavel_rounded,
                            'Protection from False Allegations',
                            'High transparency protects teachers. Video evidence prevents misunderstandings and false claims from parents.',
                            const Color(0xFFFBBF24),
                          ),
                          const SizedBox(height: 14),
                          _securityCard(
                            Icons.volume_off_rounded,
                            'No Audio Recording',
                            'Cameras record video only—no audio. All verbal communication stays completely private and confidential.',
                            const Color(0xFFF97316),
                          ),
                          const SizedBox(height: 14),
                          _securityCard(
                            Icons.settings_rounded,
                            'Full Camera Control',
                            'Teachers and admin can turn cameras on/off, limit parent viewing hours, and temporarily remove students from view when needed.',
                            const Color(0xFFEC4899),
                          ),
                        ],
                      ),
                const Spacer(),
                _complianceBanner(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _securityCard(IconData icon, String title, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [color.withOpacity(0.3), color.withOpacity(0.1)]),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(height: 8),
                Text(desc,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                        height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _complianceBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          const Color(0xFF10B981).withOpacity(0.2),
          const Color(0xFF10B981).withOpacity(0.05)
        ]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: const Color(0xFF10B981).withOpacity(0.4), width: 2),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_rounded,
              color: Color(0xFF10B981), size: 36),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              'Built for India\'s DPDP Act 2023, ensuring 100% privacy for children and zero liability for the platform.',
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ============ UI COMPONENTS ============

  Widget _slideContainer(
      {required List<Color> gradient, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradient)),
      child: child,
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(text,
          style: GoogleFonts.spaceGrotesk(
              fontSize: 15, fontWeight: FontWeight.w600, color: color)),
    );
  }

  Widget _scrollHint() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Opacity(
          opacity: 0.4 + (_pulseController.value * 0.6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.keyboard_arrow_down,
                  color: Colors.white, size: 28),
              const SizedBox(width: 8),
              Text('Scroll down',
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 15, color: Colors.white)),
            ],
          ),
        );
      },
    );
  }

  Widget _featureCard(
      IconData icon, String title, String desc, Color color, double width) {
    return Container(
      width: width * 0.7,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(height: 4),
                Text(desc,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 15, color: Colors.white70, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletLarge(IconData icon, String title, String desc, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14)),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              const SizedBox(height: 4),
              Text(desc,
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 20, color: Colors.white70, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _benefitCard(
      IconData icon, String title, String desc, Color color, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 24,
              offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 16),
          Text(title,
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.white)),
          const SizedBox(height: 6),
          Text(desc,
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.4)),
        ],
      ),
    );
  }

  Widget _riskCard(IconData icon, String title, String subtitle, String desc,
      Color color, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(subtitle,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: color)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(title,
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Text(desc,
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.8),
                  height: 1.4)),
        ],
      ),
    );
  }

  Widget _dealCard(
      IconData icon, String title, String desc, Color color, double width) {
    return Container(
      width: width * 0.8,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [color.withOpacity(0.18), color.withOpacity(0.05)]),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(height: 4),
                Text(desc,
                    style: GoogleFonts.spaceGrotesk(
                        fontSize: 15, color: Colors.white70)),
              ],
            ),
          ),
          Icon(Icons.check_circle, color: color, size: 26),
        ],
      ),
    );
  }

  Widget _buildCloseButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.close, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_totalSlides, (i) {
        final isActive = i == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 4),
          width: 8,
          height: isActive ? 28 : 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isActive ? Colors.white : Colors.white30),
        );
      }),
    );
  }

  Widget _buildNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _currentPage > 0
              ? () {
                  final screenHeight = MediaQuery.of(context).size.height;
                  _scrollController.animateTo(
                    (_currentPage - 1) * screenHeight,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutCubic,
                  );
                }
              : null,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: _currentPage > 0
                    ? Colors.white.withOpacity(0.1)
                    : Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.keyboard_arrow_up,
                color: _currentPage > 0 ? Colors.white : Colors.white30,
                size: 24),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20)),
          child: Text('${_currentPage + 1} / $_totalSlides',
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: _currentPage < _totalSlides - 1
              ? () {
                  final screenHeight = MediaQuery.of(context).size.height;
                  _scrollController.animateTo(
                    (_currentPage + 1) * screenHeight,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutCubic,
                  );
                }
              : null,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: _currentPage < _totalSlides - 1
                  ? const LinearGradient(
                      colors: [Color(0xFF60A5FA), Color(0xFF3B82F6)])
                  : null,
              color: _currentPage < _totalSlides - 1
                  ? null
                  : Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.keyboard_arrow_down,
                color: _currentPage < _totalSlides - 1
                    ? Colors.white
                    : Colors.white30,
                size: 24),
          ),
        ),
      ],
    );
  }

  Widget _comparisonFeature(String text, bool included, bool isWide) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            included ? Icons.check_circle : Icons.cancel,
            color: included ? const Color(0xFF34D399) : Colors.red.shade300,
            size: isWide ? 18 : 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.spaceGrotesk(
              fontSize: isWide ? 14 : 12,
              color: included ? Colors.white : Colors.white54,
              decoration: included ? null : TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
