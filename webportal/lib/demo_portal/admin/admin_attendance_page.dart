import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminAttendancePage extends StatefulWidget {
  const AdminAttendancePage({super.key});

  @override
  State<AdminAttendancePage> createState() => _AdminAttendancePageState();
}

class _AdminAttendancePageState extends State<AdminAttendancePage> {
  String _selectedClass = 'All Classes';
  String _selectedPeriod = 'Today';

  final List<Map<String, dynamic>> _classAttendance = [
    {'class': 'Class 5A', 'present': 32, 'absent': 3, 'late': 0, 'total': 35},
    {'class': 'Class 5B', 'present': 30, 'absent': 1, 'late': 1, 'total': 32},
    {'class': 'Class 6A', 'present': 35, 'absent': 2, 'late': 1, 'total': 38},
    {'class': 'Class 6B', 'present': 34, 'absent': 2, 'late': 0, 'total': 36},
    {'class': 'Class 7A', 'present': 32, 'absent': 1, 'late': 1, 'total': 34},
    {'class': 'Class 7B', 'present': 30, 'absent': 2, 'late': 1, 'total': 33},
  ];

  @override
  Widget build(BuildContext context) {
    final totalPresent = _classAttendance.fold<int>(0, (s, c) => s + (c['present'] as int));
    final totalAbsent = _classAttendance.fold<int>(0, (s, c) => s + (c['absent'] as int));
    final totalStudents = _classAttendance.fold<int>(0, (s, c) => s + (c['total'] as int));

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
                  Text('Attendance Reports', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('School-wide attendance overview', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(
                  value: _selectedPeriod,
                  underline: const SizedBox(),
                  items: ['Today', 'This Week', 'This Month'].map((p) => DropdownMenuItem(value: p, child: Text(p, style: GoogleFonts.spaceGrotesk()))).toList(),
                  onChanged: (v) => setState(() => _selectedPeriod = v!),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: Text('Export', style: GoogleFonts.spaceGrotesk())),
            ],
          ),
          const SizedBox(height: 24),
          // Stats
          Row(
            children: [
              _buildStatCard('Present', '$totalPresent', const Color(0xFF10B981), '${((totalPresent / totalStudents) * 100).toStringAsFixed(1)}%'),
              const SizedBox(width: 16),
              _buildStatCard('Absent', '$totalAbsent', const Color(0xFFEF4444), '${((totalAbsent / totalStudents) * 100).toStringAsFixed(1)}%'),
              const SizedBox(width: 16),
              _buildStatCard('Late Arrivals', '4', const Color(0xFFF59E0B), '0.4%'),
              const SizedBox(width: 16),
              _buildStatCard('Total Students', '$totalStudents', const Color(0xFF3B82F6), '100%'),
            ],
          ),
          const SizedBox(height: 24),
          // Table
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text('Class', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Present', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Absent', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Late', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Attendance %', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      const SizedBox(width: 80),
                    ],
                  ),
                ),
                ..._classAttendance.map((c) => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Row(children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.class_, color: Color(0xFF8B5CF6), size: 18),
                        ),
                        const SizedBox(width: 12),
                        Text(c['class'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                      ])),
                      Expanded(child: Text('${c['present']}', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF10B981), fontWeight: FontWeight.w600))),
                      Expanded(child: Text('${c['absent']}', style: GoogleFonts.spaceGrotesk(color: const Color(0xFFEF4444), fontWeight: FontWeight.w600))),
                      Expanded(child: Text('${c['late']}', style: GoogleFonts.spaceGrotesk(color: const Color(0xFFF59E0B), fontWeight: FontWeight.w600))),
                      Expanded(child: _buildProgressBar((c['present'] as int) / (c['total'] as int))),
                      SizedBox(width: 80, child: TextButton(onPressed: () {}, child: Text('Details', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF8B5CF6))))),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, String percent) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Text(percent, style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w700, color: color)),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.w700)),
                Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(double value) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: AlwaysStoppedAnimation(value > 0.9 ? const Color(0xFF10B981) : value > 0.8 ? const Color(0xFFF59E0B) : const Color(0xFFEF4444)),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text('${(value * 100).toStringAsFixed(0)}%', style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
