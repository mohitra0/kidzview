import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherLivestreamPage extends StatefulWidget {
  const TeacherLivestreamPage({super.key});

  @override
  State<TeacherLivestreamPage> createState() => _TeacherLivestreamPageState();
}

class _TeacherLivestreamPageState extends State<TeacherLivestreamPage> {
  final List<Map<String, dynamic>> _cameras = [
    {'class': 'Class 5A', 'room': 'Room 101', 'status': 'live', 'viewers': 28, 'timeLimit': 30, 'students': ['Aarav', 'Ananya', 'Arjun', 'Diya']},
    {'class': 'Class 6B', 'room': 'Room 102', 'status': 'live', 'viewers': 31, 'timeLimit': 0, 'students': ['Ishaan', 'Kavya', 'Rohan']},
    {'class': 'Class 7A', 'room': 'Room 103', 'status': 'offline', 'viewers': 0, 'timeLimit': 60, 'students': ['Saanvi', 'Vihaan', 'Aanya']},
    {'class': 'Class 5A Lab', 'room': 'Science Lab', 'status': 'offline', 'viewers': 0, 'timeLimit': 0, 'students': ['Aarav', 'Ananya']},
  ];

  @override
  Widget build(BuildContext context) {
    final liveCount = _cameras.where((c) => c['status'] == 'live').length;
    final totalViewers = _cameras.fold<int>(0, (sum, c) => sum + (c['viewers'] as int));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Live Streaming', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('Control cameras, manage student access & set viewing limits', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
          const SizedBox(height: 24),
          // Stats Row
          Row(
            children: [
              _buildStatCard('Live Cameras', '$liveCount', const Color(0xFF10B981), Icons.videocam),
              const SizedBox(width: 16),
              _buildStatCard('Parents Watching', '$totalViewers', const Color(0xFF3B82F6), Icons.visibility),
              const SizedBox(width: 16),
              _buildStatCard('Total Cameras', '${_cameras.length}', const Color(0xFF6B7280), Icons.camera),
            ],
          ),
          const SizedBox(height: 24),
          Text('Camera Controls', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: _cameras.asMap().entries.map((e) => _buildCameraCard(e.key, e.value)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
              Text(label, style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCameraCard(int index, Map<String, dynamic> camera) {
    final isLive = camera['status'] == 'live';
    final timeLimit = camera['timeLimit'] as int;
    final students = camera['students'] as List<String>;

    return Container(
      width: 380,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isLive ? const Color(0xFF10B981) : const Color(0xFFE5E7EB), width: isLive ? 2 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Camera Preview
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Center(
                  child: isLive
                      ? const Icon(Icons.videocam, color: Colors.white, size: 36)
                      : const Icon(Icons.videocam_off, color: Colors.grey, size: 36),
                ),
                if (isLive)
                  Positioned(
                    top: 12, left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFFEF4444), borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                          const SizedBox(width: 6),
                          Text('LIVE', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                if (isLive)
                  Positioned(
                    top: 12, right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          const Icon(Icons.visibility, size: 14, color: Colors.white),
                          const SizedBox(width: 4),
                          Text('${camera['viewers']}', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Class Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(camera['class'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w700)),
                    Text(camera['room'] as String, style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280), fontSize: 13)),
                  ],
                ),
              ),
              Switch(
                value: isLive,
                activeColor: const Color(0xFF10B981),
                onChanged: (v) => setState(() => camera['status'] = v ? 'live' : 'offline'),
              ),
            ],
          ),
          const Divider(height: 24),
          // Time Limit Control
          Row(
            children: [
              const Icon(Icons.timer, size: 18, color: Color(0xFF6B7280)),
              const SizedBox(width: 8),
              Text('Parent Viewing Limit:', style: GoogleFonts.spaceGrotesk(fontSize: 13)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<int>(
                  value: timeLimit,
                  underline: const SizedBox(),
                  isDense: true,
                  items: [0, 15, 30, 45, 60, 90, 120].map((m) => 
                    DropdownMenuItem(value: m, child: Text(m == 0 ? 'No Limit' : '$m min', style: GoogleFonts.spaceGrotesk(fontSize: 13)))
                  ).toList(),
                  onChanged: (v) => setState(() => camera['timeLimit'] = v!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Students Access
          Row(
            children: [
              const Icon(Icons.people, size: 18, color: Color(0xFF6B7280)),
              const SizedBox(width: 8),
              Text('Students (${students.length}):', style: GoogleFonts.spaceGrotesk(fontSize: 13)),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _showStudentManager(index, camera),
                icon: const Icon(Icons.edit, size: 16),
                label: Text('Manage', style: GoogleFonts.spaceGrotesk(fontSize: 13)),
              ),
            ],
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: students.take(4).map((s) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(s, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF3B82F6))),
            )).toList()
            ..addAll(students.length > 4 ? [Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(20)),
              child: Text('+${students.length - 4} more', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
            )] : []),
          ),
        ],
      ),
    );
  }

  void _showStudentManager(int cameraIndex, Map<String, dynamic> camera) {
    final allStudents = ['Aarav', 'Ananya', 'Arjun', 'Diya', 'Ishaan', 'Kavya', 'Rohan', 'Saanvi', 'Vihaan', 'Aanya'];
    List<String> selected = List<String>.from(camera['students']);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Manage Students - ${camera['class']}', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select students visible to parents on this camera:', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280), fontSize: 13)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: allStudents.map((s) {
                    final isSelected = selected.contains(s);
                    return FilterChip(
                      label: Text(s, style: GoogleFonts.spaceGrotesk()),
                      selected: isSelected,
                      onSelected: (v) {
                        setDialogState(() {
                          if (v) selected.add(s);
                          else selected.remove(s);
                        });
                      },
                      selectedColor: const Color(0xFF3B82F6).withOpacity(0.2),
                      checkmarkColor: const Color(0xFF3B82F6),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    TextButton(onPressed: () => setDialogState(() => selected = List.from(allStudents)), child: Text('Select All', style: GoogleFonts.spaceGrotesk())),
                    TextButton(onPressed: () => setDialogState(() => selected.clear()), child: Text('Clear All', style: GoogleFonts.spaceGrotesk())),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.spaceGrotesk())),
            ElevatedButton(
              onPressed: () {
                setState(() => _cameras[cameraIndex]['students'] = selected);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
              child: Text('Save', style: GoogleFonts.spaceGrotesk(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
