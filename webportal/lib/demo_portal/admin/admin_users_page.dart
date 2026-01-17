import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared/student_profile_page.dart';
import '../shared/teacher_profile_page.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  final List<Map<String, dynamic>> _teachers = [
    {'name': 'Rahul Sharma', 'email': 'rahul@mcp.edu', 'subject': 'Mathematics', 'classes': ['5A', '6B', '7A'], 'status': 'active'},
    {'name': 'Priya Patel', 'email': 'priya@mcp.edu', 'subject': 'Science', 'classes': ['5A', '5B'], 'status': 'active'},
    {'name': 'Amit Kumar', 'email': 'amit@mcp.edu', 'subject': 'English', 'classes': ['6A', '6B', '7A', '7B'], 'status': 'active'},
    {'name': 'Neha Gupta', 'email': 'neha@mcp.edu', 'subject': 'Hindi', 'classes': ['5A', '5B', '6A'], 'status': 'leave'},
  ];

  final List<Map<String, dynamic>> _students = [
    {'name': 'Aarav Sharma', 'rollNo': '5A-001', 'class': '5A', 'parent': 'Rajesh Sharma', 'phone': '9876543210', 'status': 'active'},
    {'name': 'Ananya Patel', 'rollNo': '5A-002', 'class': '5A', 'parent': 'Vikram Patel', 'phone': '9876543211', 'status': 'active'},
    {'name': 'Arjun Singh', 'rollNo': '5A-003', 'class': '5A', 'parent': 'Harpreet Singh', 'phone': '9876543212', 'status': 'active'},
    {'name': 'Diya Gupta', 'rollNo': '6B-001', 'class': '6B', 'parent': 'Suresh Gupta', 'phone': '9876543213', 'status': 'active'},
  ];

  final List<Map<String, dynamic>> _parents = [
    {'name': 'Rajesh Sharma', 'email': 'rajesh@email.com', 'phone': '9876543210', 'children': ['Aarav Sharma'], 'appStatus': 'installed'},
    {'name': 'Vikram Patel', 'email': 'vikram@email.com', 'phone': '9876543211', 'children': ['Ananya Patel'], 'appStatus': 'installed'},
    {'name': 'Harpreet Singh', 'email': 'harpreet@email.com', 'phone': '9876543212', 'children': ['Arjun Singh'], 'appStatus': 'not_installed'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User Management', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('Manage teachers, students, parents & staff', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _showAddUserDialog,
                icon: const Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                label: Text('Add User', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Stats
          Row(
            children: [
              _buildStatCard('Teachers', '68', Icons.person, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Students', '1,248', Icons.school, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Parents', '1,892', Icons.family_restroom, const Color(0xFF8B5CF6)),
              const SizedBox(width: 16),
              _buildStatCard('Staff', '24', Icons.badge, const Color(0xFFF59E0B)),
            ],
          ),
          const SizedBox(height: 24),
          // Search & Tabs
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (v) => setState(() => _searchQuery = v),
                        decoration: InputDecoration(
                          hintText: 'Search users...',
                          prefixIcon: const Icon(Icons.search, color: Color(0xFF6B7280)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<String>(
                        value: 'all',
                        underline: const SizedBox(),
                        items: ['all', 'active', 'inactive'].map((s) => DropdownMenuItem(value: s, child: Text(s == 'all' ? 'All Status' : s.toUpperCase(), style: GoogleFonts.spaceGrotesk()))).toList(),
                        onChanged: (_) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF8B5CF6),
                  unselectedLabelColor: const Color(0xFF6B7280),
                  indicatorColor: const Color(0xFF8B5CF6),
                  tabs: const [
                    Tab(text: 'Teachers'),
                    Tab(text: 'Students'),
                    Tab(text: 'Parents'),
                    Tab(text: 'Staff'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTeachersTable(),
                _buildStudentsTable(),
                _buildParentsTable(),
                _buildStaffTable(),
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

  Widget _buildTeachersTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text('Name', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(flex: 2, child: Text('Email', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Subject', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Classes', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                const SizedBox(width: 80, child: Text('Actions', style: TextStyle(fontWeight: FontWeight.w600))),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _teachers.length,
              itemBuilder: (context, index) {
                final t = _teachers[index];
                return InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TeacherProfilePage(teacherName: t['name'], subject: t['subject'], email: t['email']))),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              CircleAvatar(radius: 18, backgroundColor: const Color(0xFF3B82F6).withOpacity(0.1), child: Text(t['name'][0], style: GoogleFonts.spaceGrotesk(color: const Color(0xFF3B82F6), fontWeight: FontWeight.w600))),
                              const SizedBox(width: 12),
                              Text(t['name'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        Expanded(flex: 2, child: Text(t['email'], style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280)))),
                        Expanded(child: Text(t['subject'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                        Expanded(child: Text((t['classes'] as List).join(', '), style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                        Expanded(child: _buildStatusBadge(t['status'])),
                        SizedBox(
                          width: 80,
                          child: Row(
                            children: [
                              IconButton(icon: const Icon(Icons.visibility, size: 18), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TeacherProfilePage(teacherName: t['name'], subject: t['subject'], email: t['email']))), color: const Color(0xFF3B82F6)),
                              IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}, color: const Color(0xFF6B7280)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentsTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text('Name', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Roll No', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Class', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(flex: 2, child: Text('Parent', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                const SizedBox(width: 80),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final s = _students[index];
                return InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StudentProfilePage(studentName: s['name'], rollNo: s['rollNo'], className: s['class']))),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Row(children: [
                          CircleAvatar(radius: 18, backgroundColor: const Color(0xFF10B981).withOpacity(0.1), child: Text(s['name'][0], style: GoogleFonts.spaceGrotesk(color: const Color(0xFF10B981), fontWeight: FontWeight.w600))),
                          const SizedBox(width: 12),
                          Text(s['name'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                        ])),
                        Expanded(child: Text(s['rollNo'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                        Expanded(child: Text(s['class'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                        Expanded(flex: 2, child: Text(s['parent'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                        Expanded(child: _buildStatusBadge(s['status'])),
                        SizedBox(width: 80, child: Row(children: [
                          IconButton(icon: const Icon(Icons.visibility, size: 18), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StudentProfilePage(studentName: s['name'], rollNo: s['rollNo'], className: s['class']))), color: const Color(0xFF3B82F6)),
                          IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}, color: const Color(0xFF6B7280)),
                        ])),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParentsTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text('Name', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(flex: 2, child: Text('Email', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('Phone', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(flex: 2, child: Text('Children', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                Expanded(child: Text('App Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _parents.length,
              itemBuilder: (context, index) {
                final p = _parents[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Row(children: [
                        CircleAvatar(radius: 18, backgroundColor: const Color(0xFF8B5CF6).withOpacity(0.1), child: Text(p['name'][0], style: GoogleFonts.spaceGrotesk(color: const Color(0xFF8B5CF6), fontWeight: FontWeight.w600))),
                        const SizedBox(width: 12),
                        Text(p['name'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                      ])),
                      Expanded(flex: 2, child: Text(p['email'], style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280)))),
                      Expanded(child: Text(p['phone'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                      Expanded(flex: 2, child: Text((p['children'] as List).join(', '), style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                      Expanded(child: _buildAppStatusBadge(p['appStatus'])),
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

  Widget _buildStaffTable() {
    return Center(child: Text('Staff management coming soon...', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))));
  }

  Widget _buildStatusBadge(String status) {
    final isActive = status == 'active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: isActive ? const Color(0xFF10B981).withOpacity(0.1) : const Color(0xFFF59E0B).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(status.toUpperCase(), style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: isActive ? const Color(0xFF10B981) : const Color(0xFFF59E0B))),
    );
  }

  Widget _buildAppStatusBadge(String status) {
    final isInstalled = status == 'installed';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: isInstalled ? const Color(0xFF10B981).withOpacity(0.1) : const Color(0xFFEF4444).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(isInstalled ? 'App Installed' : 'Not Installed', style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: isInstalled ? const Color(0xFF10B981) : const Color(0xFFEF4444))),
    );
  }

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New User', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 16),
              TextField(decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'User Type', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                items: ['Teacher', 'Student', 'Parent', 'Staff'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
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
            child: Text('Add User', style: GoogleFonts.spaceGrotesk(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
