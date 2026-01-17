import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherLeavePage extends StatefulWidget {
  const TeacherLeavePage({super.key});

  @override
  State<TeacherLeavePage> createState() => _TeacherLeavePageState();
}

class _TeacherLeavePageState extends State<TeacherLeavePage> {
  final List<Map<String, dynamic>> _leaveHistory = [
    {'type': 'Sick Leave', 'from': 'Jan 10, 2026', 'to': 'Jan 11, 2026', 'days': 2, 'status': 'approved', 'reason': 'Fever'},
    {'type': 'Casual Leave', 'from': 'Dec 24, 2025', 'to': 'Dec 26, 2025', 'days': 3, 'status': 'approved', 'reason': 'Family function'},
    {'type': 'Earned Leave', 'from': 'Nov 15, 2025', 'to': 'Nov 15, 2025', 'days': 1, 'status': 'approved', 'reason': 'Personal work'},
    {'type': 'Casual Leave', 'from': 'Jan 25, 2026', 'to': 'Jan 27, 2026', 'days': 3, 'status': 'pending', 'reason': 'Travel'},
  ];

  final Map<String, Map<String, dynamic>> _leaveBalance = {
    'Casual Leave': {'total': 12, 'used': 4, 'color': const Color(0xFF3B82F6)},
    'Sick Leave': {'total': 10, 'used': 2, 'color': const Color(0xFFEF4444)},
    'Earned Leave': {'total': 15, 'used': 1, 'color': const Color(0xFF10B981)},
    'Maternity Leave': {'total': 180, 'used': 0, 'color': const Color(0xFFF59E0B)},
  };

  @override
  Widget build(BuildContext context) {
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
                  Text('Leave Management', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('Apply for leave and track your balance', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _showApplyLeaveDialog,
                icon: const Icon(Icons.add, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                label: Text('Apply for Leave', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Leave Balance Cards
          Text('Leave Balance', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Row(
            children: _leaveBalance.entries.map((e) => Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 16),
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
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: (e.value['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.event_available, color: e.value['color'] as Color, size: 20),
                        ),
                        const Spacer(),
                        Text('${e.value['total'] - e.value['used']}', style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.w700, color: e.value['color'] as Color)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(e.key, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text('${e.value['used']} of ${e.value['total']} used', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: e.value['used'] / e.value['total'],
                      backgroundColor: const Color(0xFFF3F4F6),
                      valueColor: AlwaysStoppedAnimation(e.value['color'] as Color),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),
          const SizedBox(height: 32),

          // Leave History
          Text('Leave History', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
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
                      Expanded(flex: 2, child: Text('Leave Type', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 13))),
                      Expanded(flex: 2, child: Text('Duration', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 13))),
                      Expanded(child: Text('Days', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 13))),
                      Expanded(flex: 2, child: Text('Reason', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 13))),
                      Expanded(child: Text('Status', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 13))),
                    ],
                  ),
                ),
                // Rows
                ..._leaveHistory.map((leave) => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _getLeaveColor(leave['type']).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.event, color: _getLeaveColor(leave['type']), size: 16),
                            ),
                            const SizedBox(width: 12),
                            Text(leave['type'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('${leave['from']} - ${leave['to']}', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                      ),
                      Expanded(child: Text('${leave['days']}', style: GoogleFonts.spaceGrotesk())),
                      Expanded(flex: 2, child: Text(leave['reason'], style: GoogleFonts.spaceGrotesk(fontSize: 13))),
                      Expanded(child: _buildStatusBadge(leave['status'])),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getLeaveColor(String type) {
    switch (type) {
      case 'Casual Leave': return const Color(0xFF3B82F6);
      case 'Sick Leave': return const Color(0xFFEF4444);
      case 'Earned Leave': return const Color(0xFF10B981);
      default: return const Color(0xFF6B7280);
    }
  }

  Widget _buildStatusBadge(String status) {
    final isApproved = status == 'approved';
    final isPending = status == 'pending';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isApproved ? const Color(0xFF10B981).withOpacity(0.1) : isPending ? const Color(0xFFF59E0B).withOpacity(0.1) : const Color(0xFFEF4444).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status[0].toUpperCase() + status.substring(1),
        style: GoogleFonts.spaceGrotesk(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isApproved ? const Color(0xFF10B981) : isPending ? const Color(0xFFF59E0B) : const Color(0xFFEF4444),
        ),
      ),
    );
  }

  void _showApplyLeaveDialog() {
    String leaveType = 'Casual Leave';
    DateTime? fromDate;
    DateTime? toDate;
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Apply for Leave', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
          content: SizedBox(
            width: 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Leave Type
                Text('Leave Type', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: leaveType,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: ['Casual Leave', 'Sick Leave', 'Earned Leave'].map((t) => 
                      DropdownMenuItem(value: t, child: Text(t, style: GoogleFonts.spaceGrotesk()))
                    ).toList(),
                    onChanged: (v) => setDialogState(() => leaveType = v!),
                  ),
                ),
                const SizedBox(height: 20),

                // Date Range
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('From Date', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () async {
                              final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2027));
                              if (date != null) setDialogState(() => fromDate = date);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 18, color: Color(0xFF6B7280)),
                                  const SizedBox(width: 8),
                                  Text(fromDate != null ? '${fromDate!.day}/${fromDate!.month}/${fromDate!.year}' : 'Select date', style: GoogleFonts.spaceGrotesk()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('To Date', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () async {
                              final date = await showDatePicker(context: context, initialDate: fromDate ?? DateTime.now(), firstDate: fromDate ?? DateTime.now(), lastDate: DateTime(2027));
                              if (date != null) setDialogState(() => toDate = date);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 18, color: Color(0xFF6B7280)),
                                  const SizedBox(width: 8),
                                  Text(toDate != null ? '${toDate!.day}/${toDate!.month}/${toDate!.year}' : 'Select date', style: GoogleFonts.spaceGrotesk()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Reason
                Text('Reason', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                const SizedBox(height: 8),
                TextField(
                  controller: reasonController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter reason for leave...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.spaceGrotesk())),
            ElevatedButton(
              onPressed: () {
                if (fromDate != null && toDate != null && reasonController.text.isNotEmpty) {
                  final days = toDate!.difference(fromDate!).inDays + 1;
                  setState(() {
                    _leaveHistory.insert(0, {
                      'type': leaveType,
                      'from': '${fromDate!.day}/${fromDate!.month}/${fromDate!.year}',
                      'to': '${toDate!.day}/${toDate!.month}/${toDate!.year}',
                      'days': days,
                      'status': 'pending',
                      'reason': reasonController.text,
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Leave application submitted!', style: GoogleFonts.spaceGrotesk()),
                      backgroundColor: const Color(0xFF10B981),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
              child: Text('Submit Application', style: GoogleFonts.spaceGrotesk(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
