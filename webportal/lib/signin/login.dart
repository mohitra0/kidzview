import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/resize.dart';
import '../pages/dashboard.dart';
import '../pages/pitch_input.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  final Resize resize = Resize();

  // Static credentials
  static const String _validEmail = 'm';
  static const String _validPassword = 'm';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    // Validate inputs
    if (_emailController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter your email');
      return;
    }

    if (_passwordController.text.isEmpty) {
      _showErrorSnackBar('Please enter your password');
      return;
    }

    // Show loading
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Check credentials
    if (_emailController.text.trim() == _validEmail &&
        _passwordController.text == _validPassword) {
      // Save login state
      await AuthService.saveLoginState(
        email: _emailController.text.trim(),
        name: 'Mohit Rao',
      );
      
      // Login successful
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      }
    } else {
      // Login failed
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Invalid email or password');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.fontSizeSmall,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(resize.width * 0.006),
        ),
      ),
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(resize.width * 0.008),
          ),
          title: Row(
            children: [
              Icon(
                Icons.support_agent,
                color: const Color(0xFF1f2937),
                size: resize.iconSize * 1.2,
              ),
              SizedBox(width: resize.width * 0.008),
              Text(
                'Contact Support',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.heading3,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F1419),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'For password reset or new account credentials, please contact us:',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizeSmall,
                  color: const Color(0xFF667085),
                  height: 1.5,
                ),
              ),
              SizedBox(height: resize.height * 0.02),
              _buildContactRow(
                Icons.phone_outlined,
                '+91 96505 63590',
                'tel:+919650563590',
              ),
              SizedBox(height: resize.height * 0.015),
              _buildContactRow(
                Icons.email_outlined,
                'kidzview@support.com',
                'mailto:kidzview@support.com',
              ),
              SizedBox(height: resize.height * 0.015),
              Container(
                padding: EdgeInsets.all(resize.width * 0.01),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(resize.width * 0.004),
                  border: Border.all(color: const Color(0xFFE4E7EC)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: const Color(0xFF667085),
                      size: resize.iconSize * 0.9,
                    ),
                    SizedBox(width: resize.width * 0.008),
                    Expanded(
                      child: Text(
                        'Shop No.13 G/F, CSC Market, Block 1/4, Paschim Vihar, New Delhi, 110063',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: resize.fontSizeSmall * 0.95,
                          color: const Color(0xFF667085),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF1f2937),
                padding: EdgeInsets.symmetric(
                  horizontal: resize.width * 0.015,
                  vertical: resize.height * 0.012,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(resize.width * 0.006),
                ),
              ),
              child: Text(
                'Got it',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizeSmall,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECEF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 768;

          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: isMobile ? resize.width * 0.05 : resize.width * 0.1,
              vertical: isMobile ? resize.height * 0.03 : resize.height * 0.05,
            ),
            child: Center(
              child: Material(
                color: Colors.transparent,
                elevation: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(resize.width * 0.012),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child:
                        isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PitchInputPage(),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: resize.width * 0.02,
            vertical: resize.height * 0.015,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
            ),
            borderRadius: BorderRadius.circular(resize.width * 0.006),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8B5CF6).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.rocket_launch,
                color: Colors.white,
                size: resize.iconSize,
              ),
              SizedBox(width: resize.width * 0.008),
              Text(
                'Get Started',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizebase,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left side - Login Form
        Expanded(
          flex: 5,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: resize.width * 0.045,
              vertical: resize.height * 0.06,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: resize.width * 0.3),
                child: _buildLoginForm(),
              ),
            ),
          ),
        ),
        // Right side - Hero Section
        Expanded(
          flex: 6,
          child: _buildHeroSection(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(resize.width * 0.08),
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo
        Row(
          children: [
            Container(
              width: resize.width * 0.03,
              height: resize.width * 0.03,
              decoration: BoxDecoration(
                color: const Color(0xFF1f2937),
                borderRadius: BorderRadius.circular(resize.width * 0.007),
              ),
              child: Center(
                child: Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                  size: resize.width * 0.02,
                ),
              ),
            ),
            SizedBox(width: resize.width * 0.008),
            Text(
              'KidzView',
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.heading3,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F1419),
              ),
            ),
          ],
        ),
        SizedBox(height: resize.height * 0.03),
        // Welcome Back
        Text(
          'Welcome Back!',
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.heading2,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F1419),
          ),
        ),
        SizedBox(height: resize.height * 0.012),
        // Subtitle
        Text(
          'Sign in to your KidzView portal and manage\nyour PlaySchool\'s live streaming with ease.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.fontSizeSmall,
            color: const Color(0xFF667085),
            height: 1.5,
          ),
        ),
        SizedBox(height: resize.height * 0.035),
        // Email Field
        Text(
          'Email',
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.fontSizeSmall,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF0F1419),
          ),
        ),
        SizedBox(height: resize.height * 0.01),
        _buildTextField(
          controller: _emailController,
          hint: 'Enter your email',
          icon: Icons.email_outlined,
        ),
        SizedBox(height: resize.height * 0.022),
        // Password Field
        Text(
          'Password',
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.fontSizeSmall,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF0F1419),
          ),
        ),
        SizedBox(height: resize.height * 0.01),
        _buildTextField(
          controller: _passwordController,
          hint: 'Enter your password',
          icon: Icons.lock_outline,
          obscure: _obscurePassword,
          suffix: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: const Color(0xFF98A2B3),
              size: resize.iconSize,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        SizedBox(height: resize.height * 0.01),
        // Forgot Password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              _showContactDialog();
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: resize.width * 0.006,
                vertical: resize.height * 0.005,
              ),
            ),
            child: Text(
              'Forgot Password?',
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizeSmall,
                color: const Color(0xFF1f2937),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: resize.height * 0.005),
        // Sign In Button
        SizedBox(
          width: double.infinity,
          height: resize.height * 0.055,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1f2937),
              foregroundColor: Colors.white,
              disabledBackgroundColor: const Color(0xFF1f2937).withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(resize.width * 0.006),
              ),
              elevation: 0,
            ),
            child: _isLoading
                ? SizedBox(
                    width: resize.iconSize,
                    height: resize.iconSize,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Sign In',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.fontSizebase,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        SizedBox(height: resize.height * 0.026),
        // OR Divider
        Row(
          children: [
            Expanded(
              child: Divider(
                color: const Color(0xFFE4E7EC),
                thickness: 1,
                height: resize.height * 0.01,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: resize.width * 0.012),
              child: Text(
                'OR',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizeSmall,
                  color: const Color(0xFF98A2B3),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: const Color(0xFFE4E7EC),
                thickness: 1,
                height: resize.height * 0.01,
              ),
            ),
          ],
        ),
        SizedBox(height: resize.height * 0.025),
        // Need Access Section
        Container(
          padding: EdgeInsets.all(resize.width * 0.015),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(resize.width * 0.006),
            border: Border.all(color: const Color(0xFFE4E7EC)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: const Color(0xFF1f2937),
                    size: resize.iconSize,
                  ),
                  SizedBox(width: resize.width * 0.008),
                  Text(
                    'Need Access?',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.fontSizebase,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F1419),
                    ),
                  ),
                ],
              ),
              SizedBox(height: resize.height * 0.012),
              Text(
                'Contact us to get your portal credentials',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizeSmall,
                  color: const Color(0xFF667085),
                  height: 1.5,
                ),
              ),
              SizedBox(height: resize.height * 0.015),
              // Contact Details
              _buildContactRow(
                Icons.phone_outlined,
                '+91 96505 63590',
                'tel:+919650563590',
              ),
              SizedBox(height: resize.height * 0.01),
              _buildContactRow(
                Icons.email_outlined,
                'kidzview@support.com',
                'mailto:kidzview@support.com',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: resize.width * 0.05,
        vertical: 0,
      ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Main Heading
          Text(
            'Live Streaming for\nPlaySchools',
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.heading1 * 1.3,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          SizedBox(height: resize.height * 0.045),
          // Testimonial
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.heading1 * 2,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 0.7,
                ),
              ),
              SizedBox(height: resize.height * 0.005),
              Text(
                'Give parents peace of mind by letting them watch\ntheir children anytime, anywhere. Privacy-safe,\ncrystal clear HD quality.',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizeLarge,
                  color: Colors.white.withOpacity(0.95),
                  height: 1.65,
                ),
              ),
              SizedBox(height: resize.height * 0.027),
              // Get Started Button
              _buildGetStartedButton(),
            ],
          ),
          SizedBox(height: resize.height * 0.06),
          // Divider
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.white.withOpacity(0.2),
          ),
          SizedBox(height: resize.height * 0.027),
          Text(
            'LOVED BY 10,000+ PARENTS',
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.lableText,
              fontWeight: FontWeight.w700,
              color: Colors.white.withOpacity(0.75),
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: resize.height * 0.029),
          // Feature Badges Row 1
          Wrap(
            spacing: resize.width * 0.023,
            runSpacing: resize.height * 0.027,
            children: [
              _buildFeatureBadge(Icons.camera_alt, '8 HD Cameras'),
              _buildFeatureBadge(Icons.cloud_upload, '96% Uptime'),
              _buildFeatureBadge(Icons.security, 'Privacy First'),
              _buildFeatureBadge(Icons.hd, 'HD Quality'),
            ],
          ),
          SizedBox(height: resize.height * 0.027),
          // Feature Badges Row 2
          Wrap(
            spacing: resize.width * 0.023,
            runSpacing: resize.height * 0.027,
            children: [
              _buildFeatureBadge(Icons.storage, '30 Days Storage'),
              _buildFeatureBadge(Icons.people, 'Unlimited Access'),
              _buildFeatureBadge(Icons.phone_android, 'Mobile App'),
              _buildFeatureBadge(Icons.download, 'Downloadable'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBadge(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(resize.width * 0.003),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(resize.width * 0.003),
          ),
          child: Icon(
            icon,
            color: Colors.white.withOpacity(0.9),
            size: resize.iconSize,
          ),
        ),
        SizedBox(width: resize.width * 0.006),
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.fontSizeSmall,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text, String link) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF667085),
          size: resize.iconSize * 0.9,
        ),
        SizedBox(width: resize.width * 0.008),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.fontSizeSmall,
              color: const Color(0xFF1f2937),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.spaceGrotesk(
          color: const Color(0xFF98A2B3),
          fontSize: resize.fontSizeSmall,
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF667085),
          size: resize.iconSize,
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(resize.width * 0.006),
          borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(resize.width * 0.006),
          borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(resize.width * 0.006),
          borderSide: const BorderSide(color: Color(0xFF1f2937), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: resize.width * 0.01,
          vertical: resize.height * 0.016,
        ),
      ),
    );
  }
}
