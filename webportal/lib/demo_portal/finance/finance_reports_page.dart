import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinanceReportsPage extends StatelessWidget {
  const FinanceReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      {'name': 'Monthly Financial Summary', 'desc': 'Revenue, expenses, profit for this month', 'icon': Icons.summarize, 'color': const Color(0xFF3B82F6)},
      {'name': 'Fee Collection Report', 'desc': 'Detailed fee collection by class', 'icon': Icons.school, 'color': const Color(0xFF10B981)},
      {'name': 'Expense Report', 'desc': 'Category-wise expense breakdown', 'icon': Icons.receipt_long, 'color': const Color(0xFFEF4444)},
      {'name': 'Payroll Report', 'desc': 'Salary disbursement summary', 'icon': Icons.payments, 'color': const Color(0xFF8B5CF6)},
      {'name': 'Outstanding Dues', 'desc': 'Students with pending fees', 'icon': Icons.pending, 'color': const Color(0xFFF59E0B)},
      {'name': 'Tax Summary', 'desc': 'TDS, GST collection & payment', 'icon': Icons.calculate, 'color': const Color(0xFF06B6D4)},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Financial Reports', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
          Text('Generate and download financial reports', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(value: 'January 2026', underline: const SizedBox(), items: ['December 2025', 'January 2026', 'Q3 2025-26', 'FY 2025-26'].map((m) => DropdownMenuItem(value: m, child: Text(m, style: GoogleFonts.spaceGrotesk()))).toList(), onChanged: (_) {}),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.8, crossAxisSpacing: 20, mainAxisSpacing: 20),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final r = reports[index];
                return Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: (r['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                            child: Icon(r['icon'] as IconData, color: r['color'] as Color, size: 24),
                          ),
                          const Spacer(),
                          IconButton(icon: const Icon(Icons.download, size: 20), onPressed: () {}, color: const Color(0xFF6B7280)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(r['name'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(r['desc'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(onPressed: () {}, child: Text('Preview', style: GoogleFonts.spaceGrotesk(fontSize: 12))),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: r['color'] as Color),
                              child: Text('Generate', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.white)),
                            ),
                          ),
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
