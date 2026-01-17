import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRAttendancePage extends StatelessWidget {
  const HRAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final employees = [
      {'name': 'Rahul Sharma', 'empId': 'EMP001', 'dept': 'Mathematics', 'inTime': '8:45 AM', 'outTime': '4:30 PM', 'status': 'present'},
      {'name': 'Priya Patel', 'empId': 'EMP002', 'dept': 'Science', 'inTime': '8:30 AM', 'outTime': '4:15 PM', 'status': 'present'},
      {'name': 'Amit Kumar', 'empId': 'EMP003', 'dept': 'English', 'inTime': '9:15 AM', 'outTime': '-', 'status': 'late'},
      {'name': 'Neha Gupta', 'empId': 'EMP004', 'dept': 'Hindi', 'inTime': '-', 'outTime': '-', 'status': 'on_leave'},
      {'name': 'Suresh Verma', 'empId': 'EMP005', 'dept': 'Support', 'inTime': '8:00 AM', 'outTime': '4:00 PM', 'status': 'present'},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Staff Attendance', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text("Today's attendance: January 17, 2026", style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.calendar_today), label: Text('View Calendar', style: GoogleFonts.spaceGrotesk())),
              const SizedBox(width: 12),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: Text('Export Report', style: GoogleFonts.spaceGrotesk())),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Present', '${employees.where((e) => e['status'] == 'present').length}', Icons.check_circle, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Late', '${employees.where((e) => e['status'] == 'late').length}', Icons.schedule, const Color(0xFFF59E0B)),
              const SizedBox(width: 16),
              _buildStatCard('Absent', '0', Icons.cancel, const Color(0xFFEF4444)),
              const SizedBox(width: 16),
              _buildStatCard('On Leave', '${employees.where((e) => e['status'] == 'on_leave').length}', Icons.event_busy, const Color(0xFF7C3AED)),
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
                      Expanded(flex: 2, child: Text('Employee', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Department', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('In Time', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Out Time', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                    ]),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: employees.length,
                      itemBuilder: (context, index) {
                        final e = employees[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                          child: Row(children: [
                            Expanded(flex: 2, child: Row(children: [
                              CircleAvatar(radius: 18, backgroundColor: const Color(0xFF7C3AED).withOpacity(0.1), child: Text(e['name']![0], style: GoogleFonts.spaceGrotesk(color: const Color(0xFF7C3AED), fontWeight: FontWeight.w600))),
                              const SizedBox(width: 12),
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(e['name']!, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                                Text(e['empId']!, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
                              ]),
                            ])),
                            Expanded(child: Text(e['dept']!, style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                            Expanded(child: Text(e['inTime']!, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: e['status'] == 'late' ? const Color(0xFFF59E0B) : null))),
                            Expanded(child: Text(e['outTime']!, style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                            Expanded(child: _buildStatusBadge(e['status']!)),
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
            Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
            Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
          ]),
        ]),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    String label;
    switch (status) {
      case 'present': color = const Color(0xFF10B981); label = 'PRESENT'; break;
      case 'late': color = const Color(0xFFF59E0B); label = 'LATE'; break;
      case 'on_leave': color = const Color(0xFF7C3AED); label = 'ON LEAVE'; break;
      default: color = const Color(0xFFEF4444); label = 'ABSENT';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
    );
  }
}
