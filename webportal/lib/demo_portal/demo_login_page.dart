import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DemoLoginPage extends StatefulWidget {
  final String personaTitle;
  final Color personaColor;
  final List<Color> gradient;
  final IconData icon;
  final Widget destination;

  const DemoLoginPage({
    super.key,
    required this.personaTitle,
    required this.personaColor,
    required this.gradient,
    required this.icon,
    required this.destination,
  });

  @override
  State<DemoLoginPage> createState() => _DemoLoginPageState();
}

class _DemoLoginPageState extends State<DemoLoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    setState(() => _errorMessage = null);
    
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => _errorMessage = 'Please enter both username and password');
      return;
    }

    if (_usernameController.text == 'mcpportal' && _passwordController.text == 'mcpportal') {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(milliseconds: 800), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => widget.destination),
        );
      });
    } else {
      setState(() => _errorMessage = 'Invalid credentials. Use mcpportal / mcpportal');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: widget.gradient),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(widget.icon, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 24),
                
                // Title
                Text(
                  '${widget.personaTitle} Login',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'MCP Web Portal',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 32),

                // Error Message
                if (_errorMessage != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFFCA5A5)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(_errorMessage!, style: GoogleFonts.spaceGrotesk(color: const Color(0xFFDC2626), fontSize: 13)),
                        ),
                      ],
                    ),
                  ),

                // Username Field
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: widget.personaColor, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password Field
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: widget.personaColor, width: 2),
                    ),
                  ),
                  onSubmitted: (_) => _login(),
                ),
                const SizedBox(height: 24),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.personaColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading
                        ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text('Sign In', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 20),

                // Back Button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('← Back to Role Selection', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ),

                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.info_outline, size: 16, color: Color(0xFF6B7280)),
                      const SizedBox(width: 8),
                      Text('Demo: mcpportal / mcpportal', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                    ],
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
