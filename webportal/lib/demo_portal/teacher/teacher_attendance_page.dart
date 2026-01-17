import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherAttendancePage extends StatefulWidget {
  const TeacherAttendancePage({super.key});

  @override
  State<TeacherAttendancePage> createState() => _TeacherAttendancePageState();
}

class _TeacherAttendancePageState extends State<TeacherAttendancePage> {
  String _selectedClass = 'Class 5A';
  String _viewMode = 'daily'; // daily, week, month
  DateTime _selectedDate = DateTime.now();
  
  final List<Map<String, dynamic>> _students = [
    {'name': 'Aarav Sharma', 'rollNo': '001', 'present': true},
    {'name': 'Ananya Patel', 'rollNo': '002', 'present': true},
    {'name': 'Arjun Singh', 'rollNo': '003', 'present': false},
    {'name': 'Diya Gupta', 'rollNo': '004', 'present': true},
    {'name': 'Ishaan Kumar', 'rollNo': '005', 'present': true},
    {'name': 'Kavya Reddy', 'rollNo': '006', 'present': true},
    {'name': 'Rohan Joshi', 'rollNo': '007', 'present': false},
    {'name': 'Saanvi Mehta', 'rollNo': '008', 'present': true},
  ];

  @override
  Widget build(BuildContext context) {
    final presentCount = _students.where((s) => s['present'] == true).length;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Attendance', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('Mark and manage student attendance', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              // Class Selector
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: DropdownButton<String>(
                  value: _selectedClass,
                  underline: const SizedBox(),
                  items: ['Class 5A', 'Class 6B', 'Class 7A'].map((c) => 
                    DropdownMenuItem(value: c, child: Text(c, style: GoogleFonts.spaceGrotesk()))
                  ).toList(),
                  onChanged: (v) => setState(() => _selectedClass = v!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // View Mode Tabs & Actions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                // View Mode Toggle
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      _buildModeTab('Daily', 'daily'),
                      _buildModeTab('Week', 'week'),
                      _buildModeTab('Month', 'month'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Date Display
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: Color(0xFF6B7280)),
                      const SizedBox(width: 8),
                      Text(_getDateLabel(), style: GoogleFonts.spaceGrotesk(fontSize: 13)),
                    ],
                  ),
                ),
                const Spacer(),
                // Bulk Actions
                OutlinedButton.icon(
                  onPressed: _showExcelUploadDialog,
                  icon: const Icon(Icons.upload_file, size: 18),
                  label: Text('Upload Excel', style: GoogleFonts.spaceGrotesk()),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _showBulkMarkDialog,
                  icon: const Icon(Icons.check_circle_outline, size: 18),
                  label: Text('Bulk Mark', style: GoogleFonts.spaceGrotesk()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Stats
          Row(
            children: [
              _buildStatCard('Present', '$presentCount', const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Absent', '${_students.length - presentCount}', const Color(0xFFEF4444)),
              const SizedBox(width: 16),
              _buildStatCard('Total', '${_students.length}', const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Attendance %', '${((presentCount / _students.length) * 100).toStringAsFixed(0)}%', const Color(0xFF8B5CF6)),
            ],
          ),
          const SizedBox(height: 24),

          // Student List
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              children: [
                // Table Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 60, child: Text('Roll', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 13))),
                      Expanded(child: Text('Student Name', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 13))),
                      if (_viewMode == 'daily')
                        SizedBox(width: 140, child: Text('Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 13)))
                      else
                        SizedBox(width: 300, child: Text(_viewMode == 'week' ? 'Mon - Fri' : 'This Month', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 13))),
                    ],
                  ),
                ),
                // Student Rows
                ..._students.asMap().entries.map((entry) => _buildStudentRow(entry.key, entry.value)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Submit Button
          ElevatedButton.icon(
            onPressed: () => _showSuccessSnackbar('Attendance saved successfully!'),
            icon: const Icon(Icons.save, color: Colors.white),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            label: Text('Save Attendance', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildModeTab(String label, String mode) {
    final isSelected = _viewMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _viewMode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)] : null,
        ),
        child: Text(label, style: GoogleFonts.spaceGrotesk(
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
        )),
      ),
    );
  }

