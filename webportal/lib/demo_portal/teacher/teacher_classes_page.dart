import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared/student_profile_page.dart';

class TeacherClassesPage extends StatelessWidget {
  const TeacherClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final classes = [
      {'name': 'Class 5A', 'subject': 'Mathematics', 'students': 35, 'room': '101', 'time': '8:00 - 9:00 AM'},
      {'name': 'Class 6B', 'subject': 'Mathematics', 'students': 38, 'room': '102', 'time': '9:00 - 10:00 AM'},
      {'name': 'Class 5A', 'subject': 'Science', 'students': 35, 'room': '101', 'time': '10:30 - 11:30 AM'},
      {'name': 'Class 7A', 'subject': 'Mathematics', 'students': 34, 'room': '103', 'time': '12:00 - 1:00 PM'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Classes', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('Manage your assigned classes and students', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: classes.map((c) => _buildClassCard(context, c)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(BuildContext context, Map<String, dynamic> classData) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.class_, color: Color(0xFF3B82F6)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(classData['name'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
                  Text(classData['subject'] as String, style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.people, '${classData['students']} Students'),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.room, 'Room ${classData['room']}'),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.access_time, classData['time'] as String),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showStudentsList(context, classData['name'] as String),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                  child: Text('View Students', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Go Live', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF6B7280)),
        const SizedBox(width: 8),
        Text(text, style: GoogleFonts.spaceGrotesk(fontSize: 14, color: const Color(0xFF374151))),
      ],
    );
  }

  void _showStudentsList(BuildContext context, String className) {
    final students = [
      {'name': 'Aarav Sharma', 'rollNo': '001'},
      {'name': 'Ananya Patel', 'rollNo': '002'},
      {'name': 'Arjun Singh', 'rollNo': '003'},
      {'name': 'Diya Gupta', 'rollNo': '004'},
      {'name': 'Ishaan Kumar', 'rollNo': '005'},
      {'name': 'Kavya Reddy', 'rollNo': '006'},
      {'name': 'Rohan Joshi', 'rollNo': '007'},
      {'name': 'Saanvi Mehta', 'rollNo': '008'},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Text('Students - $className', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
            const Spacer(),
            IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
          ],
        ),
        content: SizedBox(
          width: 500,
          height: 400,
          child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final s = students[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF3B82F6).withOpacity(0.1),
                  child: Text(s['name']![0], style: GoogleFonts.spaceGrotesk(color: const Color(0xFF3B82F6), fontWeight: FontWeight.w600)),
                ),
                title: Text(s['name']!, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                subtitle: Text('Roll No: ${s['rollNo']}', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                trailing: IconButton(
                  icon: const Icon(Icons.visibility, color: Color(0xFF3B82F6)),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => StudentProfilePage(
                      studentName: s['name']!,
                      rollNo: '$className-${s['rollNo']}',
                      className: className,
                    )));
                  },
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => StudentProfilePage(
                    studentName: s['name']!,
                    rollNo: '$className-${s['rollNo']}',
                    className: className,
                  )));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
