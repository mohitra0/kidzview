import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminClassesPage extends StatefulWidget {
  const AdminClassesPage({super.key});

  @override
  State<AdminClassesPage> createState() => _AdminClassesPageState();
}

class _AdminClassesPageState extends State<AdminClassesPage> {
  final List<Map<String, dynamic>> _classes = [
    {'name': 'Class 5A', 'section': 'A', 'grade': '5', 'teacher': 'Rahul Sharma', 'students': 35, 'room': '101', 'subjects': ['Math', 'Science', 'English']},
    {'name': 'Class 5B', 'section': 'B', 'grade': '5', 'teacher': 'Priya Patel', 'students': 32, 'room': '102', 'subjects': ['Math', 'Science', 'English']},
    {'name': 'Class 6A', 'section': 'A', 'grade': '6', 'teacher': 'Amit Kumar', 'students': 38, 'room': '201', 'subjects': ['Math', 'Science', 'English', 'Hindi']},
    {'name': 'Class 6B', 'section': 'B', 'grade': '6', 'teacher': 'Neha Gupta', 'students': 36, 'room': '202', 'subjects': ['Math', 'Science', 'English', 'Hindi']},
    {'name': 'Class 7A', 'section': 'A', 'grade': '7', 'teacher': 'Suresh Verma', 'students': 34, 'room': '301', 'subjects': ['Math', 'Science', 'English', 'Hindi', 'Social']},
    {'name': 'Class 7B', 'section': 'B', 'grade': '7', 'teacher': 'Kavita Singh', 'students': 33, 'room': '302', 'subjects': ['Math', 'Science', 'English', 'Hindi', 'Social']},
  ];

  @override
  Widget build(BuildContext context) {
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
                  Text('Class Management', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('Manage classes, sections & assign teachers', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.upload_file),
                label: Text('Import Classes', style: GoogleFonts.spaceGrotesk()),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _showAddClassDialog,
                icon: const Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                label: Text('Add Class', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Stats
          Row(
            children: [
              _buildStatCard('Total Classes', '42', Icons.class_, const Color(0xFF8B5CF6)),
              const SizedBox(width: 16),
              _buildStatCard('Total Sections', '84', Icons.grid_view, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Avg Students/Class', '30', Icons.people, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Grades', 'LKG - 12', Icons.school, const Color(0xFFF59E0B)),
            ],
          ),
          const SizedBox(height: 24),
          // Classes Grid
          Text('All Classes', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.4, crossAxisSpacing: 16, mainAxisSpacing: 16),
            itemCount: _classes.length,
            itemBuilder: (context, index) => _buildClassCard(_classes[index]),
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700)),
                Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> classData) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.class_, color: Color(0xFF8B5CF6)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(classData['name'], style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
                    Text('Room ${classData['room']}', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                  ],
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.person, size: 16, color: Color(0xFF6B7280)),
              const SizedBox(width: 6),
              Text('Teacher: ${classData['teacher']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF374151))),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.people, size: 16, color: Color(0xFF6B7280)),
              const SizedBox(width: 6),
              Text('${classData['students']} Students', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF374151))),
            ],
          ),
          const Spacer(),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: (classData['subjects'] as List<String>).take(3).map((s) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(6)),
              child: Text(s, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
            )).toList(),
          ),
        ],
      ),
    );
  }

  void _showAddClassDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Class', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: TextField(decoration: InputDecoration(labelText: 'Grade', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))))),
                  const SizedBox(width: 16),
                  Expanded(child: TextField(decoration: InputDecoration(labelText: 'Section', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))))),
                ],
              ),
              const SizedBox(height: 16),
              TextField(decoration: InputDecoration(labelText: 'Room Number', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Class Teacher', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                items: ['Rahul Sharma', 'Priya Patel', 'Amit Kumar'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (_) {},
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.spaceGrotesk())),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6)),
            child: Text('Create Class', style: GoogleFonts.spaceGrotesk(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