  String _getDateLabel() {
    if (_viewMode == 'daily') return 'Jan 16, 2026';
    if (_viewMode == 'week') return 'Week of Jan 13-17, 2026';
    return 'January 2026';
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: color)),
        ],
      ),
    );
  }

  Widget _buildStudentRow(int index, Map<String, dynamic> student) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(student['rollNo'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFF3B82F6).withOpacity(0.1),
                  child: Text(student['name'][0], style: GoogleFonts.spaceGrotesk(color: const Color(0xFF3B82F6), fontWeight: FontWeight.w600, fontSize: 12)),
                ),
                const SizedBox(width: 12),
                Text(student['name'], style: GoogleFonts.spaceGrotesk(fontSize: 14)),
              ],
            ),
          ),
          if (_viewMode == 'daily')
            SizedBox(
              width: 140,
              child: Row(
                children: [
                  _buildToggle('P', true, student['present'], () => setState(() => student['present'] = true)),
                  const SizedBox(width: 8),
                  _buildToggle('A', false, !student['present'], () => setState(() => student['present'] = false)),
                ],
              ),
            )
          else
            SizedBox(
              width: 300,
              child: Row(
                children: List.generate(_viewMode == 'week' ? 5 : 7, (i) => Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 28, height: 28,
                      decoration: BoxDecoration(
                        color: i % 3 == 0 ? const Color(0xFFEF4444).withOpacity(0.1) : const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          i % 3 == 0 ? 'A' : 'P',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: i % 3 == 0 ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildToggle(String label, bool isPresent, bool isSelected, VoidCallback onTap) {
    final color = isPresent ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color),
        ),
        child: Text(label, style: GoogleFonts.spaceGrotesk(color: isSelected ? Colors.white : color, fontWeight: FontWeight.w600, fontSize: 13)),
      ),
    );
  }

  void _showExcelUploadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upload Attendance Excel', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE5E7EB), style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF9FAFB),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_upload, size: 40, color: Color(0xFF6B7280)),
                    const SizedBox(height: 12),
                    Text('Drag & drop Excel file here', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                    const SizedBox(height: 4),
                    Text('or click to browse', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF3B82F6), fontSize: 12)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download, size: 16),
              label: Text('Download Template', style: GoogleFonts.spaceGrotesk(fontSize: 13)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.spaceGrotesk())),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessSnackbar('Excel uploaded! Processing attendance...');
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
            child: Text('Upload', style: GoogleFonts.spaceGrotesk(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showBulkMarkDialog() {
    String period = 'today';
    String status = 'present';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Bulk Mark Attendance', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mark all students for:', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(label: Text('Today', style: GoogleFonts.spaceGrotesk()), selected: period == 'today', onSelected: (_) => setDialogState(() => period = 'today')),
                  ChoiceChip(label: Text('This Week', style: GoogleFonts.spaceGrotesk()), selected: period == 'week', onSelected: (_) => setDialogState(() => period = 'week')),
                  ChoiceChip(label: Text('This Month', style: GoogleFonts.spaceGrotesk()), selected: period == 'month', onSelected: (_) => setDialogState(() => period = 'month')),
                ],
              ),
              const SizedBox(height: 20),
              Text('Status:', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
              const SizedBox(height: 12),
              Row(
                children: [
                  ChoiceChip(
                    label: Text('Present', style: GoogleFonts.spaceGrotesk()),
                    selected: status == 'present',
                    selectedColor: const Color(0xFF10B981).withOpacity(0.2),
                    onSelected: (_) => setDialogState(() => status = 'present'),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: Text('Absent', style: GoogleFonts.spaceGrotesk()),
                    selected: status == 'absent',
                    selectedColor: const Color(0xFFEF4444).withOpacity(0.2),
                    onSelected: (_) => setDialogState(() => status = 'absent'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.spaceGrotesk())),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  for (var s in _students) {
                    s['present'] = status == 'present';
                  }
                });
                Navigator.pop(context);
                _showSuccessSnackbar('Marked all students ${status == 'present' ? 'Present' : 'Absent'} for ${period == 'today' ? 'today' : period == 'week' ? 'this week' : 'this month'}');
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
              child: Text('Apply', style: GoogleFonts.spaceGrotesk(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.spaceGrotesk()),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
