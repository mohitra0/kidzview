import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'teacher_classes_page.dart';
import 'teacher_attendance_page.dart';
import 'teacher_timetable_page.dart';
import 'teacher_livestream_page.dart';
import 'teacher_leave_page.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  int _selectedIndex = 0;
  
  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.dashboard, 'label': 'Dashboard'},
    {'icon': Icons.class_, 'label': 'My Classes'},
    {'icon': Icons.fact_check, 'label': 'Attendance'},
    {'icon': Icons.schedule, 'label': 'Timetable'},
    {'icon': Icons.videocam, 'label': 'Live Stream'},
    {'icon': Icons.event_busy, 'label': 'Leave'},
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          // Sidebar Navigation
          _buildSidebar(isWide),
          // Main Content
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _buildSidebar(bool isWide) {
    return Container(
      width: isWide ? 260 : 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          // Logo Header
          Container(
            padding: EdgeInsets.all(isWide ? 24 : 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.school, color: Colors.white, size: 24),
                ),
                if (isWide) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MCP Portal',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 16, fontWeight: FontWeight.w700,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                        Text('Teacher View',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 12, color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Divider(height: 1),
          const SizedBox(height: 16),
          // Menu Items
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              padding: EdgeInsets.symmetric(horizontal: isWide ? 16 : 8),
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                final isSelected = _selectedIndex == index;
                return _buildMenuItem(item, isSelected, index, isWide);
              },
            ),
          ),
          // User Profile
          _buildUserProfile(isWide),
        ],
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item, bool isSelected, int index, bool isWide) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isSelected ? const Color(0xFF3B82F6).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => setState(() => _selectedIndex = index),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: isWide ? 16 : 12, vertical: 14),
            child: Row(
              children: [
                Icon(item['icon'],
                  color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
                  size: 22,
                ),
                if (isWide) ...[
                  const SizedBox(width: 12),
                  Text(item['label'],
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF374151),
                    ),
                  ),
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
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF3B82F6),
            child: Text('RS', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
          if (isWide) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rahul Sharma', style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w600)),
                  Text('Class Teacher - 5A', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout, size: 20, color: Color(0xFF6B7280)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 1: return const TeacherClassesPage();
      case 2: return const TeacherAttendancePage();
      case 3: return const TeacherTimetablePage();
      case 4: return const TeacherLivestreamPage();
      case 5: return const TeacherLeavePage();
      default: return _buildDashboardHome();
    }
  }

  Widget _buildDashboardHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good Morning, Rahul! 👋',
                    style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700, color: const Color(0xFF1F2937)),
                  ),
                  const SizedBox(height: 4),
                  Text('Here\'s what\'s happening today',
                    style: GoogleFonts.spaceGrotesk(fontSize: 15, color: const Color(0xFF6B7280)),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18, color: Color(0xFF6B7280)),
                    const SizedBox(width: 8),
                    Text('Thursday, Jan 16, 2026', style: GoogleFonts.spaceGrotesk(fontSize: 14, color: const Color(0xFF374151))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          // Stats Cards
          _buildStatsRow(),
          const SizedBox(height: 28),
          // Quick Actions & Schedule
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildTodaySchedule()),
              const SizedBox(width: 24),
              Expanded(child: _buildQuickActions()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      {'title': 'My Classes', 'value': '4', 'icon': Icons.class_, 'color': const Color(0xFF3B82F6)},
      {'title': 'Students', 'value': '142', 'icon': Icons.people, 'color': const Color(0xFF10B981)},
      {'title': 'Today\'s Attendance', 'value': '94%', 'icon': Icons.fact_check, 'color': const Color(0xFF8B5CF6)},
      {'title': 'Live Now', 'value': '2', 'icon': Icons.videocam, 'color': const Color(0xFFF59E0B)},
    ];
    return Row(
      children: stats.map((stat) => Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (stat['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(stat['icon'] as IconData, color: stat['color'] as Color, size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(stat['value'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700, color: const Color(0xFF1F2937))),
                  Text(stat['title'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                ],
              ),
            ],
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildTodaySchedule() {
    final schedule = [
      {'time': '8:00 AM', 'class': 'Class 5A - Mathematics', 'room': 'Room 101', 'status': 'completed'},
      {'time': '9:00 AM', 'class': 'Class 6B - Mathematics', 'room': 'Room 102', 'status': 'completed'},
      {'time': '10:30 AM', 'class': 'Class 5A - Science', 'room': 'Room 101', 'status': 'ongoing'},
      {'time': '12:00 PM', 'class': 'Class 7A - Mathematics', 'room': 'Room 103', 'status': 'upcoming'},
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Today\'s Schedule', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
              const Spacer(),
              TextButton(onPressed: () => setState(() => _selectedIndex = 3),
                child: Text('View Full', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF3B82F6))),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...schedule.map((item) => _buildScheduleItem(item)),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(Map<String, String> item) {
    final isOngoing = item['status'] == 'ongoing';
    final isCompleted = item['status'] == 'completed';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isOngoing ? const Color(0xFF3B82F6).withOpacity(0.05) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isOngoing ? const Color(0xFF3B82F6) : const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            width: 4, height: 50,
            decoration: BoxDecoration(
              color: isCompleted ? const Color(0xFF10B981) : isOngoing ? const Color(0xFF3B82F6) : const Color(0xFFD1D5DB),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['class']!, style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text('${item['time']} • ${item['room']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isCompleted ? const Color(0xFF10B981).withOpacity(0.1) : isOngoing ? const Color(0xFF3B82F6).withOpacity(0.1) : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isCompleted ? 'Done' : isOngoing ? 'Ongoing' : 'Upcoming',
              style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.w600,
                color: isCompleted ? const Color(0xFF10B981) : isOngoing ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.add_circle, 'label': 'Mark Attendance', 'color': const Color(0xFF10B981)},
      {'icon': Icons.videocam, 'label': 'Start Live Stream', 'color': const Color(0xFF3B82F6)},
      {'icon': Icons.assignment, 'label': 'Create Assignment', 'color': const Color(0xFF8B5CF6)},
      {'icon': Icons.notifications, 'label': 'Send Notification', 'color': const Color(0xFFF59E0B)},
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          ...actions.map((action) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(action['icon'] as IconData, color: action['color'] as Color, size: 22),
                      const SizedBox(width: 12),
                      Text(action['label'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w500)),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF9CA3AF)),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
