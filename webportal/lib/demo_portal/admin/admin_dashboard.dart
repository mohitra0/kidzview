import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_users_page.dart';
import 'admin_classes_page.dart';
import 'admin_streaming_page.dart';
import 'admin_attendance_page.dart';
import 'admin_notifications_page.dart';
import 'admin_settings_page.dart';
import 'admin_analytics_page.dart';
import 'admin_onboarding_page.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  
  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.dashboard, 'label': 'Dashboard'},
    {'icon': Icons.person_add, 'label': 'Student Onboarding'},
    {'icon': Icons.people, 'label': 'Users'},
    {'icon': Icons.class_, 'label': 'Classes'},
    {'icon': Icons.videocam, 'label': 'Live Streaming'},
    {'icon': Icons.fact_check, 'label': 'Attendance'},
    {'icon': Icons.notifications, 'label': 'Notifications'},
    {'icon': Icons.analytics, 'label': 'Analytics'},
    {'icon': Icons.settings, 'label': 'Settings'},
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          _buildSidebar(isWide),
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _buildSidebar(bool isWide) {
    return Container(
      width: isWide ? 260 : 80,
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isWide ? 24 : 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.admin_panel_settings, color: Colors.white, size: 24),
                ),
                if (isWide) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MCP Portal', style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                        Text('Admin Panel', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.white60)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(height: 1, color: Colors.white12),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              padding: EdgeInsets.symmetric(horizontal: isWide ? 16 : 8),
              itemBuilder: (context, index) => _buildMenuItem(_menuItems[index], _selectedIndex == index, index, isWide),
            ),
          ),
          _buildUserProfile(isWide),
        ],
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item, bool isSelected, int index, bool isWide) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => setState(() => _selectedIndex = index),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: isWide ? 16 : 12, vertical: 12),
            child: Row(
              children: [
                Icon(item['icon'], color: isSelected ? const Color(0xFF8B5CF6) : Colors.white60, size: 22),
                if (isWide) ...[
                  const SizedBox(width: 12),
                  Text(item['label'], style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500, color: isSelected ? Colors.white : Colors.white70)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(bool isWide) {
    return Container(
      padding: EdgeInsets.all(isWide ? 20 : 12),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.white12))),
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundColor: const Color(0xFF8B5CF6), child: Text('SA', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600))),
          if (isWide) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Super Admin', style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                  Text('admin@mcpschool.com', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white60)),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.logout, size: 20, color: Colors.white60), onPressed: () => Navigator.of(context).pop()),
          ],
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 1: return const AdminOnboardingPage();
      case 2: return const AdminUsersPage();
      case 3: return const AdminClassesPage();
      case 4: return const AdminStreamingPage();
      case 5: return const AdminAttendancePage();
      case 6: return const AdminNotificationsPage();
      case 7: return const AdminAnalyticsPage();
      case 8: return const AdminSettingsPage();
      default: return _buildDashboardHome();
    }
  }

  Widget _buildDashboardHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Admin Dashboard', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('Complete school overview', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE5E7EB))),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18, color: Color(0xFF6B7280)),
                    const SizedBox(width: 8),
                    Text('Thursday, Jan 16, 2026', style: GoogleFonts.spaceGrotesk(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildStatsGrid(),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildRecentActivity()),
              const SizedBox(width: 24),
              Expanded(child: _buildQuickStats()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    final stats = [
      {'title': 'Total Students', 'value': '1,248', 'change': '+12', 'icon': Icons.school, 'color': const Color(0xFF3B82F6)},
      {'title': 'Total Teachers', 'value': '68', 'change': '+2', 'icon': Icons.person, 'color': const Color(0xFF10B981)},
      {'title': 'Active Classes', 'value': '42', 'change': '0', 'icon': Icons.class_, 'color': const Color(0xFF8B5CF6)},
      {'title': 'Live Cameras', 'value': '24', 'change': '', 'icon': Icons.videocam, 'color': const Color(0xFFF59E0B)},
      {'title': 'Today\'s Attendance', 'value': '92%', 'change': '+3%', 'icon': Icons.fact_check, 'color': const Color(0xFF06B6D4)},
      {'title': 'Pending Fees', 'value': '₹4.2L', 'change': '-8%', 'icon': Icons.currency_rupee, 'color': const Color(0xFFEF4444)},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2.5, crossAxisSpacing: 16, mainAxisSpacing: 16),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: (stat['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(stat['icon'] as IconData, color: stat['color'] as Color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(stat['value'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.w700)),
                    Row(
                      children: [
                        Text(stat['title'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                        if ((stat['change'] as String).isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(stat['change'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: (stat['change'] as String).startsWith('-') ? const Color(0xFFEF4444) : const Color(0xFF10B981), fontWeight: FontWeight.w600)),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecentActivity() {
    final activities = [
      {'title': 'New student enrolled', 'desc': 'Aditya Kumar joined Class 5A', 'time': '10 min ago', 'icon': Icons.person_add, 'color': const Color(0xFF10B981)},
      {'title': 'Fee payment received', 'desc': '₹25,000 from Sharma family', 'time': '25 min ago', 'icon': Icons.payment, 'color': const Color(0xFF3B82F6)},
      {'title': 'Leave approved', 'desc': 'Rahul Sharma - 3 days casual leave', 'time': '1 hr ago', 'icon': Icons.check_circle, 'color': const Color(0xFF8B5CF6)},
      {'title': 'Camera offline', 'desc': 'Room 205 camera disconnected', 'time': '2 hr ago', 'icon': Icons.warning, 'color': const Color(0xFFF59E0B)},
      {'title': 'Notification sent', 'desc': 'PTM reminder sent to 842 parents', 'time': '3 hr ago', 'icon': Icons.notifications, 'color': const Color(0xFF06B6D4)},
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Recent Activity', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
              const Spacer(),
              TextButton(onPressed: () {}, child: Text('View All', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF8B5CF6)))),
            ],
          ),
          const SizedBox(height: 16),
          ...activities.map((a) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: (a['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(a['icon'] as IconData, color: a['color'] as Color, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a['title'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 14)),
                      Text(a['desc'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                    ],
                  ),
                ),
                Text(a['time'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF9CA3AF))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          _buildQuickAction('Add New Student', Icons.person_add, const Color(0xFF3B82F6), () => setState(() => _selectedIndex = 1)),
          _buildQuickAction('Send Notification', Icons.campaign, const Color(0xFF10B981), () => setState(() => _selectedIndex = 6)),
          _buildQuickAction('Generate Report', Icons.assessment, const Color(0xFF8B5CF6), () => setState(() => _selectedIndex = 7)),
          _buildQuickAction('Manage Cameras', Icons.videocam, const Color(0xFFF59E0B), () => setState(() => _selectedIndex = 4)),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String label, IconData icon, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 12),
                Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w500)),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF9CA3AF)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
