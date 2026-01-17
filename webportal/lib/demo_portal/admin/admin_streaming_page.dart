import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminStreamingPage extends StatefulWidget {
  const AdminStreamingPage({super.key});

  @override
  State<AdminStreamingPage> createState() => _AdminStreamingPageState();
}

class _AdminStreamingPageState extends State<AdminStreamingPage> {
  final List<Map<String, dynamic>> _cameras = [
    {'id': 'CAM001', 'name': 'Class 5A', 'room': '101', 'status': 'live', 'viewers': 28, 'quality': '720p', 'uptime': '4h 23m'},
    {'id': 'CAM002', 'name': 'Class 5B', 'room': '102', 'status': 'live', 'viewers': 25, 'quality': '720p', 'uptime': '4h 23m'},
    {'id': 'CAM003', 'name': 'Class 6A', 'room': '201', 'status': 'live', 'viewers': 32, 'quality': '720p', 'uptime': '4h 22m'},
    {'id': 'CAM004', 'name': 'Class 6B', 'room': '202', 'status': 'offline', 'viewers': 0, 'quality': '-', 'uptime': '-'},
    {'id': 'CAM005', 'name': 'Class 7A', 'room': '301', 'status': 'live', 'viewers': 30, 'quality': '720p', 'uptime': '4h 20m'},
    {'id': 'CAM006', 'name': 'Science Lab', 'room': 'Lab 1', 'status': 'live', 'viewers': 18, 'quality': '480p', 'uptime': '2h 15m'},
    {'id': 'CAM007', 'name': 'Playground', 'room': 'Ground', 'status': 'offline', 'viewers': 0, 'quality': '-', 'uptime': '-'},
    {'id': 'CAM008', 'name': 'Cafeteria', 'room': 'Cafeteria', 'status': 'live', 'viewers': 45, 'quality': '720p', 'uptime': '4h 23m'},
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
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Live Streaming', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
                  Text('Monitor & control all school cameras', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
                ],
              ),
              const Spacer(),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.wifi_off), label: Text('Stop All', style: GoogleFonts.spaceGrotesk())),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow, color: Colors.white),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
                label: Text('Start All', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Stats
          Row(
            children: [
              _buildStatCard('Live Cameras', '$liveCount / ${_cameras.length}', Icons.videocam, const Color(0xFF10B981)),
              const SizedBox(width: 16),
              _buildStatCard('Total Viewers', '$totalViewers', Icons.visibility, const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatCard('Bandwidth Usage', '842 Mbps', Icons.speed, const Color(0xFF8B5CF6)),
              const SizedBox(width: 16),
              _buildStatCard('Storage Used', '2.4 TB', Icons.storage, const Color(0xFFF59E0B)),
            ],
          ),
          const SizedBox(height: 24),
          // Camera Grid
          Text('All Cameras', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.9, crossAxisSpacing: 16, mainAxisSpacing: 16),
            itemCount: _cameras.length,
            itemBuilder: (context, index) => _buildCameraCard(_cameras[index]),
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
                Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
                Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraCard(Map<String, dynamic> camera) {
    final isLive = camera['status'] == 'live';
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isLive ? const Color(0xFF10B981) : const Color(0xFFE5E7EB), width: isLive ? 2 : 1),
      ),
      child: Column(
        children: [
          // Camera Preview
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              ),
              child: Stack(
                children: [
                  Center(child: Icon(isLive ? Icons.videocam : Icons.videocam_off, color: isLive ? Colors.white : Colors.grey, size: 32)),
                  if (isLive) Positioned(
                    top: 8, left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: const Color(0xFFEF4444), borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                          const SizedBox(width: 4),
                          Text('LIVE', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                  if (isLive) Positioned(
                    top: 8, right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          const Icon(Icons.visibility, size: 12, color: Colors.white),
                          const SizedBox(width: 3),
                          Text('${camera['viewers']}', style: GoogleFonts.spaceGrotesk(color: Colors.white, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(camera['name'], style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600))),
                    Switch(value: isLive, onChanged: (v) => setState(() => camera['status'] = v ? 'live' : 'offline'), activeColor: const Color(0xFF10B981)),
                  ],
                ),
                Text('Room: ${camera['room']} • ${camera['quality']}', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: const Color(0xFF6B7280))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
