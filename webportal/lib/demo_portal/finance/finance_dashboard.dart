import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'finance_fees_page.dart';
import 'finance_expenses_page.dart';
import 'finance_payroll_page.dart';
import 'finance_invoices_page.dart';
import 'finance_payments_page.dart';
import 'finance_reports_page.dart';
import 'finance_budget_page.dart';
import 'finance_vendors_page.dart';
import 'finance_tax_page.dart';

class FinanceDashboard extends StatefulWidget {
  const FinanceDashboard({super.key});

  @override
  State<FinanceDashboard> createState() => _FinanceDashboardState();
}

class _FinanceDashboardState extends State<FinanceDashboard> {
  int _selectedIndex = 0;
  
  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.dashboard, 'label': 'Dashboard'},
    {'icon': Icons.school, 'label': 'Fee Management'},
    {'icon': Icons.receipt_long, 'label': 'Expenses'},
    {'icon': Icons.payments, 'label': 'Payroll'},
    {'icon': Icons.description, 'label': 'Invoices'},
    {'icon': Icons.account_balance_wallet, 'label': 'Payments'},
    {'icon': Icons.assessment, 'label': 'Reports'},
    {'icon': Icons.pie_chart, 'label': 'Budget'},
    {'icon': Icons.store, 'label': 'Vendors'},
    {'icon': Icons.calculate, 'label': 'Tax & Compliance'},
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          _buildSidebar(isWide),
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _buildSidebar(bool isWide) {
    return Container(
      width: isWide ? 260 : 80,
      decoration: BoxDecoration(
        color: const Color(0xFF0F766E),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isWide ? 24 : 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF14B8A6), Color(0xFF0D9488)]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.account_balance, color: Colors.white, size: 24),
                ),
                if (isWide) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MCP Portal', style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                        Text('Finance Manager', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.white60)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(height: 1, color: Colors.white12),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              padding: EdgeInsets.symmetric(horizontal: isWide ? 16 : 8),
              itemBuilder: (context, index) => _buildMenuItem(_menuItems[index], _selectedIndex == index, index, isWide),
            ),
          ),
          _buildUserProfile(isWide),
        ],
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item, bool isSelected, int index, bool isWide) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => setState(() => _selectedIndex = index),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: isWide ? 16 : 12, vertical: 12),
            child: Row(
              children: [
                Icon(item['icon'], color: isSelected ? const Color(0xFF5EEAD4) : Colors.white60, size: 22),
                if (isWide) ...[
                  const SizedBox(width: 12),
                  Text(item['label'], style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500, color: isSelected ? Colors.white : Colors.white70)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(bool isWide) {
    return Container(
      padding: EdgeInsets.all(isWide ? 20 : 12),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white12))),
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundColor: const Color(0xFF14B8A6), child: Text('FM', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600))),
          if (isWide) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Suresh Kumar', style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                  Text('finance@mcpschool.com', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white60)),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.logout, size: 20, color: Colors.white60), onPressed: () => Navigator.of(context).pop()),
          ],
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 1: return const FinanceFeesPage();
      case 2: return const FinanceExpensesPage();
      case 3: return const FinancePayrollPage();
      case 4: return const FinanceInvoicesPage();
      case 5: return const FinancePaymentsPage();
      case 6: return const FinanceReportsPage();
      case 7: return const FinanceBudgetPage();
      case 8: return const FinanceVendorsPage();
      case 9: return const FinanceTaxPage();
      default: return _buildDashboardHome();
    }
  }

  Widget _buildDashboardHome() {
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
                  Text('Finance Dashboard', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('Financial overview for Academic Year 2025-26', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10), color: Colors.white),
                child: DropdownButton<String>(
                  value: 'This Month',
                  underline: const SizedBox(),
                  items: ['Today', 'This Week', 'This Month', 'This Quarter', 'This Year'].map((p) => DropdownMenuItem(value: p, child: Text(p, style: GoogleFonts.spaceGrotesk()))).toList(),
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildFinanceStats(),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildRevenueChart()),
              const SizedBox(width: 24),
              Expanded(child: _buildPendingActions()),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildRecentTransactions()),
              const SizedBox(width: 24),
              Expanded(child: _buildFeeCollection()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinanceStats() {
    final stats = [
      {'title': 'Total Revenue', 'value': '₹45.8L', 'change': '+12%', 'icon': Icons.trending_up, 'color': const Color(0xFF10B981)},
      {'title': 'Fee Collected', 'value': '₹38.2L', 'change': '+8%', 'icon': Icons.school, 'color': const Color(0xFF3B82F6)},
      {'title': 'Pending Fees', 'value': '₹7.6L', 'change': '-15%', 'icon': Icons.pending, 'color': const Color(0xFFF59E0B)},
      {'title': 'Expenses', 'value': '₹28.4L', 'change': '+5%', 'icon': Icons.receipt_long, 'color': const Color(0xFFEF4444)},
      {'title': 'Profit', 'value': '₹17.4L', 'change': '+18%', 'icon': Icons.account_balance, 'color': const Color(0xFF8B5CF6)},
      {'title': 'Payroll Due', 'value': '₹12.8L', 'change': '', 'icon': Icons.payments, 'color': const Color(0xFF06B6D4)},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2.5, crossAxisSpacing: 16, mainAxisSpacing: 16),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: (stat['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(stat['icon'] as IconData, color: stat['color'] as Color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(stat['value'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.w700)),
                    Row(
                      children: [
                        Flexible(child: Text(stat['title'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280)), overflow: TextOverflow.ellipsis)),
                        if ((stat['change'] as String).isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(stat['change'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: (stat['change'] as String).startsWith('-') ? const Color(0xFF10B981) : const Color(0xFF10B981), fontWeight: FontWeight.w600)),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Revenue vs Expenses', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
              const Spacer(),
              Row(
                children: [
                  Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFF10B981), borderRadius: BorderRadius.circular(3))),
                  const SizedBox(width: 6),
                  Text('Revenue', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                  const SizedBox(width: 16),
                  Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFFEF4444), borderRadius: BorderRadius.circular(3))),
                  const SizedBox(width: 6),
                  Text('Expenses', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildDoubleBar('Apr', 0.6, 0.4),
                _buildDoubleBar('May', 0.7, 0.45),
                _buildDoubleBar('Jun', 0.5, 0.35),
                _buildDoubleBar('Jul', 0.8, 0.5),
                _buildDoubleBar('Aug', 0.9, 0.55),
                _buildDoubleBar('Sep', 0.85, 0.48),
                _buildDoubleBar('Oct', 0.75, 0.42),
                _buildDoubleBar('Nov', 0.82, 0.52),
                _buildDoubleBar('Dec', 0.7, 0.45),
                _buildDoubleBar('Jan', 0.95, 0.58),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoubleBar(String label, double revenue, double expense) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(width: 12, height: 160 * revenue, decoration: BoxDecoration(color: const Color(0xFF10B981), borderRadius: BorderRadius.circular(4))),
                const SizedBox(width: 2),
                Container(width: 12, height: 160 * expense, decoration: BoxDecoration(color: const Color(0xFFEF4444), borderRadius: BorderRadius.circular(4))),
              ],
            ),
            const SizedBox(height: 8),
            Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 10, color: const Color(0xFF6B7280))),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingActions() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pending Actions', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          _buildActionItem('Approve 12 invoices', Icons.description, const Color(0xFF3B82F6), '₹2.4L'),
          _buildActionItem('Process payroll', Icons.payments, const Color(0xFFF59E0B), '₹12.8L'),
          _buildActionItem('42 fee reminders', Icons.notifications, const Color(0xFFEF4444), '₹7.6L'),
          _buildActionItem('5 vendor payments', Icons.store, const Color(0xFF8B5CF6), '₹1.8L'),
        ],
      ),
    );
  }

  Widget _buildActionItem(String title, IconData icon, Color color, String amount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w500))),
          Text(amount, style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    final transactions = [
      {'title': 'Fee - Aarav Sharma', 'type': 'credit', 'amount': '₹25,000', 'date': 'Today, 10:30 AM'},
      {'title': 'Salary - Rahul Sharma', 'type': 'debit', 'amount': '₹45,000', 'date': 'Yesterday'},
      {'title': 'Fee - Ananya Patel', 'type': 'credit', 'amount': '₹25,000', 'date': 'Jan 14'},
      {'title': 'Vendor - ABC Supplies', 'type': 'debit', 'amount': '₹8,500', 'date': 'Jan 13'},
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Recent Transactions', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
              const Spacer(),
              TextButton(onPressed: () => setState(() => _selectedIndex = 5), child: Text('View All', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF0F766E)))),
            ],
          ),
          const SizedBox(height: 16),
          ...transactions.map((t) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: t['type'] == 'credit' ? const Color(0xFF10B981).withOpacity(0.1) : const Color(0xFFEF4444).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(t['type'] == 'credit' ? Icons.arrow_downward : Icons.arrow_upward, color: t['type'] == 'credit' ? const Color(0xFF10B981) : const Color(0xFFEF4444), size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t['title'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500, fontSize: 13)),
                      Text(t['date'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF9CA3AF))),
                    ],
                  ),
                ),
                Text(t['amount'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, color: t['type'] == 'credit' ? const Color(0xFF10B981) : const Color(0xFFEF4444))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFeeCollection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fee Collection Status', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          _buildFeeRow('Q1 (Apr-Jun)', '100%', 1.0, const Color(0xFF10B981)),
          _buildFeeRow('Q2 (Jul-Sep)', '100%', 1.0, const Color(0xFF10B981)),
          _buildFeeRow('Q3 (Oct-Dec)', '92%', 0.92, const Color(0xFF3B82F6)),
          _buildFeeRow('Q4 (Jan-Mar)', '78%', 0.78, const Color(0xFFF59E0B)),
        ],
      ),
    );
  }

  Widget _buildFeeRow(String quarter, String percent, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(quarter, style: GoogleFonts.spaceGrotesk(fontSize: 13)),
              const Spacer(),
              Text(percent, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, color: color)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: value, backgroundColor: const Color(0xFFE5E7EB), valueColor: AlwaysStoppedAnimation(color), minHeight: 8),
          ),
        ],
      ),
    );
  }
}
