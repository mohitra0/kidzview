import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HRSalaryPage extends StatelessWidget {
  const HRSalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final salaryStructures = [
      {'grade': 'Senior Teacher', 'basic': 45000, 'hra': 9000, 'da': 4500, 'special': 5000, 'pf': 5400, 'esi': 1500, 'net': 56600},
      {'grade': 'Teacher', 'basic': 35000, 'hra': 7000, 'da': 3500, 'special': 3000, 'pf': 4200, 'esi': 1200, 'net': 43100},
      {'grade': 'Junior Teacher', 'basic': 28000, 'hra': 5600, 'da': 2800, 'special': 2000, 'pf': 3360, 'esi': 960, 'net': 34080},
      {'grade': 'Admin Staff', 'basic': 25000, 'hra': 5000, 'da': 2500, 'special': 2000, 'pf': 3000, 'esi': 850, 'net': 30650},
      {'grade': 'Support Staff', 'basic': 18000, 'hra': 3600, 'da': 1800, 'special': 1000, 'pf': 2160, 'esi': 615, 'net': 21625},
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Salary Structure', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                Text('Define and manage salary grades', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
              ]),
              const Spacer(),
              ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, color: Colors.white), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED)), label: Text('Add Grade', style: GoogleFonts.spaceGrotesk(color: Colors.white))),
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
                      Expanded(child: Text('Grade', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Basic', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('HRA', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('DA', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Special', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('PF', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('ESI', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('Net Salary', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                      const SizedBox(width: 60),
                    ]),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: salaryStructures.length,
                      itemBuilder: (context, index) {
                        final s = salaryStructures[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                          child: Row(children: [
                            Expanded(child: Text(s['grade'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500))),
                            Expanded(child: Text('₹${s['basic']}', style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                            Expanded(child: Text('₹${s['hra']}', style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                            Expanded(child: Text('₹${s['da']}', style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                            Expanded(child: Text('₹${s['special']}', style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                            Expanded(child: Text('-₹${s['pf']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFFEF4444)))),
                            Expanded(child: Text('-₹${s['esi']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFFEF4444)))),
                            Expanded(child: Text('₹${s['net']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF10B981)))),
                            SizedBox(width: 60, child: IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}, color: const Color(0xFF6B7280))),
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
}
