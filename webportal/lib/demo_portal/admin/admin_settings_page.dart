import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  bool _streamingEnabled = true;
  bool _parentNotifications = true;
  bool _attendanceAlerts = true;
  String _streamQuality = '720p';
  String _timeLimit = '30 min';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w700)),
          Text('Configure school portal settings', style: GoogleFonts.spaceGrotesk(color: const Color(0xFF6B7280))),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildSchoolSettings()),
              const SizedBox(width: 24),
              Expanded(child: _buildStreamingSettings()),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildNotificationSettings()),
              const SizedBox(width: 24),
              Expanded(child: _buildAppSettings()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolSettings() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.business, color: Color(0xFF8B5CF6), size: 22),
              ),
              const SizedBox(width: 12),
              Text('School Information', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 24),
          _buildTextField('School Name', 'Modern Child Public School'),
          const SizedBox(height: 16),
          _buildTextField('Address', 'Sector 45, Gurugram, Haryana'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTextField('Contact', '+91 98765 43210')),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField('Email', 'info@mcpschool.edu')),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6)),
            child: Text('Save Changes', style: GoogleFonts.spaceGrotesk(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildStreamingSettings() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFF3B82F6).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.videocam, color: Color(0xFF3B82F6), size: 22),
              ),
              const SizedBox(width: 12),
              Text('Streaming Settings', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 24),
          _buildSwitchTile('Enable Live Streaming', 'Allow streaming for all classes', _streamingEnabled, (v) => setState(() => _streamingEnabled = v)),
          const Divider(height: 24),
          _buildDropdown('Default Quality', _streamQuality, ['480p', '720p', '1080p'], (v) => setState(() => _streamQuality = v!)),
          const SizedBox(height: 16),
          _buildDropdown('Parent View Limit', _timeLimit, ['No Limit', '15 min', '30 min', '60 min'], (v) => setState(() => _timeLimit = v!)),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.notifications, color: Color(0xFF10B981), size: 22),
              ),
              const SizedBox(width: 12),
              Text('Notification Settings', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 24),
          _buildSwitchTile('Parent Notifications', 'Send app notifications to parents', _parentNotifications, (v) => setState(() => _parentNotifications = v)),
          const Divider(height: 24),
          _buildSwitchTile('Attendance Alerts', 'Auto-send absence alerts', _attendanceAlerts, (v) => setState(() => _attendanceAlerts = v)),
        ],
      ),
    );
  }

  Widget _buildAppSettings() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFFF59E0B).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.phone_android, color: Color(0xFFF59E0B), size: 22),
              ),
              const SizedBox(width: 12),
              Text('Mobile App', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 24),
          _buildTextField('App Name', 'MCP School Parent App'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.color_lens),
                  label: Text('Change Theme', style: GoogleFonts.spaceGrotesk()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.image),
                  label: Text('Upload Logo', style: GoogleFonts.spaceGrotesk()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return TextField(
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600)),
              Text(subtitle, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: const Color(0xFF6B7280))),
            ],
          ),
        ),
        Switch(value: value, onChanged: onChanged, activeColor: const Color(0xFF8B5CF6)),
      ],
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: const Color(0xFF6B7280))),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(10)),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            items: items.map((i) => DropdownMenuItem(value: i, child: Text(i, style: GoogleFonts.spaceGrotesk()))).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
