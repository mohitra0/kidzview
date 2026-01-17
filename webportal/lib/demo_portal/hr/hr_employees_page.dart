import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HREmployeesPage extends StatefulWidget {
  const HREmployeesPage({super.key});

  @override
  State<HREmployeesPage> createState() => _HREmployeesPageState();
}

class _HREmployeesPageState extends State<HREmployeesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Map<String, dynamic>> _employees = [
    {'name': 'Rahul Sharma', 'empId': 'EMP001', 'dept': 'Mathematics', 'role': 'Senior Teacher', 'phone': '9876543210', 'email': 'rahul@mcp.edu', 'joined': 'Aug 2020', 'status': 'active'},
    {'name': 'Priya Patel', 'empId': 'EMP002', 'dept': 'Science', 'role': 'Teacher', 'phone': '9876543211', 'email': 'priya@mcp.edu', 'joined': 'Jan 2021', 'status': 'active'},
    {'name': 'Amit Kumar', 'empId': 'EMP003', 'dept': 'English', 'role': 'Teacher', 'phone': '9876543212', 'email': 'amit@mcp.edu', 'joined': 'Jan 2026', 'status': 'onboarding'},
    {'name': 'Neha Gupta', 'empId': 'EMP004', 'dept': 'Hindi', 'role': 'Teacher', 'phone': '9876543213', 'email': 'neha@mcp.edu', 'joined': 'Mar 2022', 'status': 'on_leave'},
    {'name': 'Suresh Verma', 'empId': 'EMP005', 'dept': 'Support', 'role': 'Peon', 'phone': '9876543214', 'email': 'suresh@mcp.edu', 'joined': 'Jun 2019', 'status': 'active'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Employee Directory', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('View and manage all employees', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: Text('Export', style: GoogleFonts.spaceGrotesk())),
              const SizedBox(width: 12),
              ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, color: Colors.white), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED)), label: Text('Add Employee', style: GoogleFonts.spaceGrotesk(color: Colors.white))),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('Total', '${_employees.length}', const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Active', '${_employees.where((e) => e['status'] == 'active').length}', const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('On Leave', '${_employees.where((e) => e['status'] == 'on_leave').length}', const Color(0xFFF59E0B)),
              const SizedBox(width: 16),
              _buildStatCard('Onboarding', '${_employees.where((e) => e['status'] == 'onboarding').length}', const Color(0xFF7C3AED)),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF7C3AED),
              unselectedLabelColor: const Color(0xFF6B7280),
              indicatorColor: const Color(0xFF7C3AED),
              tabs: const [Tab(text: 'All Employees'), Tab(text: 'Teachers'), Tab(text: 'Staff')],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(child: _buildEmployeesTable()),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE5E7EB))),
        child: Row(children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700, color: color))),
          const SizedBox(width: 12),
          Text(label, style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
        ]),
      ),
    );
  }

  Widget _buildEmployeesTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Row(children: [
              Expanded(flex: 2, child: Text('Employee', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Department', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Role', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Contact', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Joined', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              Expanded(child: Text('Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
              const SizedBox(width: 80),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _employees.length,
              itemBuilder: (context, index) {
                final e = _employees[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(children: [
                    Expanded(flex: 2, child: Row(children: [
                      CircleAvatar(radius: 18, backgroundColor: const Color(0xFF7C3AED).withOpacity(0.1), child: Text(e['name'][0], style: GoogleFonts.spaceGrotesk(color: const Color(0xFF7C3AED), fontWeight: FontWeight.w600))),
                      const SizedBox(width: 12),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(e['name'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                        Text(e['empId'], style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
                      ]),
                    ])),
                    Expanded(child: Text(e['dept'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: Text(e['role'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: Text(e['phone'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: Text(e['joined'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                    Expanded(child: _buildStatusBadge(e['status'])),
                    SizedBox(width: 80, child: Row(children: [
                      IconButton(icon: const Icon(Icons.visibility, size: 18), onPressed: () {}, color: const Color(0xFF7C3AED)),
                      IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}, color: const Color(0xFF6B7280)),
                    ])),
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    String label;
    switch (status) {
      case 'active': color = const Color(0xFF10B981); label = 'ACTIVE'; break;
      case 'on_leave': color = const Color(0xFFF59E0B); label = 'ON LEAVE'; break;
      default: color = const Color(0xFF7C3AED); label = 'ONBOARDING';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
    );
  }
}
