import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinanceVendorsPage extends StatefulWidget {
  const FinanceVendorsPage({super.key});

  @override
  State<FinanceVendorsPage> createState() => _FinanceVendorsPageState();
}

class _FinanceVendorsPageState extends State<FinanceVendorsPage> {
  final List<Map<String, dynamic>> _vendors = [
    {'name': 'ABC Supplies', 'category': 'Stationery', 'contact': '9876543210', 'email': 'abc@vendor.com', 'pending': 45000, 'ytd': 285000, 'status': 'active'},
    {'name': 'Tech Solutions', 'category': 'IT Services', 'contact': '9876543211', 'email': 'tech@vendor.com', 'pending': 85000, 'ytd': 420000, 'status': 'active'},
    {'name': 'Sports World', 'category': 'Sports Equipment', 'contact': '9876543212', 'email': 'sports@vendor.com', 'pending': 0, 'ytd': 156000, 'status': 'active'},
    {'name': 'BSES Delhi', 'category': 'Utilities', 'contact': '1800-180-0000', 'email': 'support@bses.com', 'pending': 65000, 'ytd': 540000, 'status': 'active'},
    {'name': 'Furniture House', 'category': 'Furniture', 'contact': '9876543214', 'email': 'furniture@vendor.com', 'pending': 120000, 'ytd': 320000, 'status': 'payment_due'},
    {'name': 'SecureGuard Services', 'category': 'Security', 'contact': '9876543215', 'email': 'secure@vendor.com', 'pending': 0, 'ytd': 780000, 'status': 'active'},
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
                Text('Vendor Management', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Manage suppliers and vendor payments', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _showAddVendorDialog,
                icon: const Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F766E), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                label: Text('Add Vendor', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Total Vendors', '${_vendors.length}', Icons.store, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Pending Payments', '₹3.1L', Icons.pending, const Color(0xFFF59E0B)),
              const SizedBox(width: 16),
              _buildStatCard('YTD Payments', '₹25L', Icons.trending_up, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Active', '${_vendors.where((v) => v['status'] == 'active').length}', Icons.check_circle, const Color(0xFF8B5CF6)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(child: _buildVendorsTable()),
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

  Widget _buildVendorsTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Row(children: [
              Expanded(flex: 2, child: Text('Vendor', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Category', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Contact', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Pending', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('YTD Paid', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              const SizedBox(width: 80),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _vendors.length,
              itemBuilder: (context, index) {
                final v = _vendors[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(children: [
                    Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(v['name'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                      Text(v['email'], style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                    ])),
                    Expanded(child: Text(v['category'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: Text(v['contact'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: Text(v['pending'] > 0 ? '₹${v['pending']}' : '-', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: v['pending'] > 0 ? const Color(0xFFEF4444) : const Color(0xFF6B7280)))),
                    Expanded(child: Text('₹${(v['ytd'] / 1000).toStringAsFixed(0)}K', style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: _buildStatusBadge(v['status'])),
                    SizedBox(width: 80, child: Row(children: [
                      if (v['pending'] > 0) IconButton(icon: const Icon(Icons.payment, size: 18), onPressed: () {}, color: const Color(0xFF0F766E)),
                      IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}, color: const Color(0xFF6B7280)),
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
    final isActive = status == 'active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: isActive ? const Color(0xFF10B981).withOpacity(0.1) : const Color(0xFFF59E0B).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(isActive ? 'ACTIVE' : 'PAYMENT DUE', style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: isActive ? const Color(0xFF10B981) : const Color(0xFFF59E0B))),
    );
  }

  void _showAddVendorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Vendor', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
        content: SizedBox(
          width: 400,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(decoration: InputDecoration(labelText: 'Vendor Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Category', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), items: ['Stationery', 'IT Services', 'Utilities', 'Furniture', 'Security'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (_) {}),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Contact Number', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
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
