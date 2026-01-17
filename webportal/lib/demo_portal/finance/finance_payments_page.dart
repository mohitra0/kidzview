import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinancePaymentsPage extends StatelessWidget {
  const FinancePaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {'id': 'TXN001', 'type': 'credit', 'desc': 'Fee - Aarav Sharma (Class 5A)', 'amount': 25000, 'mode': 'UPI', 'date': 'Jan 16, 10:30 AM', 'ref': 'UPI123456'},
      {'id': 'TXN002', 'type': 'debit', 'desc': 'Salary - Rahul Sharma', 'amount': 48600, 'mode': 'Bank Transfer', 'date': 'Jan 15, 4:00 PM', 'ref': 'NEFT789012'},
      {'id': 'TXN003', 'type': 'credit', 'desc': 'Fee - Ananya Patel (Class 5A)', 'amount': 25000, 'mode': 'Cash', 'date': 'Jan 14, 11:00 AM', 'ref': 'CASH34567'},
      {'id': 'TXN004', 'type': 'debit', 'desc': 'Vendor - ABC Supplies', 'amount': 12500, 'mode': 'Cheque', 'date': 'Jan 13, 2:30 PM', 'ref': 'CHQ890123'},
      {'id': 'TXN005', 'type': 'credit', 'desc': 'Fee - Arjun Singh (Partial)', 'amount': 15000, 'mode': 'UPI', 'date': 'Jan 12, 9:00 AM', 'ref': 'UPI456789'},
      {'id': 'TXN006', 'type': 'debit', 'desc': 'Electricity Bill - BSES', 'amount': 45000, 'mode': 'Bank Transfer', 'date': 'Jan 10, 11:30 AM', 'ref': 'NEFT012345'},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Payment History', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('View all transactions and payment records', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.filter_list), label: Text('Filter', style: GoogleFonts.spaceGrotesk())),
              const SizedBox(width: 12),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: Text('Export', style: GoogleFonts.spaceGrotesk())),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Total Credits', '₹1.85L', Icons.arrow_downward, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Total Debits', '₹1.06L', Icons.arrow_upward, const Color(0xFFEF4444)),
              const SizedBox(width: 16),
              _buildStatCard('Net Balance', '₹79K', Icons.account_balance, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Transactions', '${transactions.length}', Icons.receipt, const Color(0xFF8B5CF6)),
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
                      const SizedBox(width: 40),
                      Expanded(child: Text('Transaction ID', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(flex: 2, child: Text('Description', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Amount', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Mode', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Date', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Reference', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                    ]),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final t = transactions[index];
                        final isCredit = t['type'] == 'credit';
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                          child: Row(children: [
                            Container(
                              width: 32, height: 32,
                              decoration: BoxDecoration(color: isCredit ? const Color(0xFF10B981).withOpacity(0.1) : const Color(0xFFEF4444).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                              child: Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward, size: 16, color: isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444)),
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Text(t['id'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF0F766E)))),
                            Expanded(flex: 2, child: Text(t['desc'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                            Expanded(child: Text('${isCredit ? '+' : '-'}₹${t['amount']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w600, color: isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444)))),
                            Expanded(child: Text(t['mode'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                            Expanded(child: Text(t['date'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                            Expanded(child: Text(t['ref'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280)))),
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
}
