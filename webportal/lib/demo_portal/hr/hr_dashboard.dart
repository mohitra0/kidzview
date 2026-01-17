import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'hr_onboarding_page.dart';
import 'hr_employees_page.dart';
import 'hr_leaves_page.dart';
import 'hr_attendance_page.dart';
import 'hr_recruitment_page.dart';
import 'hr_salary_page.dart';
import 'hr_performance_page.dart';
import 'hr_training_page.dart';
import 'hr_documents_page.dart';
import 'hr_complaints_page.dart';
import 'hr_announcements_page.dart';
import 'hr_activity_page.dart';
import 'hr_exit_page.dart';
import 'hr_reports_page.dart';

class HRDashboard extends StatefulWidget {
  const HRDashboard({super.key});

  @override
  State<HRDashboard> createState() => _HRDashboardState();
}

class _HRDashboardState extends State<HRDashboard> {
  int _selectedIndex = 0;
  
  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.dashboard, 'label': 'Dashboard'},
    {'icon': Icons.person_add, 'label': 'Teacher Onboarding'},
    {'icon': Icons.people, 'label': 'Employees'},
    {'icon': Icons.event_available, 'label': 'Leave Management'},
    {'icon': Icons.fingerprint, 'label': 'Attendance'},
    {'icon': Icons.work, 'label': 'Recruitment'},
    {'icon': Icons.payments, 'label': 'Salary Structure'},
    {'icon': Icons.star, 'label': 'Performance'},
    {'icon': Icons.school, 'label': 'Training'},
    {'icon': Icons.folder, 'label': 'Documents'},
    {'icon': Icons.report_problem, 'label': 'Complaints'},
    {'icon': Icons.campaign, 'label': 'Announcements'},
    {'icon': Icons.timeline, 'label': 'Activity Log'},
    {'icon': Icons.exit_to_app, 'label': 'Exit Management'},
    {'icon': Icons.assessment, 'label': 'HR Reports'},
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    
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
      width: isWide ? 240 : 70,
      decoration: BoxDecoration(
        color: const Color(0xFF7C3AED),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isWide ? 20 : 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFA78BFA), Color(0xFF8B5CF6)]), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.groups, color: Colors.white, size: 22),
                ),
                if (isWide) ...[
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('MCP Portal', style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text('HR Manager', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white60)),
                  ])),
                ],
              ],
            ),
          ),
          Container(height: 1, color: Colors.white12),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              padding: EdgeInsets.symmetric(horizontal: isWide ? 12 : 6),
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
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => setState(() => _selectedIndex = index),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: isWide ? 12 : 10, vertical: 10),
            child: Row(
              children: [
                Icon(item['icon'], color: isSelected ? Colors.white : Colors.white60, size: 20),
                if (isWide) ...[
                  const SizedBox(width: 10),
                  Expanded(child: Text(item['label'], style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500, color: isSelected ? Colors.white : Colors.white70), overflow: TextOverflow.ellipsis)),
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
      padding: EdgeInsets.all(isWide ? 16 : 10),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white12))),
      child: Row(
        children: [
          CircleAvatar(radius: 18, backgroundColor: const Color(0xFFA78BFA), child: Text('HR', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12))),
          if (isWide) ...[
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Meena Sharma', style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
              Text('hr@mcpschool.com', style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.white60)),
            ])),
            IconButton(icon: const Icon(Icons.logout, size: 18, color: Colors.white60), onPressed: () => Navigator.of(context).pop()),
          ],
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 1: return const HROnboardingPage();
      case 2: return const HREmployeesPage();
      case 3: return const HRLeavesPage();
      case 4: return const HRAttendancePage();
      case 5: return const HRRecruitmentPage();
      case 6: return const HRSalaryPage();
      case 7: return const HRPerformancePage();
      case 8: return const HRTrainingPage();
      case 9: return const HRDocumentsPage();
      case 10: return const HRComplaintsPage();
      case 11: return const HRAnnouncementsPage();
      case 12: return const HRActivityPage();
      case 13: return const HRExitPage();
      case 14: return const HRReportsPage();
      default: return _buildDashboardHome();
    }
  }

  Widget _buildDashboardHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('HR Dashboard', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
          Text('Human Resources Management Overview', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
          const SizedBox(height: 24),
          _buildStatsGrid(),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildPendingActions()),
              const SizedBox(width: 24),
              Expanded(child: _buildUpcomingEvents()),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildRecentHires()),
              const SizedBox(width: 24),
              Expanded(child: _buildLeaveRequests()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    final stats = [
      {'title': 'Total Employees', 'value': '92', 'change': '+3', 'icon': Icons.people, 'color': const Color(0xFF3B82F6)},
      {'title': 'Teachers', 'value': '68', 'change': '+2', 'icon': Icons.school, 'color': const Color(0xFF10B981)},
      {'title': 'Present Today', 'value': '89', 'change': '97%', 'icon': Icons.fingerprint, 'color': const Color(0xFF8B5CF6)},
      {'title': 'On Leave', 'value': '3', 'change': '', 'icon': Icons.event_busy, 'color': const Color(0xFFF59E0B)},
      {'title': 'Pending Leaves', 'value': '5', 'change': '', 'icon': Icons.pending_actions, 'color': const Color(0xFFEF4444)},
      {'title': 'Open Positions', 'value': '4', 'change': '', 'icon': Icons.work_outline, 'color': const Color(0xFF06B6D4)},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2.8, crossAxisSpacing: 16, mainAxisSpacing: 16),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE5E7EB))),
          child: Row(
            children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: (stat['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(stat['icon'] as IconData, color: stat['color'] as Color, size: 22)),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(stat['value'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 22, fontWeight: FontWeight.w700)),
                Row(children: [
                  Flexible(child: Text(stat['title'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280)), overflow: TextOverflow.ellipsis)),
                  if ((stat['change'] as String).isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Text(stat['change'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF10B981), fontWeight: FontWeight.w600)),
                  ],
                ]),
              ])),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPendingActions() {
    final actions = [
      {'title': 'Approve leave - Neha Gupta', 'type': 'leave', 'urgent': true},
      {'title': 'Review application - Science Teacher', 'type': 'hire', 'urgent': false},
      {'title': 'Complete onboarding - Amit Kumar', 'type': 'onboard', 'urgent': true},
      {'title': 'Process salary - January 2026', 'type': 'salary', 'urgent': false},
      {'title': 'Performance review due - 5 teachers', 'type': 'review', 'urgent': false},
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text('Pending Actions', style: GoogleFonts.spaceGrotesk(fontSize: 17, fontWeight: FontWeight.w700)),
            const Spacer(),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFEF4444), borderRadius: BorderRadius.circular(12)), child: Text('${actions.where((a) => a['urgent'] == true).length} Urgent', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600))),
          ]),
          const SizedBox(height: 16),
          ...actions.map((a) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: a['urgent'] == true ? const Color(0xFFFEF2F2) : const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(10), border: a['urgent'] == true ? Border.all(color: const Color(0xFFEF4444).withOpacity(0.3)) : null),
            child: Row(children: [
              Icon(_getActionIcon(a['type'] as String), size: 18, color: a['urgent'] == true ? const Color(0xFFEF4444) : const Color(0xFF7C3AED)),
              const SizedBox(width: 12),
              Expanded(child: Text(a['title'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w500))),
              TextButton(onPressed: () {}, child: Text('Action', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF7C3AED)))),
            ]),
          )),
        ],
      ),
    );
  }

  IconData _getActionIcon(String type) {
    switch (type) {
      case 'leave': return Icons.event_available;
      case 'hire': return Icons.person_search;
      case 'onboard': return Icons.person_add;
      case 'salary': return Icons.payments;
      default: return Icons.star;
    }
  }

  Widget _buildUpcomingEvents() {
    final events = [
      {'title': 'Staff Meeting', 'date': 'Jan 18', 'time': '10:00 AM'},
      {'title': 'New Teacher Orientation', 'date': 'Jan 20', 'time': '9:00 AM'},
      {'title': 'Performance Review Start', 'date': 'Jan 25', 'time': 'All Day'},
      {'title': 'Salary Processing', 'date': 'Jan 28', 'time': ''},
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming Events', style: GoogleFonts.spaceGrotesk(fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          ...events.map((e) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFF7C3AED).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(e['date'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF7C3AED))),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(e['title'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w500)),
                if ((e['time'] as String).isNotEmpty) Text(e['time'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
              ])),
            ]),
          )),
        ],
      ),
    );
  }

  Widget _buildRecentHires() {
    final hires = [
      {'name': 'Amit Kumar', 'role': 'English Teacher', 'joined': 'Jan 10, 2026', 'status': 'onboarding'},
      {'name': 'Priya Singh', 'role': 'Music Teacher', 'joined': 'Jan 5, 2026', 'status': 'active'},
      {'name': 'Rajesh Verma', 'role': 'PT Teacher', 'joined': 'Dec 20, 2025', 'status': 'active'},
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text('Recent Hires', style: GoogleFonts.spaceGrotesk(fontSize: 17, fontWeight: FontWeight.w700)),
            const Spacer(),
            TextButton(onPressed: () => setState(() => _selectedIndex = 2), child: Text('View All', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF7C3AED)))),
          ]),
          const SizedBox(height: 12),
          ...hires.map((h) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              CircleAvatar(radius: 18, backgroundColor: const Color(0xFF7C3AED).withOpacity(0.1), child: Text((h['name'] as String)[0], style: GoogleFonts.spaceGrotesk(color: const Color(0xFF7C3AED), fontWeight: FontWeight.w600))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(h['name'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                Text('${h['role']} • ${h['joined']}', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
              ])),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: h['status'] == 'onboarding' ? const Color(0xFFF59E0B).withOpacity(0.1) : const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Text((h['status'] as String).toUpperCase(), style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: h['status'] == 'onboarding' ? const Color(0xFFF59E0B) : const Color(0xFF10B981))),
              ),
            ]),
          )),
        ],
      ),
    );
  }

  Widget _buildLeaveRequests() {
    final leaves = [
      {'name': 'Neha Gupta', 'type': 'Casual', 'days': '3 days', 'date': 'Jan 20-22', 'status': 'pending'},
      {'name': 'Rahul Sharma', 'type': 'Sick', 'days': '1 day', 'date': 'Jan 18', 'status': 'pending'},
      {'name': 'Priya Patel', 'type': 'Earned', 'days': '5 days', 'date': 'Feb 1-5', 'status': 'pending'},
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text('Leave Requests', style: GoogleFonts.spaceGrotesk(fontSize: 17, fontWeight: FontWeight.w700)),
            const Spacer(),
            TextButton(onPressed: () => setState(() => _selectedIndex = 3), child: Text('View All', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF7C3AED)))),
          ]),
          const SizedBox(height: 12),
          ...leaves.map((l) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l['name'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                Text('${l['type']} • ${l['days']} • ${l['date']}', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
              ])),
              IconButton(icon: const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 22), onPressed: () {}),
              IconButton(icon: const Icon(Icons.cancel, color: Color(0xFFEF4444), size: 22), onPressed: () {}),
            ]),
          )),
        ],
      ),
    );
  }
}
