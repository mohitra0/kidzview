import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherProfilePage extends StatelessWidget {
  final String teacherName;
  final String subject;
  final String email;

  const TeacherProfilePage({
    super.key,
    required this.teacherName,
    required this.subject,
    required this.email,
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
        title: Text('Teacher Profile', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF374151), fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: _buildProfileCard()),
            const SizedBox(width: 24),
            Expanded(flex: 2, child: Column(
              children: [
                _buildTeachingInfo(),
                const SizedBox(height: 24),
                _buildClassesAssigned(),
                const SizedBox(height: 24),
                _buildPerformanceMetrics(),
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
          Container(
            width: 120, height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)]),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text(teacherName[0], style: GoogleFonts.spaceGrotesk(fontSize: 48, fontWeight: FontWeight.w700, color: Colors.white))),
          ),
          const SizedBox(height: 16),
          Text(teacherName, style: GoogleFonts.spaceGrotesk(fontSize: 22, fontWeight: FontWeight.w700)),
          Text(subject, style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: Text('Active', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF10B981), fontWeight: FontWeight.w600, fontSize: 12)),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.email, 'Email', email),
          _buildInfoRow(Icons.phone, 'Phone', '+91 98765 43210'),
          _buildInfoRow(Icons.calendar_today, 'Joined', 'Aug 15, 2020'),
          _buildInfoRow(Icons.school, 'Qualification', 'M.Sc, B.Ed'),
          _buildInfoRow(Icons.work, 'Experience', '8 years'),
          _buildInfoRow(Icons.location_on, 'Address', 'Sector 22, Gurugram'),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          Text('Leave Balance', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLeaveChip('Casual', '8/12', const Color(0xFF3B82F6)),
              _buildLeaveChip('Sick', '8/10', const Color(0xFFEF4444)),
              _buildLeaveChip('Earned', '14/15', const Color(0xFF10B981)),
            ],
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

  Widget _buildLeaveChip(String type, String balance, Color color) {
    return Column(
      children: [
        Text(balance, style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700, color: color)),
        Text(type, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
      ],
    );
  }

  Widget _buildTeachingInfo() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Teaching Overview', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatCard('Classes', '4', const Color(0xFF8B5CF6)),
              const SizedBox(width: 16),
              _buildStatCard('Students', '142', const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Periods/Day', '6', const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Attendance', '98%', const Color(0xFFF59E0B)),
            ],
          ),
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

  Widget _buildClassesAssigned() {
    final classes = [
      {'name': 'Class 5A', 'subject': 'Mathematics', 'students': 35, 'room': '101'},
      {'name': 'Class 6B', 'subject': 'Mathematics', 'students': 36, 'room': '102'},
      {'name': 'Class 7A', 'subject': 'Mathematics', 'students': 34, 'room': '201'},
      {'name': 'Class 5A', 'subject': 'Science', 'students': 35, 'room': '101'},
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Classes Assigned', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          ...classes.map((c) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.class_, color: Color(0xFF8B5CF6), size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(c['name'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                      Text('${c['subject']} • Room ${c['room']}', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                    ],
                  ),
                ),
                Text('${c['students']} students', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Performance Metrics', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          _buildMetricRow('Student Performance', '87%', const Color(0xFF10B981)),
          _buildMetricRow('Class Attendance', '94%', const Color(0xFF3B82F6)),
          _buildMetricRow('Assignment Completion', '92%', const Color(0xFF8B5CF6)),
          _buildMetricRow('Parent Engagement', '78%', const Color(0xFFF59E0B)),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, Color color) {
    final percent = int.parse(value.replaceAll('%', '')) / 100;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 13)),
              const Spacer(),
              Text(value, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, color: color)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: percent, backgroundColor: const Color(0xFFE5E7EB), valueColor: AlwaysStoppedAnimation(color), minHeight: 8),
          ),
        ],
      ),
    );
  }
}
