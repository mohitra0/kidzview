import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinanceTaxPage extends StatelessWidget {
  const FinanceTaxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tax & Compliance', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
          Text('TDS, GST and regulatory compliance', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('TDS Deducted', '₹2.4L', Icons.remove_circle_outline, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('TDS Paid', '₹1.8L', Icons.check_circle, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('TDS Pending', '₹60K', Icons.pending, const Color(0xFFF59E0B)),
              const SizedBox(width: 16),
              _buildStatCard('Next Due', 'Jan 31', Icons.calendar_today, const Color(0xFFEF4444)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildTDSSection()),
                const SizedBox(width: 24),
                Expanded(child: _buildComplianceSection()),
              ],
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

  Widget _buildTDSSection() {
    final tdsRecords = [
      {'vendor': 'Tech Solutions', 'section': '194C', 'amount': 85000, 'tds': 1700, 'status': 'pending'},
      {'vendor': 'SecureGuard', 'section': '194C', 'amount': 65000, 'tds': 1300, 'status': 'paid'},
      {'vendor': 'Rent Payment', 'section': '194I', 'amount': 120000, 'tds': 12000, 'status': 'pending'},
      {'vendor': 'Professional Services', 'section': '194J', 'amount': 50000, 'tds': 5000, 'status': 'paid'},
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('TDS Deductions', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
              const Spacer(),
              TextButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 18), label: Text('Add Entry', style: GoogleFonts.spaceGrotesk())),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: tdsRecords.length,
              itemBuilder: (context, index) {
                final t = tdsRecords[index];
                final isPaid = t['status'] == 'paid';
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(t['vendor'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                          Text('Section ${t['section']} • ₹${t['amount']}', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                        ]),
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text('₹${t['tds']}', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: isPaid ? const Color(0xFF10B981).withOpacity(0.1) : const Color(0xFFF59E0B).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                          child: Text(isPaid ? 'PAID' : 'PENDING', style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: isPaid ? const Color(0xFF10B981) : const Color(0xFFF59E0B))),
                        ),
                      ]),
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

  Widget _buildComplianceSection() {
    final compliance = [
      {'task': 'TDS Payment Q3', 'due': 'Jan 31, 2026', 'status': 'upcoming', 'priority': 'high'},
      {'task': 'File Form 26Q', 'due': 'Jan 31, 2026', 'status': 'upcoming', 'priority': 'high'},
      {'task': 'PF Challan Payment', 'due': 'Feb 15, 2026', 'status': 'upcoming', 'priority': 'medium'},
      {'task': 'ESI Payment', 'due': 'Feb 15, 2026', 'status': 'upcoming', 'priority': 'medium'},
      {'task': 'TDS Return Q2', 'due': 'Oct 31, 2025', 'status': 'completed', 'priority': 'low'},
      {'task': 'Annual Audit', 'due': 'Sep 30, 2025', 'status': 'completed', 'priority': 'low'},
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Compliance Calendar', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: compliance.length,
              itemBuilder: (context, index) {
                final c = compliance[index];
                final isCompleted = c['status'] == 'completed';
                final isHigh = c['priority'] == 'high';
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isCompleted ? const Color(0xFFF9FAFB) : isHigh ? const Color(0xFFFEF2F2) : const Color(0xFFFEFCE8),
                    borderRadius: BorderRadius.circular(12),
                    border: isHigh && !isCompleted ? Border.all(color: const Color(0xFFEF4444).withOpacity(0.3)) : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isCompleted ? Icons.check_circle : Icons.schedule,
                        color: isCompleted ? const Color(0xFF10B981) : isHigh ? const Color(0xFFEF4444) : const Color(0xFFF59E0B),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(c['task'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500, decoration: isCompleted ? TextDecoration.lineThrough : null)),
                          Text('Due: ${c['due']}', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                        ]),
                      ),
                      if (!isCompleted)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: isHigh ? const Color(0xFFEF4444) : const Color(0xFFF59E0B), borderRadius: BorderRadius.circular(4)),
                          child: Text(isHigh ? 'HIGH' : 'MEDIUM', style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
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
