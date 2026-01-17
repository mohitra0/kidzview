import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRRecruitmentPage extends StatefulWidget {
  const HRRecruitmentPage({super.key});

  @override
  State<HRRecruitmentPage> createState() => _HRRecruitmentPageState();
}

class _HRRecruitmentPageState extends State<HRRecruitmentPage> {
  final List<Map<String, dynamic>> _jobs = [
    {'title': 'Science Teacher', 'dept': 'Science', 'type': 'Full-time', 'posted': 'Jan 10', 'apps': 12, 'status': 'active'},
    {'title': 'Mathematics Teacher', 'dept': 'Mathematics', 'type': 'Full-time', 'posted': 'Jan 5', 'apps': 8, 'status': 'active'},
    {'title': 'Art Teacher', 'dept': 'Art', 'type': 'Part-time', 'posted': 'Dec 20', 'apps': 5, 'status': 'active'},
    {'title': 'Librarian', 'dept': 'Admin', 'type': 'Full-time', 'posted': 'Dec 15', 'apps': 3, 'status': 'active'},
    {'title': 'Computer Teacher', 'dept': 'Computer', 'type': 'Full-time', 'posted': 'Nov 1', 'apps': 15, 'status': 'closed'},
  ];

  final List<Map<String, dynamic>> _applications = [
    {'name': 'Anjali Sharma', 'position': 'Science Teacher', 'exp': '5 years', 'applied': 'Jan 15', 'status': 'new'},
    {'name': 'Vikram Singh', 'position': 'Science Teacher', 'exp': '3 years', 'applied': 'Jan 14', 'status': 'shortlisted'},
    {'name': 'Meera Gupta', 'position': 'Mathematics Teacher', 'exp': '7 years', 'applied': 'Jan 12', 'status': 'interview'},
    {'name': 'Ravi Kumar', 'position': 'Art Teacher', 'exp': '2 years', 'applied': 'Jan 10', 'status': 'rejected'},
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
                Text('Recruitment', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Manage job postings and applications', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              ElevatedButton.icon(onPressed: _showCreateJobDialog, icon: const Icon(Icons.add, color: Colors.white), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED)), label: Text('Post New Job', style: GoogleFonts.spaceGrotesk(color: Colors.white))),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Open Positions', '${_jobs.where((j) => j['status'] == 'active').length}', Icons.work, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Total Applications', '${_applications.length}', Icons.description, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Shortlisted', '${_applications.where((a) => a['status'] == 'shortlisted').length}', Icons.star, const Color(0xFFF59E0B)),
              const SizedBox(width: 16),
              _buildStatCard('Interviews', '${_applications.where((a) => a['status'] == 'interview').length}', Icons.event, const Color(0xFF7C3AED)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildJobsList()),
                const SizedBox(width: 24),
                Expanded(child: _buildApplicationsList()),
              ],
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

  Widget _buildJobsList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Job Postings', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _jobs.length,
              itemBuilder: (context, index) {
                final j = _jobs[index];
                final isActive = j['status'] == 'active';
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFF7C3AED).withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.work, color: Color(0xFF7C3AED), size: 20)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(j['title'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                        Text('${j['dept']} • ${j['type']} • Posted ${j['posted']}', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
                      ])),
                      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: isActive ? const Color(0xFF10B981).withOpacity(0.1) : const Color(0xFF6B7280).withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Text(isActive ? 'ACTIVE' : 'CLOSED', style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: isActive ? const Color(0xFF10B981) : const Color(0xFF6B7280)))),
                        const SizedBox(height: 4),
                        Text('${j['apps']} applications', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
                      ]),
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

  Widget _buildApplicationsList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Applications', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _applications.length,
              itemBuilder: (context, index) {
                final a = _applications[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 20, backgroundColor: const Color(0xFF7C3AED).withOpacity(0.1), child: Text(a['name'][0], style: GoogleFonts.spaceGrotesk(color: const Color(0xFF7C3AED), fontWeight: FontWeight.w600))),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(a['name'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                        Text('${a['position']} • ${a['exp']}', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
                      ])),
                      _buildAppStatusBadge(a['status']),
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

  Widget _buildAppStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'shortlisted': color = const Color(0xFF10B981); break;
      case 'interview': color = const Color(0xFF3B82F6); break;
      case 'rejected': color = const Color(0xFFEF4444); break;
      default: color = const Color(0xFFF59E0B);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(status.toUpperCase(), style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
    );
  }

  void _showCreateJobDialog() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Post New Job', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
      content: SizedBox(width: 400, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(decoration: InputDecoration(labelText: 'Job Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Department', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), items: ['Mathematics', 'Science', 'English', 'Art', 'Music', 'PT'].map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(), onChanged: (_) {}),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Job Type', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), items: ['Full-time', 'Part-time', 'Contract'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (_) {}),
        const SizedBox(height: 16),
        TextField(decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))), maxLines: 3),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.spaceGrotesk())),
        ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED)), child: Text('Post Job', style: GoogleFonts.spaceGrotesk(color: Colors.white))),
      ],
    ));
  }
}
