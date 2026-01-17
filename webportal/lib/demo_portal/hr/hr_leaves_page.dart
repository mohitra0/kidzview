import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRLeavesPage extends StatefulWidget {
  const HRLeavesPage({super.key});

  @override
  State<HRLeavesPage> createState() => _HRLeavesPageState();
}

class _HRLeavesPageState extends State<HRLeavesPage> {
  final List<Map<String, dynamic>> _leaveRequests = [
    {'name': 'Neha Gupta', 'empId': 'EMP004', 'type': 'Casual', 'from': 'Jan 20', 'to': 'Jan 22', 'days': 3, 'reason': 'Family function', 'status': 'pending', 'applied': 'Jan 16'},
    {'name': 'Rahul Sharma', 'empId': 'EMP001', 'type': 'Sick', 'from': 'Jan 18', 'to': 'Jan 18', 'days': 1, 'reason': 'Fever', 'status': 'pending', 'applied': 'Jan 17'},
    {'name': 'Priya Patel', 'empId': 'EMP002', 'type': 'Earned', 'from': 'Feb 1', 'to': 'Feb 5', 'days': 5, 'reason': 'Vacation', 'status': 'pending', 'applied': 'Jan 15'},
    {'name': 'Amit Kumar', 'empId': 'EMP003', 'type': 'Casual', 'from': 'Jan 10', 'to': 'Jan 10', 'days': 1, 'reason': 'Personal work', 'status': 'approved', 'applied': 'Jan 8'},
    {'name': 'Suresh Verma', 'empId': 'EMP005', 'type': 'Sick', 'from': 'Jan 5', 'to': 'Jan 6', 'days': 2, 'reason': 'Medical appointment', 'status': 'rejected', 'applied': 'Jan 3'},
  ];

  @override
  Widget build(BuildContext context) {
    final pending = _leaveRequests.where((l) => l['status'] == 'pending').length;
    
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Leave Management', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Review and manage leave requests', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              if (pending > 0) Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  const Icon(Icons.warning, color: Color(0xFFF59E0B), size: 18),
                  const SizedBox(width: 8),
                  Text('$pending Pending Approvals', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, color: const Color(0xFFF59E0B))),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Total Requests', '${_leaveRequests.length}', Icons.event, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Pending', '$pending', Icons.pending, const Color(0xFFF59E0B)),
              const SizedBox(width: 16),
              _buildStatCard('Approved', '${_leaveRequests.where((l) => l['status'] == 'approved').length}', Icons.check_circle, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Rejected', '${_leaveRequests.where((l) => l['status'] == 'rejected').length}', Icons.cancel, const Color(0xFFEF4444)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(child: _buildLeaveTable()),
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

  Widget _buildLeaveTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Row(children: [
              Expanded(flex: 2, child: Text('Employee', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Type', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Duration', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(flex: 2, child: Text('Reason', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Applied', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              const SizedBox(width: 100),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _leaveRequests.length,
              itemBuilder: (context, index) {
                final l = _leaveRequests[index];
                final isPending = l['status'] == 'pending';
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: isPending ? const Color(0xFFFEFCE8) : null, border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(children: [
                    Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(l['name'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                      Text(l['empId'], style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
                    ])),
                    Expanded(child: _buildTypeBadge(l['type'])),
                    Expanded(child: Text('${l['from']} - ${l['to']} (${l['days']}d)', style: GoogleFonts.spaceGrotesk(fontSize: 12))),
                    Expanded(flex: 2, child: Text(l['reason'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: Text(l['applied'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: _buildStatusBadge(l['status'])),
                    SizedBox(width: 100, child: isPending ? Row(children: [
                      IconButton(icon: const Icon(Icons.check_circle, color: Color(0xFF10B981)), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.cancel, color: Color(0xFFEF4444)), onPressed: () {}),
                    ]) : const SizedBox()),
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge(String type) {
    Color color = type == 'Casual' ? const Color(0xFF3B82F6) : type == 'Sick' ? const Color(0xFFEF4444) : const Color(0xFF10B981);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Text(type.toUpperCase(), style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'approved': color = const Color(0xFF10B981); break;
      case 'rejected': color = const Color(0xFFEF4444); break;
      default: color = const Color(0xFFF59E0B);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(status.toUpperCase(), style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
    );
  }
}
