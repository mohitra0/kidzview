import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRActivityPage extends StatelessWidget {
  const HRActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {'time': '10:30 AM', 'user': 'Rahul Sharma', 'action': 'Logged into portal', 'type': 'login'},
      {'time': '10:15 AM', 'user': 'Priya Patel', 'action': 'Submitted assignment grades', 'type': 'task'},
      {'time': '9:45 AM', 'user': 'Amit Kumar', 'action': 'Applied for leave (Jan 20-22)', 'type': 'leave'},
      {'time': '9:30 AM', 'user': 'Neha Gupta', 'action': 'Uploaded lesson plan', 'type': 'task'},
      {'time': '9:15 AM', 'user': 'Rahul Sharma', 'action': 'Marked attendance for Class 5A', 'type': 'attendance'},
      {'time': '9:00 AM', 'user': 'Priya Patel', 'action': 'Started live stream', 'type': 'stream'},
      {'time': '8:45 AM', 'user': 'Amit Kumar', 'action': 'Logged into portal', 'type': 'login'},
      {'time': '8:30 AM', 'user': 'Suresh Verma', 'action': 'Clocked in', 'type': 'attendance'},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Activity Log', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text("Today's employee activities - January 17, 2026", style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(value: 'Today', underline: const SizedBox(), items: ['Today', 'Yesterday', 'This Week', 'This Month'].map((d) => DropdownMenuItem(value: d, child: Text(d, style: GoogleFonts.spaceGrotesk()))).toList(), onChanged: (_) {}),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(value: 'All Activities', underline: const SizedBox(), items: ['All Activities', 'Login/Logout', 'Attendance', 'Tasks', 'Leaves'].map((t) => DropdownMenuItem(value: t, child: Text(t, style: GoogleFonts.spaceGrotesk()))).toList(), onChanged: (_) {}),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
              child: ListView.builder(
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final a = activities[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a['time'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280), fontWeight: FontWeight.w500)),
                        const SizedBox(width: 16),
                        Container(
                          width: 10, height: 10, margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(shape: BoxShape.circle, color: _getActivityColor(a['type'] as String)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(a['user'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                                const SizedBox(width: 8),
                                _buildTypeBadge(a['type'] as String),
                              ]),
                              const SizedBox(height: 4),
                              Text(a['action'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case 'login': return const Color(0xFF3B82F6);
      case 'task': return const Color(0xFF10B981);
      case 'leave': return const Color(0xFFF59E0B);
      case 'attendance': return const Color(0xFF8B5CF6);
      case 'stream': return const Color(0xFFEF4444);
      default: return const Color(0xFF6B7280);
    }
  }

  Widget _buildTypeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: _getActivityColor(type).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Text(type.toUpperCase(), style: GoogleFonts.spaceGrotesk(fontSize: 9, fontWeight: FontWeight.w600, color: _getActivityColor(type))),
    );
  }
}
