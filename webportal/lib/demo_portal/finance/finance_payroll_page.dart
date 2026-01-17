import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinancePayrollPage extends StatefulWidget {
  const FinancePayrollPage({super.key});

  @override
  State<FinancePayrollPage> createState() => _FinancePayrollPageState();
}

class _FinancePayrollPageState extends State<FinancePayrollPage> {
  String _selectedMonth = 'January 2026';

  final List<Map<String, dynamic>> _employees = [
    {'name': 'Rahul Sharma', 'role': 'Teacher', 'department': 'Mathematics', 'basic': 45000, 'hra': 9000, 'deductions': 5400, 'net': 48600, 'status': 'pending'},
    {'name': 'Priya Patel', 'role': 'Teacher', 'department': 'Science', 'basic': 42000, 'hra': 8400, 'deductions': 5040, 'net': 45360, 'status': 'pending'},
    {'name': 'Amit Kumar', 'role': 'Teacher', 'department': 'English', 'basic': 40000, 'hra': 8000, 'deductions': 4800, 'net': 43200, 'status': 'paid'},
    {'name': 'Neha Gupta', 'role': 'Admin', 'department': 'Office', 'basic': 35000, 'hra': 7000, 'deductions': 4200, 'net': 37800, 'status': 'paid'},
    {'name': 'Suresh Verma', 'role': 'Peon', 'department': 'Support', 'basic': 18000, 'hra': 3600, 'deductions': 2160, 'net': 19440, 'status': 'pending'},
  ];

  @override
  Widget build(BuildContext context) {
    final totalPayroll = _employees.fold<int>(0, (s, e) => s + (e['net'] as int));
    final pending = _employees.where((e) => e['status'] == 'pending').fold<int>(0, (s, e) => s + (e['net'] as int));

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Payroll Management', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Process employee salaries', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(value: _selectedMonth, underline: const SizedBox(), items: ['December 2025', 'January 2026', 'February 2026'].map((m) => DropdownMenuItem(value: m, child: Text(m, style: GoogleFonts.spaceGrotesk()))).toList(), onChanged: (v) => setState(() => _selectedMonth = v!)),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.payments, color: Colors.white),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F766E), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                label: Text('Process All', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Total Payroll', '₹${(totalPayroll / 1000).toStringAsFixed(0)}K', Icons.account_balance_wallet, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Pending', '₹${(pending / 1000).toStringAsFixed(0)}K', Icons.pending, const Color(0xFFF59E0B)),
              const SizedBox(width: 16),
              _buildStatCard('Employees', '${_employees.length}', Icons.people, const Color(0xFF8B5CF6)),
              const SizedBox(width: 16),
              _buildStatCard('Teachers', '${_employees.where((e) => e['role'] == 'Teacher').length}', Icons.school, const Color(0xFF10B981)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(child: _buildPayrollTable()),
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

  Widget _buildPayrollTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Row(children: [
              Expanded(flex: 2, child: Text('Employee', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Role', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Basic', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('HRA', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Deductions', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Net Pay', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              const SizedBox(width: 80),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _employees.length,
              itemBuilder: (context, index) {
                final e = _employees[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(children: [
                    Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(e['name'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                      Text(e['department'], style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                    ])),
                    Expanded(child: Text(e['role'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: Text('₹${e['basic']}', style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: Text('₹${e['hra']}', style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: Text('-₹${e['deductions']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFFEF4444)))),
                    Expanded(child: Text('₹${e['net']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF10B981)))),
                    Expanded(child: _buildStatusBadge(e['status'])),
                    SizedBox(width: 80, child: e['status'] == 'pending' ? TextButton(onPressed: () {}, child: Text('Pay', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF0F766E)))) : const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 20)),
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
    final isPaid = status == 'paid';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: isPaid ? const Color(0xFF10B981).withOpacity(0.1) : const Color(0xFFF59E0B).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(status.toUpperCase(), style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: isPaid ? const Color(0xFF10B981) : const Color(0xFFF59E0B))),
    );
  }
}
