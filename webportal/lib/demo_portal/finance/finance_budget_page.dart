import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinanceBudgetPage extends StatelessWidget {
  const FinanceBudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final budgets = [
      {'category': 'Salaries', 'budget': 14400000, 'spent': 9550000, 'color': const Color(0xFF8B5CF6)},
      {'category': 'Infrastructure', 'budget': 2500000, 'spent': 1850000, 'color': const Color(0xFF3B82F6)},
      {'category': 'Utilities', 'budget': 1200000, 'spent': 780000, 'color': const Color(0xFFF59E0B)},
      {'category': 'Supplies & Materials', 'budget': 800000, 'spent': 520000, 'color': const Color(0xFF10B981)},
      {'category': 'Events & Activities', 'budget': 500000, 'spent': 180000, 'color': const Color(0xFFEF4444)},
      {'category': 'Technology', 'budget': 600000, 'spent': 420000, 'color': const Color(0xFF06B6D4)},
    ];

    final totalBudget = budgets.fold<int>(0, (s, b) => s + (b['budget'] as int));
    final totalSpent = budgets.fold<int>(0, (s, b) => s + (b['spent'] as int));

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Budget Planning', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Annual budget for FY 2025-26', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F766E), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                label: Text('Edit Budget', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Total Budget', '₹${(totalBudget / 100000).toStringAsFixed(1)}L', Icons.pie_chart, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Spent', '₹${(totalSpent / 100000).toStringAsFixed(1)}L', Icons.trending_up, const Color(0xFFF59E0B)),
              const SizedBox(width: 16),
              _buildStatCard('Remaining', '₹${((totalBudget - totalSpent) / 100000).toStringAsFixed(1)}L', Icons.account_balance_wallet, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Utilization', '${((totalSpent / totalBudget) * 100).toStringAsFixed(0)}%', Icons.analytics, const Color(0xFF8B5CF6)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category-wise Budget', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: budgets.length,
                      itemBuilder: (context, index) {
                        final b = budgets[index];
                        final percent = (b['spent'] as int) / (b['budget'] as int);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(width: 12, height: 12, decoration: BoxDecoration(color: b['color'] as Color, borderRadius: BorderRadius.circular(3))),
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(b['category'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                                  Text('₹${((b['spent'] as int) / 100000).toStringAsFixed(1)}L / ₹${((b['budget'] as int) / 100000).toStringAsFixed(1)}L', style: GoogleFonts.spaceGrotesk(fontSize: 13)),
                                  const SizedBox(width: 16),
                                  Text('${(percent * 100).toStringAsFixed(0)}%', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, color: percent > 0.9 ? const Color(0xFFEF4444) : b['color'] as Color)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  value: percent,
                                  backgroundColor: const Color(0xFFE5E7EB),
                                  valueColor: AlwaysStoppedAnimation(percent > 0.9 ? const Color(0xFFEF4444) : b['color'] as Color),
                                  minHeight: 12,
                                ),
                              ),
                            ],
                          ),
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
}
