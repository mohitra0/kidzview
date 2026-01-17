import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinanceFeesPage extends StatefulWidget {
  const FinanceFeesPage({super.key});

  @override
  State<FinanceFeesPage> createState() => _FinanceFeesPageState();
}

class _FinanceFeesPageState extends State<FinanceFeesPage> {
  String _selectedClass = 'All Classes';
  String _selectedStatus = 'All Status';

  final List<Map<String, dynamic>> _fees = [
    {'student': 'Aarav Sharma', 'class': '5A', 'amount': 25000, 'paid': 25000, 'due': 0, 'status': 'paid', 'dueDate': 'Jan 10'},
    {'student': 'Ananya Patel', 'class': '5A', 'amount': 25000, 'paid': 25000, 'due': 0, 'status': 'paid', 'dueDate': 'Jan 10'},
    {'student': 'Arjun Singh', 'class': '5A', 'amount': 25000, 'paid': 15000, 'due': 10000, 'status': 'partial', 'dueDate': 'Jan 10'},
    {'student': 'Diya Gupta', 'class': '6B', 'amount': 28000, 'paid': 0, 'due': 28000, 'status': 'pending', 'dueDate': 'Jan 15'},
    {'student': 'Ishaan Kumar', 'class': '6B', 'amount': 28000, 'paid': 28000, 'due': 0, 'status': 'paid', 'dueDate': 'Jan 15'},
    {'student': 'Kavya Reddy', 'class': '7A', 'amount': 30000, 'paid': 0, 'due': 30000, 'status': 'overdue', 'dueDate': 'Dec 15'},
  ];

  @override
  Widget build(BuildContext context) {
    final totalFees = _fees.fold<int>(0, (s, f) => s + (f['amount'] as int));
    final collected = _fees.fold<int>(0, (s, f) => s + (f['paid'] as int));
    final pending = _fees.fold<int>(0, (s, f) => s + (f['due'] as int));

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fee Management', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('Track and manage student fees', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.notifications), label: Text('Send Reminders', style: GoogleFonts.spaceGrotesk())),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _showCollectFeeDialog,
                icon: const Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F766E), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                label: Text('Collect Fee', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Total Fees', '₹${(totalFees / 1000).toStringAsFixed(0)}K', Icons.currency_rupee, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Collected', '₹${(collected / 1000).toStringAsFixed(0)}K', Icons.check_circle, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Pending', '₹${(pending / 1000).toStringAsFixed(0)}K', Icons.pending, const Color(0xFFF59E0B)),
              const SizedBox(width: 16),
              _buildStatCard('Overdue', '₹30K', Icons.warning, const Color(0xFFEF4444)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildFilterDropdown('Class', _selectedClass, ['All Classes', 'Class 5A', 'Class 5B', 'Class 6A', 'Class 6B', 'Class 7A'], (v) => setState(() => _selectedClass = v!)),
              const SizedBox(width: 16),
              _buildFilterDropdown('Status', _selectedStatus, ['All Status', 'Paid', 'Partial', 'Pending', 'Overdue'], (v) => setState(() => _selectedStatus = v!)),
              const Spacer(),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: Text('Export', style: GoogleFonts.spaceGrotesk())),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(child: _buildFeesTable()),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE5E7EB))),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 22)),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
              Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<String>(value: value, underline: const SizedBox(), items: items.map((i) => DropdownMenuItem(value: i, child: Text(i, style: GoogleFonts.spaceGrotesk()))).toList(), onChanged: onChanged),
    );
  }

  Widget _buildFeesTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text('Student', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Class', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Total', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Paid', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Due', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Due Date', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                const SizedBox(width: 100),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _fees.length,
              itemBuilder: (context, index) {
                final f = _fees[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(f['student'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500))),
                      Expanded(child: Text(f['class'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                      Expanded(child: Text('₹${f['amount']}', style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                      Expanded(child: Text('₹${f['paid']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF10B981)))),
                      Expanded(child: Text('₹${f['due']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: f['due'] > 0 ? const Color(0xFFEF4444) : const Color(0xFF6B7280)))),
                      Expanded(child: Text(f['dueDate'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                      Expanded(child: _buildStatusBadge(f['status'])),
                      SizedBox(width: 100, child: Row(children: [
                        IconButton(icon: const Icon(Icons.receipt, size: 18), onPressed: () {}, color: const Color(0xFF0F766E)),
                        IconButton(icon: const Icon(Icons.payment, size: 18), onPressed: () => _showCollectFeeDialog(), color: const Color(0xFF3B82F6)),
                      ])),
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

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'paid': color = const Color(0xFF10B981); break;
      case 'partial': color = const Color(0xFF3B82F6); break;
      case 'pending': color = const Color(0xFFF59E0B); break;
      default: color = const Color(0xFFEF4444);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(status.toUpperCase(), style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
    );
  }

  void _showCollectFeeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Collect Fee', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Student', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), items: _fees.map((f) => DropdownMenuItem(value: f['student'] as String, child: Text(f['student'] as String))).toList(), onChanged: (_) {}),
              const SizedBox(height: 16),
              TextField(decoration: InputDecoration(labelText: 'Amount', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Payment Mode', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), items: ['Cash', 'UPI', 'Bank Transfer', 'Cheque'].map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(), onChanged: (_) {}),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.spaceGrotesk())),
          ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F766E)), child: Text('Collect', style: GoogleFonts.spaceGrotesk(color: Colors.white))),
        ],
      ),
    );
  }
}
