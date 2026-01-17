import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRAnnouncementsPage extends StatefulWidget {
  const HRAnnouncementsPage({super.key});

  @override
  State<HRAnnouncementsPage> createState() => _HRAnnouncementsPageState();
}

class _HRAnnouncementsPageState extends State<HRAnnouncementsPage> {
  final List<Map<String, dynamic>> _announcements = [
    {'title': 'Republic Day Celebration', 'content': 'All staff to assemble by 8:00 AM on January 26th for flag hoisting ceremony.', 'date': 'Jan 17, 2026', 'target': 'All Staff', 'pinned': true},
    {'title': 'Salary Credit - January', 'content': 'January salaries have been processed and will be credited by January 28th.', 'date': 'Jan 16, 2026', 'target': 'All Staff', 'pinned': false},
    {'title': 'Staff Meeting', 'content': 'Monthly staff meeting scheduled for January 18th at 10:00 AM in Conference Room.', 'date': 'Jan 15, 2026', 'target': 'All Staff', 'pinned': false},
    {'title': 'Training Program Update', 'content': 'Digital Classroom Tools training confirmed for January 25-26. Attendance is mandatory.', 'date': 'Jan 14, 2026', 'target': 'Teachers Only', 'pinned': false},
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
                Text('Internal Announcements', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Communicate with all staff members', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              ElevatedButton.icon(onPressed: _showCreateAnnouncementDialog, icon: const Icon(Icons.add, color: Colors.white), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED)), label: Text('New Announcement', style: GoogleFonts.spaceGrotesk(color: Colors.white))),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _announcements.length,
              itemBuilder: (context, index) {
                final a = _announcements[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: a['pinned'] == true ? const Color(0xFF7C3AED).withOpacity(0.3) : const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (a['pinned'] == true) ...[
                            const Icon(Icons.push_pin, color: Color(0xFF7C3AED), size: 18),
                            const SizedBox(width: 8),
                          ],
                          Expanded(child: Text(a['title'], style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w700))),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: const Color(0xFF7C3AED).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                            child: Text(a['target'], style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF7C3AED))),
                          ),
                          const SizedBox(width: 8),
                          IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}, color: const Color(0xFF6B7280)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(a['content'], style: GoogleFonts.spaceGrotesk(fontSize: 14, color: const Color(0xFF374151))),
                      const SizedBox(height: 12),
                      Text('Posted: ${a['date']}', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
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

  void _showCreateAnnouncementDialog() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('New Announcement', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
      content: SizedBox(width: 450, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
        const SizedBox(height: 16),
        TextField(decoration: InputDecoration(labelText: 'Content', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), maxLines: 4),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Target Audience', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), items: ['All Staff', 'Teachers Only', 'Admin Staff', 'Support Staff'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (_) {}),
        const SizedBox(height: 16),
        Row(children: [
          Checkbox(value: false, onChanged: (_) {}, activeColor: const Color(0xFF7C3AED)),
          Text('Pin to top', style: GoogleFonts.spaceGrotesk()),
        ]),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.spaceGrotesk())),
        ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED)), child: Text('Post', style: GoogleFonts.spaceGrotesk(color: Colors.white))),
      ],
    ));
  }
}
