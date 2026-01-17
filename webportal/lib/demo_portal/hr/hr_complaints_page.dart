import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRComplaintsPage extends StatelessWidget {
  const HRComplaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final complaints = [
      {'id': 'GRV001', 'from': 'Anonymous', 'subject': 'Unfair workload distribution', 'date': 'Jan 15', 'priority': 'high', 'status': 'open'},
      {'id': 'GRV002', 'from': 'Rahul Sharma', 'subject': 'AC not working in staff room', 'date': 'Jan 12', 'priority': 'medium', 'status': 'in_progress'},
      {'id': 'GRV003', 'from': 'Anonymous', 'subject': 'Request for flexible timing', 'date': 'Jan 10', 'priority': 'low', 'status': 'open'},
      {'id': 'GRV004', 'from': 'Priya Patel', 'subject': 'Parking space issue', 'date': 'Jan 5', 'priority': 'low', 'status': 'resolved'},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Complaints & Grievances', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Handle employee concerns and complaints', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(color: const Color(0xFFEF4444).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  const Icon(Icons.warning, color: Color(0xFFEF4444), size: 18),
                  const SizedBox(width: 8),
                  Text('${complaints.where((c) => c['status'] == 'open').length} Open', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, color: const Color(0xFFEF4444))),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: complaints.length,
              itemBuilder: (context, index) {
                final c = complaints[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: c['priority'] == 'high' ? const Color(0xFFEF4444).withOpacity(0.3) : const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: _getPriorityColor(c['priority'] as String).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                        child: Icon(Icons.report_problem, color: _getPriorityColor(c['priority'] as String)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Text(c['id'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF7C3AED), fontWeight: FontWeight.w600)),
                          const SizedBox(width: 12),
                          _buildPriorityBadge(c['priority'] as String),
                        ]),
                        const SizedBox(height: 4),
                        Text(c['subject'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text('From: ${c['from']} • ${c['date']}', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                      ])),
                      _buildStatusBadge(c['status'] as String),
                      const SizedBox(width: 16),
                      if (c['status'] != 'resolved') OutlinedButton(onPressed: () {}, child: Text('Action', style: GoogleFonts.spaceGrotesk())),
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

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high': return const Color(0xFFEF4444);
      case 'medium': return const Color(0xFFF59E0B);
      default: return const Color(0xFF6B7280);
    }
  }

  Widget _buildPriorityBadge(String priority) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: _getPriorityColor(priority).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Text(priority.toUpperCase(), style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: _getPriorityColor(priority))),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    String label;
    switch (status) {
      case 'resolved': color = const Color(0xFF10B981); label = 'RESOLVED'; break;
      case 'in_progress': color = const Color(0xFF3B82F6); label = 'IN PROGRESS'; break;
      default: color = const Color(0xFFF59E0B); label = 'OPEN';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
    );
  }
}
