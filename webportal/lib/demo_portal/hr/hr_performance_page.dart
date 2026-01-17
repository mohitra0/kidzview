import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRPerformancePage extends StatelessWidget {
  const HRPerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final teachers = [
      {'name': 'Rahul Sharma', 'dept': 'Mathematics', 'rating': 4.5, 'attendance': 98, 'students': 87, 'status': 'excellent'},
      {'name': 'Priya Patel', 'dept': 'Science', 'rating': 4.2, 'attendance': 95, 'students': 82, 'status': 'good'},
      {'name': 'Amit Kumar', 'dept': 'English', 'rating': 3.8, 'attendance': 92, 'students': 78, 'status': 'average'},
      {'name': 'Neha Gupta', 'dept': 'Hindi', 'rating': 4.0, 'attendance': 90, 'students': 80, 'status': 'good'},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Performance Reviews', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Evaluate and track teacher performance', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: Text('Export Report', style: GoogleFonts.spaceGrotesk())),
              const SizedBox(width: 12),
              ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, color: Colors.white), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED)), label: Text('Start Review', style: GoogleFonts.spaceGrotesk(color: Colors.white))),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Avg Rating', '4.1', Icons.star, const Color(0xFFF59E0B)),
              const SizedBox(width: 16),
              _buildStatCard('Reviews Done', '45/68', Icons.check_circle, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Pending', '23', Icons.pending, const Color(0xFF7C3AED)),
              const SizedBox(width: 16),
              _buildStatCard('Next Cycle', 'Mar 2026', Icons.calendar_today, const Color(0xFF3B82F6)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                    child: Row(children: [
                      Expanded(flex: 2, child: Text('Teacher', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Department', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Rating', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Attendance', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Student Score', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Performance', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      const SizedBox(width: 80),
                    ]),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: teachers.length,
                      itemBuilder: (context, index) {
                        final t = teachers[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                          child: Row(children: [
                            Expanded(flex: 2, child: Row(children: [
                              CircleAvatar(radius: 18, backgroundColor: const Color(0xFF7C3AED).withOpacity(0.1), child: Text((t['name'] as String)[0], style: GoogleFonts.spaceGrotesk(color: const Color(0xFF7C3AED), fontWeight: FontWeight.w600))),
                              const SizedBox(width: 12),
                              Text(t['name'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                            ])),
                            Expanded(child: Text(t['dept'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                            Expanded(child: Row(children: [
                              const Icon(Icons.star, color: Color(0xFFF59E0B), size: 16),
                              const SizedBox(width: 4),
                              Text('${t['rating']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w600)),
                            ])),
                            Expanded(child: Text('${t['attendance']}%', style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                            Expanded(child: Text('${t['students']}%', style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                            Expanded(child: _buildPerformanceBadge(t['status'] as String)),
                            SizedBox(width: 80, child: TextButton(onPressed: () {}, child: Text('Review', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF7C3AED))))),
                          ]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE5E7EB))),
        child: Row(children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 22)),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
            Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
          ]),
        ]),
      ),
    );
  }

  Widget _buildPerformanceBadge(String status) {
    Color color = status == 'excellent' ? const Color(0xFF10B981) : status == 'good' ? const Color(0xFF3B82F6) : const Color(0xFFF59E0B);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(status.toUpperCase(), style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
    );
  }
}
