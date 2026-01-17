import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinanceExpensesPage extends StatefulWidget {
  const FinanceExpensesPage({super.key});

  @override
  State<FinanceExpensesPage> createState() => _FinanceExpensesPageState();
}

class _FinanceExpensesPageState extends State<FinanceExpensesPage> {
  final List<Map<String, dynamic>> _expenses = [
    {'title': 'Electricity Bill', 'category': 'Utilities', 'amount': 45000, 'date': 'Jan 15, 2026', 'status': 'paid', 'vendor': 'BSES'},
    {'title': 'Stationery Purchase', 'category': 'Supplies', 'amount': 12500, 'date': 'Jan 14, 2026', 'status': 'paid', 'vendor': 'ABC Supplies'},
    {'title': 'Computer Lab Maintenance', 'category': 'Maintenance', 'amount': 35000, 'date': 'Jan 12, 2026', 'status': 'pending', 'vendor': 'Tech Solutions'},
    {'title': 'Security Services', 'category': 'Services', 'amount': 65000, 'date': 'Jan 10, 2026', 'status': 'paid', 'vendor': 'SecureGuard'},
    {'title': 'Sports Equipment', 'category': 'Equipment', 'amount': 28000, 'date': 'Jan 8, 2026', 'status': 'approved', 'vendor': 'Sports World'},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Utilities', 'budget': 100000, 'spent': 78000, 'color': const Color(0xFF3B82F6)},
    {'name': 'Salaries', 'budget': 1200000, 'spent': 1128000, 'color': const Color(0xFF8B5CF6)},
    {'name': 'Maintenance', 'budget': 150000, 'spent': 95000, 'color': const Color(0xFFF59E0B)},
    {'name': 'Supplies', 'budget': 80000, 'spent': 52000, 'color': const Color(0xFF10B981)},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Expense Management', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Track and manage school expenses', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _showAddExpenseDialog,
                icon: const Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F766E), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                label: Text('Add Expense', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildExpensesList()),
              const SizedBox(width: 24),
              Expanded(child: _buildCategoryBreakdown()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesList() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Row(children: [
              Expanded(flex: 2, child: Text('Expense', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Category', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Amount', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Date', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
            ]),
          ),
          ..._expenses.map((e) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: Row(children: [
              Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(e['title'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                Text(e['vendor'], style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
              ])),
              Expanded(child: Text(e['category'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
              Expanded(child: Text('₹${e['amount']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w600))),
              Expanded(child: Text(e['date'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
              Expanded(child: _buildStatusBadge(e['status'])),
            ]),
          )),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Budget vs Spent', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          ..._categories.map((c) => _buildCategoryRow(c)),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(Map<String, dynamic> category) {
    final percent = (category['spent'] as int) / (category['budget'] as int);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(width: 12, height: 12, decoration: BoxDecoration(color: category['color'] as Color, borderRadius: BorderRadius.circular(3))),
            const SizedBox(width: 8),
            Expanded(child: Text(category['name'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500))),
            Text('${(percent * 100).toStringAsFixed(0)}%', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: percent, backgroundColor: const Color(0xFFE5E7EB), valueColor: AlwaysStoppedAnimation(percent > 0.9 ? const Color(0xFFEF4444) : category['color'] as Color), minHeight: 8),
          ),
          const SizedBox(height: 4),
          Text('₹${category['spent']} / ₹${category['budget']}', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color = status == 'paid' ? const Color(0xFF10B981) : status == 'approved' ? const Color(0xFF3B82F6) : const Color(0xFFF59E0B);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(status.toUpperCase(), style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
    );
  }

  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Expense', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
        content: SizedBox(
          width: 400,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Category', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), items: ['Utilities', 'Supplies', 'Maintenance', 'Services', 'Equipment'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (_) {}),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Amount', prefixText: '₹ ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Vendor', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.spaceGrotesk())),
          ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F766E)), child: Text('Add', style: GoogleFonts.spaceGrotesk(color: Colors.white))),
        ],
      ),
    );
  }
}
