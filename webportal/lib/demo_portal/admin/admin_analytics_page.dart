import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminAnalyticsPage extends StatelessWidget {
  const AdminAnalyticsPage({super.key});

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
                  Text('Analytics & Reports', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('Insights and performance metrics', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(
                  value: 'This Month',
                  underline: const SizedBox(),
                  items: ['Today', 'This Week', 'This Month', 'This Year'].map((p) => DropdownMenuItem(value: p, child: Text(p, style: GoogleFonts.spaceGrotesk()))).toList(),
                  onChanged: (_) {},
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: Text('Export Report', style: GoogleFonts.spaceGrotesk())),
            ],
          ),
          const SizedBox(height: 24),
          // Key Metrics
          Row(
            children: [
              _buildMetricCard('Student Growth', '+12%', '48 new this month', Icons.trending_up, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildMetricCard('Avg Attendance', '92.4%', '+2.1% from last month', Icons.fact_check, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildMetricCard('Fee Collection', '₹18.5L', '84% of target', Icons.currency_rupee, const Color(0xFF8B5CF6)),
              const SizedBox(width: 16),
              _buildMetricCard('Stream Views', '24,580', '+18% engagement', Icons.visibility, const Color(0xFFF59E0B)),
            ],
          ),
          const SizedBox(height: 24),
          // Charts Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildAttendanceChart()),
              const SizedBox(width: 24),
              Expanded(child: _buildTopClasses()),
            ],
          ),
          const SizedBox(height: 24),
          // More Analytics
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildStreamingStats()),
              const SizedBox(width: 24),
              Expanded(child: _buildFeeAnalytics()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: color, size: 22),
                ),
                const Spacer(),
                Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.w700, color: color)),
              ],
            ),
            const SizedBox(height: 12),
            Text(title, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
            Text(subtitle, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceChart() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Monthly Attendance Trend', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar('Jan', 0.88, const Color(0xFF3B82F6)),
                _buildBar('Feb', 0.91, const Color(0xFF3B82F6)),
                _buildBar('Mar', 0.85, const Color(0xFF3B82F6)),
                _buildBar('Apr', 0.92, const Color(0xFF3B82F6)),
                _buildBar('May', 0.89, const Color(0xFF3B82F6)),
                _buildBar('Jun', 0.75, const Color(0xFF3B82F6)),
                _buildBar('Jul', 0.78, const Color(0xFF3B82F6)),
                _buildBar('Aug', 0.90, const Color(0xFF3B82F6)),
                _buildBar('Sep', 0.93, const Color(0xFF3B82F6)),
                _buildBar('Oct', 0.91, const Color(0xFF3B82F6)),
                _buildBar('Nov', 0.88, const Color(0xFF3B82F6)),
                _buildBar('Dec', 0.86, const Color(0xFF3B82F6)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String label, double value, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 160 * value,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [color, color.withOpacity(0.6)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 8),
            Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
          ],
        ),
      ),
    );
  }

  Widget _buildTopClasses() {
    final classes = [
      {'name': 'Class 5A', 'attendance': 96, 'color': const Color(0xFF10B981)},
      {'name': 'Class 7B', 'attendance': 94, 'color': const Color(0xFF3B82F6)},
      {'name': 'Class 6A', 'attendance': 93, 'color': const Color(0xFF8B5CF6)},
      {'name': 'Class 5B', 'attendance': 91, 'color': const Color(0xFFF59E0B)},
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top Performing Classes', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          ...classes.map((c) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: (c['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.class_, color: c['color'] as Color, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(c['name'] as String, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w500))),
                Text('${c['attendance']}%', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, color: c['color'] as Color)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildStreamingStats() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Streaming Statistics', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          _buildStatRow('Peak Viewers', '458', const Color(0xFF3B82F6)),
          _buildStatRow('Avg Watch Time', '23 min', const Color(0xFF10B981)),
          _buildStatRow('Total Stream Hours', '1,240h', const Color(0xFF8B5CF6)),
          _buildStatRow('Most Viewed Class', '5A', const Color(0xFFF59E0B)),
        ],
      ),
    );
  }

  Widget _buildFeeAnalytics() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fee Collection', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          _buildStatRow('Collected', '₹18.5L', const Color(0xFF10B981)),
          _buildStatRow('Pending', '₹4.2L', const Color(0xFFEF4444)),
          _buildStatRow('Collection Rate', '84%', const Color(0xFF3B82F6)),
          _buildStatRow('Defaulters', '42', const Color(0xFFF59E0B)),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(width: 4, height: 24, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280)))),
          Text(value, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
