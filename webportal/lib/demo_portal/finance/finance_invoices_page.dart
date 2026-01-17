import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinanceInvoicesPage extends StatefulWidget {
  const FinanceInvoicesPage({super.key});

  @override
  State<FinanceInvoicesPage> createState() => _FinanceInvoicesPageState();
}

class _FinanceInvoicesPageState extends State<FinanceInvoicesPage> {
  final List<Map<String, dynamic>> _invoices = [
    {'id': 'INV-2026-001', 'vendor': 'ABC Supplies', 'amount': 45000, 'date': 'Jan 15, 2026', 'due': 'Jan 30, 2026', 'status': 'pending'},
    {'id': 'INV-2026-002', 'vendor': 'Tech Solutions', 'amount': 85000, 'date': 'Jan 12, 2026', 'due': 'Jan 27, 2026', 'status': 'approved'},
    {'id': 'INV-2026-003', 'vendor': 'Sports World', 'amount': 28000, 'date': 'Jan 10, 2026', 'due': 'Jan 25, 2026', 'status': 'paid'},
    {'id': 'INV-2026-004', 'vendor': 'BSES Delhi', 'amount': 65000, 'date': 'Jan 8, 2026', 'due': 'Jan 23, 2026', 'status': 'paid'},
    {'id': 'INV-2026-005', 'vendor': 'Furniture House', 'amount': 120000, 'date': 'Jan 5, 2026', 'due': 'Jan 20, 2026', 'status': 'overdue'},
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
                Text('Invoice Management', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Manage vendor invoices and approvals', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.upload_file), label: Text('Upload Invoice', style: GoogleFonts.spaceGrotesk())),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F766E), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                label: Text('Create Invoice', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Total Invoices', '${_invoices.length}', Icons.description, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Pending Approval', '${_invoices.where((i) => i['status'] == 'pending').length}', Icons.pending, const Color(0xFFF59E0B)),
              const SizedBox(width: 16),
              _buildStatCard('Overdue', '${_invoices.where((i) => i['status'] == 'overdue').length}', Icons.warning, const Color(0xFFEF4444)),
              const SizedBox(width: 16),
              _buildStatCard('Total Value', '₹3.4L', Icons.currency_rupee, const Color(0xFF10B981)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(child: _buildInvoicesTable()),
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

  Widget _buildInvoicesTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Row(children: [
              Expanded(child: Text('Invoice #', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(flex: 2, child: Text('Vendor', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Amount', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Invoice Date', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Due Date', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              const SizedBox(width: 120),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _invoices.length,
              itemBuilder: (context, index) {
                final inv = _invoices[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(children: [
                    Expanded(child: Text(inv['id'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500, color: const Color(0xFF0F766E)))),
                    Expanded(flex: 2, child: Text(inv['vendor'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: Text('₹${inv['amount']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w600))),
                    Expanded(child: Text(inv['date'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: Text(inv['due'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: _buildStatusBadge(inv['status'])),
                    SizedBox(width: 120, child: Row(children: [
                      if (inv['status'] == 'pending') IconButton(icon: const Icon(Icons.check, size: 18), onPressed: () {}, color: const Color(0xFF10B981)),
                      IconButton(icon: const Icon(Icons.visibility, size: 18), onPressed: () {}, color: const Color(0xFF6B7280)),
                      IconButton(icon: const Icon(Icons.download, size: 18), onPressed: () {}, color: const Color(0xFF3B82F6)),
                    ])),
                  ]),
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
      case 'approved': color = const Color(0xFF3B82F6); break;
      case 'pending': color = const Color(0xFFF59E0B); break;
      default: color = const Color(0xFFEF4444);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(status.toUpperCase(), style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
    );
  }
}
