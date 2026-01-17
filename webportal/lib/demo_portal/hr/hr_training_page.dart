import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRTrainingPage extends StatelessWidget {
  const HRTrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final trainings = [
      {'title': 'Digital Classroom Tools', 'type': 'Mandatory', 'date': 'Jan 25, 2026', 'duration': '2 days', 'enrolled': 45, 'completed': 0, 'status': 'upcoming'},
      {'title': 'NEP 2020 Implementation', 'type': 'Mandatory', 'date': 'Feb 10, 2026', 'duration': '1 day', 'enrolled': 68, 'completed': 0, 'status': 'upcoming'},
      {'title': 'Child Psychology Workshop', 'type': 'Optional', 'date': 'Feb 20, 2026', 'duration': '3 days', 'enrolled': 28, 'completed': 0, 'status': 'upcoming'},
      {'title': 'First Aid Training', 'type': 'Mandatory', 'date': 'Dec 15, 2025', 'duration': '1 day', 'enrolled': 68, 'completed': 65, 'status': 'completed'},
      {'title': 'Innovative Teaching Methods', 'type': 'Optional', 'date': 'Nov 20, 2025', 'duration': '2 days', 'enrolled': 35, 'completed': 32, 'status': 'completed'},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Training & Development', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Manage professional development programs', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, color: Colors.white), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED)), label: Text('Schedule Training', style: GoogleFonts.spaceGrotesk(color: Colors.white))),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Upcoming', '${trainings.where((t) => t['status'] == 'upcoming').length}', Icons.schedule, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Total Enrolled', '141', Icons.people, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Completed', '${trainings.where((t) => t['status'] == 'completed').length}', Icons.check_circle, const Color(0xFF7C3AED)),
              const SizedBox(width: 16),
              _buildStatCard('Mandatory Pending', '2', Icons.warning, const Color(0xFFF59E0B)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: trainings.length,
              itemBuilder: (context, index) {
                final t = trainings[index];
                final isUpcoming = t['status'] == 'upcoming';
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE5E7EB))),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: isUpcoming ? const Color(0xFF7C3AED).withOpacity(0.1) : const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                        child: Icon(Icons.school, color: isUpcoming ? const Color(0xFF7C3AED) : const Color(0xFF10B981), size: 28),
                      ),
                      const SizedBox(width: 20),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Text(t['title'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: t['type'] == 'Mandatory' ? const Color(0xFFEF4444).withOpacity(0.1) : const Color(0xFF6B7280).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                            child: Text(t['type'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: t['type'] == 'Mandatory' ? const Color(0xFFEF4444) : const Color(0xFF6B7280))),
                          ),
                        ]),
                        const SizedBox(height: 6),
                        Text('${t['date']} • ${t['duration']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                      ])),
                      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text('${t['enrolled']} enrolled', style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w600)),
                        if (!isUpcoming) Text('${t['completed']} completed', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF10B981))),
                      ]),
                      const SizedBox(width: 16),
                      isUpcoming ? OutlinedButton(onPressed: () {}, child: Text('Manage', style: GoogleFonts.spaceGrotesk())) : const Icon(Icons.check_circle, color: Color(0xFF10B981)),
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
            Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
            Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
          ]),
        ]),
      ),
    );
  }
}
