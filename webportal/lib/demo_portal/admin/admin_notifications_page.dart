import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminNotificationsPage extends StatefulWidget {
  const AdminNotificationsPage({super.key});

  @override
  State<AdminNotificationsPage> createState() => _AdminNotificationsPageState();
}

class _AdminNotificationsPageState extends State<AdminNotificationsPage> {
  final List<Map<String, dynamic>> _notifications = [
    {'title': 'PTM Reminder', 'message': 'Parent Teacher Meeting scheduled for Jan 20, 2026', 'sentTo': 'All Parents', 'time': 'Jan 16, 10:30 AM', 'status': 'sent', 'recipients': 842},
    {'title': 'Fee Due Reminder', 'message': 'Last date for Q4 fee payment is Jan 25, 2026', 'sentTo': 'Selected Parents', 'time': 'Jan 15, 2:00 PM', 'status': 'sent', 'recipients': 156},
    {'title': 'Annual Day Notice', 'message': 'Annual Day celebrations on Feb 10, 2026. Students to report by 8 AM.', 'sentTo': 'All Parents', 'time': 'Jan 14, 11:00 AM', 'status': 'sent', 'recipients': 1248},
    {'title': 'School Holiday', 'message': 'School will remain closed on Jan 26 for Republic Day', 'sentTo': 'All Users', 'time': 'Jan 12, 9:00 AM', 'status': 'sent', 'recipients': 2100},
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notifications', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('Send notifications to parents, teachers & staff', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _showSendNotificationDialog,
                icon: const Icon(Icons.send, color: Colors.white),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
                label: Text('Send Notification', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Stats
          Row(
            children: [
              _buildStatCard('Total Sent', '4,256', Icons.send, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('This Month', '342', Icons.calendar_month, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Delivery Rate', '99.2%', Icons.check_circle, const Color(0xFF8B5CF6)),
              const SizedBox(width: 16),
              _buildStatCard('App Users', '1,892', Icons.phone_android, const Color(0xFFF59E0B)),
            ],
          ),
          const SizedBox(height: 24),
          // Recent Notifications
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('Recent Notifications', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final n = _notifications[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.notifications, color: Color(0xFF8B5CF6), size: 20),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(n['title'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600, fontSize: 15)),
                                    const SizedBox(height: 4),
                                    Text(n['message'], style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.people, size: 14, color: Color(0xFF9CA3AF)),
                                        const SizedBox(width: 4),
                                        Text('${n['recipients']} recipients', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF9CA3AF))),
                                        const SizedBox(width: 16),
                                        const Icon(Icons.access_time, size: 14, color: Color(0xFF9CA3AF)),
                                        const SizedBox(width: 4),
                                        Text(n['time'], style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF9CA3AF))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                                child: Text('Sent', style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF10B981))),
                              ),
                            ],
                          ),
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

  void _showSendNotificationDialog() {
    String sendTo = 'all_parents';
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Send Notification', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
          content: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
                const SizedBox(height: 16),
                TextField(maxLines: 3, decoration: InputDecoration(labelText: 'Message', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
                const SizedBox(height: 16),
                Text('Send To:', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(label: Text('All Parents', style: GoogleFonts.spaceGrotesk()), selected: sendTo == 'all_parents', onSelected: (_) => setDialogState(() => sendTo = 'all_parents')),
                    ChoiceChip(label: Text('All Teachers', style: GoogleFonts.spaceGrotesk()), selected: sendTo == 'all_teachers', onSelected: (_) => setDialogState(() => sendTo = 'all_teachers')),
                    ChoiceChip(label: Text('Specific Class', style: GoogleFonts.spaceGrotesk()), selected: sendTo == 'class', onSelected: (_) => setDialogState(() => sendTo = 'class')),
                    ChoiceChip(label: Text('All Users', style: GoogleFonts.spaceGrotesk()), selected: sendTo == 'all', onSelected: (_) => setDialogState(() => sendTo = 'all')),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.spaceGrotesk())),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.send, color: Colors.white, size: 18),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6)),
              label: Text('Send', style: GoogleFonts.spaceGrotesk(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
