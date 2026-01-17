import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRDocumentsPage extends StatelessWidget {
  const HRDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final employees = [
      {'name': 'Rahul Sharma', 'empId': 'EMP001', 'resume': true, 'id': true, 'address': true, 'edu': true, 'exp': true, 'offer': true},
      {'name': 'Priya Patel', 'empId': 'EMP002', 'resume': true, 'id': true, 'address': true, 'edu': true, 'exp': false, 'offer': true},
      {'name': 'Amit Kumar', 'empId': 'EMP003', 'resume': true, 'id': false, 'address': false, 'edu': true, 'exp': false, 'offer': true},
      {'name': 'Neha Gupta', 'empId': 'EMP004', 'resume': true, 'id': true, 'address': true, 'edu': true, 'exp': true, 'offer': true},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Employee Documents', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Manage and track employee documents', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.warning, color: Color(0xFFF59E0B)), label: Text('3 Pending', style: GoogleFonts.spaceGrotesk(color: const Color(0xFFF59E0B)))),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(color: Color(0xFFF9FAFB), borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                    child: Row(children: [
                      Expanded(flex: 2, child: Text('Employee', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Center(child: Text('Resume', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 12)))),
                      Expanded(child: Center(child: Text('ID Proof', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 12)))),
                      Expanded(child: Center(child: Text('Address', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 12)))),
                      Expanded(child: Center(child: Text('Education', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 12)))),
                      Expanded(child: Center(child: Text('Experience', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 12)))),
                      Expanded(child: Center(child: Text('Offer Letter', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 12)))),
                      const SizedBox(width: 60),
                    ]),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: employees.length,
                      itemBuilder: (context, index) {
                        final e = employees[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                          child: Row(children: [
                            Expanded(flex: 2, child: Row(children: [
                              CircleAvatar(radius: 18, backgroundColor: const Color(0xFF7C3AED).withOpacity(0.1), child: Text((e['name'] as String)[0], style: GoogleFonts.spaceGrotesk(color: const Color(0xFF7C3AED), fontWeight: FontWeight.w600))),
                              const SizedBox(width: 12),
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(e['name'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                                Text(e['empId'] as String, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
                              ]),
                            ])),
                            Expanded(child: Center(child: _buildDocIcon(e['resume'] as bool))),
                            Expanded(child: Center(child: _buildDocIcon(e['id'] as bool))),
                            Expanded(child: Center(child: _buildDocIcon(e['address'] as bool))),
                            Expanded(child: Center(child: _buildDocIcon(e['edu'] as bool))),
                            Expanded(child: Center(child: _buildDocIcon(e['exp'] as bool))),
                            Expanded(child: Center(child: _buildDocIcon(e['offer'] as bool))),
                            SizedBox(width: 60, child: IconButton(icon: const Icon(Icons.folder_open, size: 18), onPressed: () {}, color: const Color(0xFF7C3AED))),
                          ]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocIcon(bool uploaded) {
    return Icon(uploaded ? Icons.check_circle : Icons.cancel, color: uploaded ? const Color(0xFF10B981) : const Color(0xFFEF4444), size: 20);
  }
}
