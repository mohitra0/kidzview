import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRExitPage extends StatelessWidget {
  const HRExitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exits = [
      {'name': 'Ravi Kumar', 'empId': 'EMP008', 'dept': 'Art', 'type': 'Resignation', 'lastDate': 'Feb 15, 2026', 'reason': 'Better opportunity', 'status': 'notice_period'},
      {'name': 'Sunita Devi', 'empId': 'EMP015', 'dept': 'Support', 'type': 'Retirement', 'lastDate': 'Mar 31, 2026', 'reason': 'Retirement at 60', 'status': 'pending'},
      {'name': 'Mohit Singh', 'empId': 'EMP022', 'dept': 'PT', 'type': 'Resignation', 'lastDate': 'Dec 31, 2025', 'reason': 'Personal reasons', 'status': 'completed'},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Exit Management', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Manage resignations and separations', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: Text('Exit Report', style: GoogleFonts.spaceGrotesk())),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Notice Period', '${exits.where((e) => e['status'] == 'notice_period').length}', Icons.schedule, const Color(0xFFF59E0B)),
              const SizedBox(width: 16),
              _buildStatCard('Pending', '${exits.where((e) => e['status'] == 'pending').length}', Icons.pending, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Completed', '${exits.where((e) => e['status'] == 'completed').length}', Icons.check_circle, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('This Year', '${exits.length}', Icons.people, const Color(0xFF7C3AED)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: exits.length,
              itemBuilder: (context, index) {
                final e = exits[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE5E7EB))),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 24, backgroundColor: const Color(0xFF7C3AED).withOpacity(0.1), child: Text((e['name'] as String)[0], style: GoogleFonts.spaceGrotesk(color: const Color(0xFF7C3AED), fontWeight: FontWeight.w600, fontSize: 18))),
                      const SizedBox(width: 16),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Text(e['name'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                          const SizedBox(width: 8),
                          Text(e['empId'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                        ]),
                        const SizedBox(height: 4),
                        Text('${e['dept']} • ${e['type']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                      ])),
                      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text('Last Date: ${e['lastDate']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Text(e['reason'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                      ]),
                      const SizedBox(width: 16),
                      _buildStatusBadge(e['status'] as String),
                      const SizedBox(width: 16),
                      IconButton(icon: const Icon(Icons.checklist, color: Color(0xFF7C3AED)), onPressed: () {}),
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

  Widget _buildStatusBadge(String status) {
    Color color;
    String label;
    switch (status) {
      case 'completed': color = const Color(0xFF10B981); label = 'COMPLETED'; break;
      case 'notice_period': color = const Color(0xFFF59E0B); label = 'NOTICE PERIOD'; break;
      default: color = const Color(0xFF3B82F6); label = 'PENDING';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
    );
  }
}
