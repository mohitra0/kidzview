import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/resize.dart';
import '../services/auth_service.dart';
import '../signin/login.dart';

class NavigationMenu extends StatefulWidget {
  final Function(String)? onMenuItemSelected;

  const NavigationMenu({
    super.key,
    this.onMenuItemSelected,
  });

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final Resize resize = Resize();
  String selectedMenu = 'Home';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: resize.width * 0.18,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // App Logo and Title
          _buildHeader(),

          // Search Bar
          _buildSearchBar(),

          // Menu Items
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: resize.width * 0.012,
                vertical: resize.height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMenuLabel('MENU'),
                  SizedBox(height: resize.height * 0.015),
                  
                  // Home (Dashboard)
                  _buildMenuItem(
                    icon: Icons.dashboard_rounded,
                    title: 'Home',
                    onTap: () => _selectMenu('Home'),
                  ),
                  
                  // Live Streaming
                  _buildMenuItem(
                    icon: Icons.videocam_rounded,
                    title: 'Live Streaming',
                    onTap: () => _selectMenu('Live Streaming'),
                  ),
                  
                  // Classes
                  _buildMenuItem(
                    icon: Icons.school_rounded,
                    title: 'Classes',
                    onTap: () => _selectMenu('Classes'),
                  ),
                  
                  // Notifications
                  _buildMenuItem(
                    icon: Icons.notifications_active_rounded,
                    title: 'Notifications',
                    onTap: () => _selectMenu('Notifications'),
                  ),
                  
                  SizedBox(height: resize.height * 0.02),
                  
                  Divider(
                    color: const Color(0xFFE5E7EB),
                    thickness: 1,
                    indent: resize.width * 0.012,
                    endIndent: resize.width * 0.012,
                  ),
                  
                  SizedBox(height: resize.height * 0.02),

                  // Settings (School Customization)
                  _buildMenuItem(
                    icon: Icons.settings_rounded,
                    title: 'Settings',
                    onTap: () => _selectMenu('Settings'),
                  ),
                ],
              ),
            ),
          ),

          // User Profile Section
          _buildUserProfile(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.012),
      child: Row(
        children: [
          Container(
            width: resize.width * 0.035,
            height: resize.width * 0.035,
            decoration: BoxDecoration(
              color: const Color(0xFF1f2937),
              borderRadius: BorderRadius.circular(resize.width * 0.008),
            ),
            child: Center(
              child: Icon(
                Icons.play_circle_filled,
                color: Colors.white,
                size: resize.width * 0.022,
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
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: resize.width * 0.012,
        vertical: resize.height * 0.01,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: resize.width * 0.01,
        vertical: resize.height * 0.012,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(resize.width * 0.006),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: const Color(0xFF9ca3af),
            size: resize.iconSize,
          ),
          SizedBox(width: resize.width * 0.006),
          Expanded(
            child: Text(
              'Search...',
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizeSmall,
                color: const Color(0xFF9ca3af),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuLabel(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: resize.width * 0.008),
      child: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          fontSize: resize.lableText,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF9ca3af),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? badge,
    String? trailingBadge,
    String? trailingLabel,
    Color? trailingColor,
    VoidCallback? onTap,
  }) {
    final bool isSelected = selectedMenu == title;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(resize.width * 0.006),
      child: Container(
        margin: EdgeInsets.only(bottom: resize.height * 0.008),
        padding: EdgeInsets.symmetric(
          horizontal: resize.width * 0.01,
          vertical: resize.height * 0.012,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8ECEF) : Colors.transparent,
          borderRadius: BorderRadius.circular(resize.width * 0.006),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: resize.iconSize * 1.2,
              color: isSelected
                  ? const Color(0xFF1f2937)
                  : const Color(0xFF6b7280),
            ),
            SizedBox(width: resize.width * 0.01),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizebase,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF1f2937)
                      : const Color(0xFF4b5563),
                ),
              ),
            ),
            if (badge != null)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resize.width * 0.006,
                  vertical: resize.height * 0.003,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(resize.width * 0.01),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.lableText,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            if (trailingBadge != null)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resize.width * 0.006,
                  vertical: resize.height * 0.003,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(resize.width * 0.01),
                ),
                child: Text(
                  trailingBadge,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.lableText,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6b7280),
                  ),
                ),
              ),
            if (trailingLabel != null)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: resize.width * 0.006,
                  vertical: resize.height * 0.003,
                ),
                decoration: BoxDecoration(
                  color: (trailingColor ?? Colors.green).withOpacity(0.1),
                  border: Border.all(
                    color: trailingColor ?? Colors.green,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(resize.width * 0.01),
                ),
                child: Text(
                  trailingLabel,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.lableText,
                    fontWeight: FontWeight.w600,
                    color: trailingColor ?? Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableMenuItem({
    required IconData icon,
    required String title,
    String? badge,
    required bool isExpanded,
    VoidCallback? onTap,
  }) {
    final bool isSelected = selectedMenu == title;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(resize.width * 0.006),
          child: Container(
            margin: EdgeInsets.only(bottom: resize.height * 0.008),
            padding: EdgeInsets.symmetric(
              horizontal: resize.width * 0.01,
              vertical: resize.height * 0.012,
            ),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFE8ECEF) : Colors.transparent,
              borderRadius: BorderRadius.circular(resize.width * 0.006),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: resize.iconSize * 1.2,
                  color: isSelected
                      ? const Color(0xFF1f2937)
                      : const Color(0xFF6b7280),
                ),
                SizedBox(width: resize.width * 0.01),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: resize.fontSizebase,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF1f2937)
                          : const Color(0xFF4b5563),
                    ),
                  ),
                ),
                if (badge != null)
                  Container(
                    margin: EdgeInsets.only(right: resize.width * 0.006),
                    padding: EdgeInsets.symmetric(
                      horizontal: resize.width * 0.006,
                      vertical: resize.height * 0.003,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(resize.width * 0.01),
                    ),
                    child: Text(
                      badge,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.lableText,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: resize.iconSize,
                  color: const Color(0xFF6b7280),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserProfile() {
    return Container(
      margin: EdgeInsets.all(resize.width * 0.012),
      padding: EdgeInsets.all(resize.width * 0.01),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(resize.width * 0.008),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: resize.width * 0.016,
            backgroundColor: const Color(0xFF1f2937),
            child: Text(
              'M',
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizebase,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: resize.width * 0.008),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mohit Rao',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizebase,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1f2937),
                  ),
                ),
                Text(
                  'mohit@gmail.com',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.lableText,
                    color: const Color(0xFF6b7280),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              size: resize.iconSize,
              color: const Color(0xFF6b7280),
            ),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  void _selectMenu(String menu) {
    setState(() {
      selectedMenu = menu;
    });
    if (widget.onMenuItemSelected != null) {
      widget.onMenuItemSelected!(menu);
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(resize.width * 0.01),
          ),
          title: Text(
            'Logout',
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.heading4,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1f2937),
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.fontSizebase,
              color: const Color(0xFF6b7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: resize.fontSizeSmall,
                  color: const Color(0xFF6b7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Logout
                await AuthService.logout();
                if (context.mounted) {
                  // Navigate to login page
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(resize.width * 0.006),
                ),
              ),
              child: Text(
                'Logout',
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
}
