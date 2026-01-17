import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRReportsPage extends StatelessWidget {
  const HRReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      {'name': 'Employee Headcount', 'desc': 'Current strength by department', 'icon': Icons.people, 'color': const Color(0xFF3B82F6)},
      {'name': 'Attendance Report', 'desc': 'Monthly attendance summary', 'icon': Icons.fingerprint, 'color': const Color(0xFF10B981)},
      {'name': 'Leave Report', 'desc': 'Leave utilization by employee', 'icon': Icons.event, 'color': const Color(0xFFF59E0B)},
      {'name': 'Performance Report', 'desc': 'Rating distribution and trends', 'icon': Icons.star, 'color': const Color(0xFF7C3AED)},
      {'name': 'Salary Report', 'desc': 'Payroll summary by grade', 'icon': Icons.payments, 'color': const Color(0xFFEF4444)},
      {'name': 'Training Report', 'desc': 'Training completion status', 'icon': Icons.school, 'color': const Color(0xFF06B6D4)},
      {'name': 'Recruitment Report', 'desc': 'Hiring funnel analysis', 'icon': Icons.work, 'color': const Color(0xFF8B5CF6)},
      {'name': 'Attrition Report', 'desc': 'Turnover rate and reasons', 'icon': Icons.exit_to_app, 'color': const Color(0xFFEC4899)},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('HR Reports', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
          Text('Generate and download HR analytics reports', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(value: 'January 2026', underline: const SizedBox(), items: ['December 2025', 'January 2026', 'Q3 2025-26', 'FY 2025-26'].map((p) => DropdownMenuItem(value: p, child: Text(p, style: GoogleFonts.spaceGrotesk()))).toList(), onChanged: (_) {}),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1.3, crossAxisSpacing: 20, mainAxisSpacing: 20),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final r = reports[index];
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE5E7EB))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: (r['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                        child: Icon(r['icon'] as IconData, color: r['color'] as Color, size: 24),
                      ),
                      const SizedBox(height: 16),
                      Text(r['name'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(r['desc'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(child: OutlinedButton(onPressed: () {}, child: Text('View', style: GoogleFonts.spaceGrotesk(fontSize: 11)))),
                          const SizedBox(width: 8),
                          Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: r['color'] as Color), child: Text('Export', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white)))),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
