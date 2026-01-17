import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentProfilePage extends StatelessWidget {
  final String studentName;
  final String rollNo;
  final String className;

  const StudentProfilePage({
    super.key,
    required this.studentName,
    required this.rollNo,
    required this.className,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF374151)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Student Profile', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF374151), fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column - Profile Info
            Expanded(flex: 1, child: _buildProfileCard()),
            const SizedBox(width: 24),
            // Right Column - Details
            Expanded(flex: 2, child: Column(
              children: [
                _buildAcademicInfo(),
                const SizedBox(height: 24),
                _buildAttendanceHistory(),
                const SizedBox(height: 24),
                _buildActivityTimeline(),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          // Photo
          Container(
            width: 120, height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)]),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text(studentName[0], style: GoogleFonts.spaceGrotesk(fontSize: 48, fontWeight: FontWeight.w700, color: Colors.white))),
          ),
          const SizedBox(height: 16),
          Text(studentName, style: GoogleFonts.spaceGrotesk(fontSize: 22, fontWeight: FontWeight.w700)),
          Text('$className • Roll: $rollNo', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.calendar_today, 'Admission Date', 'April 15, 2023'),
          _buildInfoRow(Icons.cake, 'Date of Birth', 'March 22, 2015'),
          _buildInfoRow(Icons.bloodtype, 'Blood Group', 'O+'),
          _buildInfoRow(Icons.location_on, 'Address', 'Sector 45, Gurugram'),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          Text('Parent/Guardian', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.person, 'Father', 'Rajesh Sharma'),
          _buildInfoRow(Icons.phone, 'Contact', '+91 98765 43210'),
          _buildInfoRow(Icons.email, 'Email', 'rajesh@email.com'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.phone_android, size: 16, color: Color(0xFF10B981)),
                const SizedBox(width: 6),
                Text('App Installed', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF10B981), fontWeight: FontWeight.w600, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF6B7280)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF9CA3AF))),
                Text(value, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAcademicInfo() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Academic Information', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatCard('Attendance', '94%', const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Rank', '#5', const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Avg Score', '87%', const Color(0xFF8B5CF6)),
              const SizedBox(width: 16),
              _buildStatCard('Subjects', '6', const Color(0xFFF59E0B)),
            ],
          ),
          const SizedBox(height: 24),
          Text('Subject Performance', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _buildSubjectBar('Mathematics', 92, const Color(0xFF3B82F6)),
          _buildSubjectBar('Science', 88, const Color(0xFF10B981)),
          _buildSubjectBar('English', 85, const Color(0xFF8B5CF6)),
          _buildSubjectBar('Hindi', 90, const Color(0xFFF59E0B)),
          _buildSubjectBar('Social Studies', 82, const Color(0xFF06B6D4)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.w700, color: color)),
            Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectBar(String subject, int score, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(subject, style: GoogleFonts.spaceGrotesk(fontSize: 13))),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: score / 100, backgroundColor: const Color(0xFFE5E7EB), valueColor: AlwaysStoppedAnimation(color), minHeight: 8),
            ),
          ),
          const SizedBox(width: 12),
          Text('$score%', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildAttendanceHistory() {
    final months = [
      {'month': 'Jan', 'present': 20, 'total': 22},
      {'month': 'Dec', 'present': 18, 'total': 20},
      {'month': 'Nov', 'present': 21, 'total': 22},
      {'month': 'Oct', 'present': 19, 'total': 21},
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Attendance History', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
              const Spacer(),
              TextButton(onPressed: () {}, child: Text('View All', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF3B82F6)))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: months.map((m) => Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Text(m['month'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text('${m['present']}/${m['total']}', style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700, color: const Color(0xFF10B981))),
                    Text('days', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTimeline() {
    final activities = [
      {'date': 'Jan 16, 2026', 'event': 'Attended all classes', 'type': 'attendance', 'icon': Icons.check_circle, 'color': const Color(0xFF10B981)},
      {'date': 'Jan 15, 2026', 'event': 'Submitted Math assignment', 'type': 'academic', 'icon': Icons.assignment, 'color': const Color(0xFF3B82F6)},
      {'date': 'Jan 14, 2026', 'event': 'Participated in Science Quiz - Rank #3', 'type': 'achievement', 'icon': Icons.emoji_events, 'color': const Color(0xFFF59E0B)},
      {'date': 'Jan 12, 2026', 'event': 'Parent viewed live stream (23 min)', 'type': 'streaming', 'icon': Icons.videocam, 'color': const Color(0xFF8B5CF6)},
      {'date': 'Jan 10, 2026', 'event': 'Fee payment received - ₹25,000', 'type': 'fee', 'icon': Icons.payment, 'color': const Color(0xFF06B6D4)},
      {'date': 'April 15, 2023', 'event': 'Student onboarded to Class 3A', 'type': 'onboarding', 'icon': Icons.person_add, 'color': const Color(0xFF10B981)},
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Activity Timeline', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(20)),
                child: Text('Since Onboarding', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...activities.map((a) => _buildTimelineItem(a)),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> activity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: (activity['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(activity['icon'] as IconData, color: activity['color'] as Color, size: 18),
              ),
              Container(width: 2, height: 30, color: const Color(0xFFE5E7EB)),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity['event'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(activity['date'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF9CA3AF))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
