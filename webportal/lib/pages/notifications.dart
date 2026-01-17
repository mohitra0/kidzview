import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../utils/resize.dart';
import '../models/notification.dart';
import '../models/student.dart';
import '../services/notification_service.dart';
import '../services/student_service.dart';
import '../services/auth_service.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final Resize resize = Resize();
  bool isLoading = true;
  List<SchoolNotification> notifications = [];
  String currentView = 'history'; // 'history' or 'compose'

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resize.setValue(context);
      _loadNotifications();
    });
  }

  Future<void> _loadNotifications() async {
    setState(() => isLoading = true);
    notifications = await NotificationService.getNotificationsSorted();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(resize.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: resize.height * 0.025),
          _buildViewToggle(),
          SizedBox(height: resize.height * 0.025),
          if (currentView == 'compose') _buildComposeSection() else _buildHistorySection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.02),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3b82f6), Color(0xFF2563eb)],
        ),
        borderRadius: BorderRadius.circular(resize.width * 0.012),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(resize.width * 0.015),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(resize.width * 0.008),
            ),
            child: Icon(
              Icons.notifications_active,
              color: Colors.white,
              size: resize.iconSize * 2.5,
            ),
          ),
          SizedBox(width: resize.width * 0.015),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'School Updates & Notifications',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.heading1,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: resize.height * 0.005),
                Text(
                  'Send updates to parents via mobile app • ${notifications.length} notifications sent',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizebase,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: resize.width * 0.015,
              vertical: resize.height * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(resize.width * 0.006),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Text(
                  '${notifications.length}',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.heading1,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Total Sent',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: resize.fontSizeSmall,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggle() {
    return Container(
      padding: EdgeInsets.all(resize.width * 0.005),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(resize.width * 0.008),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton('history', 'Notification History', Icons.history),
          SizedBox(width: resize.width * 0.005),
          _buildToggleButton('compose', 'Send New Update', Icons.send),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String view, String label, IconData icon) {
    final isSelected = currentView == view;
    return InkWell(
      onTap: () {
        setState(() {
          currentView = view;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: resize.width * 0.02,
          vertical: resize.height * 0.015,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3b82f6) : Colors.transparent,
          borderRadius: BorderRadius.circular(resize.width * 0.006),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: resize.iconSize * 1.2,
              color: isSelected ? Colors.white : const Color(0xFF6b7280),
            ),
            SizedBox(width: resize.width * 0.008),
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizebase,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF6b7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComposeSection() {
    return _ComposeNotificationForm(
      resize: resize,
      onNotificationSent: () async {
        await _loadNotifications();
        setState(() {
          currentView = 'history';
        });
      },
    );
  }

  Widget _buildHistorySection() {
    if (notifications.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.history,
              color: const Color(0xFF1f2937),
              size: resize.iconSize * 1.5,
            ),
            SizedBox(width: resize.width * 0.01),
            Text(
              'Notification History',
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.heading2,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1f2937),
              ),
            ),
          ],
        ),
        SizedBox(height: resize.height * 0.02),
        ...notifications.map((notification) => _buildNotificationCard(notification)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(resize.width * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: resize.iconSize * 5,
              color: const Color(0xFF9ca3af),
            ),
            SizedBox(height: resize.height * 0.02),
            Text(
              'No Notifications Sent Yet',
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.heading2,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6b7280),
              ),
            ),
            SizedBox(height: resize.height * 0.01),
            Text(
              'Send your first notification to parents using the "Send New Update" button above',
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizebase,
                color: const Color(0xFF9ca3af),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(SchoolNotification notification) {
    return Container(
      margin: EdgeInsets.only(bottom: resize.height * 0.015),
      padding: EdgeInsets.all(resize.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(resize.width * 0.01),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(resize.width * 0.01),
                decoration: BoxDecoration(
                  color: const Color(0xFF3b82f6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(resize.width * 0.006),
                ),
                child: Icon(
                  Icons.campaign,
                  color: const Color(0xFF3b82f6),
                  size: resize.iconSize * 1.3,
                ),
              ),
              SizedBox(width: resize.width * 0.012),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: resize.fontSizeLarge,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1f2937),
                      ),
                    ),
                    SizedBox(height: resize.height * 0.003),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: resize.lableText,
                          color: const Color(0xFF6b7280),
                        ),
                        SizedBox(width: resize.width * 0.003),
                        Text(
                          DateFormat('MMM dd, yyyy • hh:mm a').format(notification.createdAt),
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: resize.fontSizeSmall,
                            color: const Color(0xFF6b7280),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: const Color(0xFFEF4444),
                  size: resize.iconSize * 1.2,
                ),
                onPressed: () => _confirmDeleteNotification(notification),
              ),
            ],
          ),
          SizedBox(height: resize.height * 0.015),
          Container(
            padding: EdgeInsets.all(resize.width * 0.012),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(resize.width * 0.006),
            ),
            child: Text(
              notification.message,
              style: GoogleFonts.spaceGrotesk(
                fontSize: resize.fontSizebase,
                color: const Color(0xFF1f2937),
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: resize.height * 0.015),
          Row(
            children: [
              _buildInfoChip(
                Icons.people,
                notification.recipientDescription,
                const Color(0xFF10b981),
              ),
              SizedBox(width: resize.width * 0.01),
              _buildInfoChip(
                Icons.person,
                'By ${notification.createdBy}',
                const Color(0xFF8b5cf6),
              ),
              if (notification.attachmentType != null) ...[
                SizedBox(width: resize.width * 0.01),
                _buildInfoChip(
                  _getAttachmentIcon(notification.attachmentType!),
                  notification.attachmentName ?? 'Attachment',
                  const Color(0xFF3b82f6),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  IconData _getAttachmentIcon(String type) {
    switch (type) {
      case 'image':
        return Icons.image;
      case 'video':
        return Icons.videocam;
      case 'document':
        return Icons.description;
      default:
        return Icons.attach_file;
    }
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: resize.width * 0.01,
        vertical: resize.height * 0.006,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(resize.width * 0.004),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: resize.lableText,
            color: color,
          ),
          SizedBox(width: resize.width * 0.005),
          Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              fontSize: resize.fontSizeSmall,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteNotification(SchoolNotification notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(resize.width * 0.012),
        ),
        title: Text(
          'Delete Notification?',
          style: GoogleFonts.spaceGrotesk(
            fontSize: resize.heading3,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this notification from history? This action cannot be undone.',
          style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await NotificationService.deleteNotification(notification.id);
              await _loadNotifications();
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Notification deleted',
                      style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
                    ),
                    backgroundColor: const Color(0xFF10b981),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.spaceGrotesk(fontSize: resize.fontSizeSmall),
            ),
          ),
        ],
      ),
    );
  }
}

// Compose Notification Form Widget
class _ComposeNotificationForm extends StatefulWidget {
  final Resize resize;
  final VoidCallback onNotificationSent;

  const _ComposeNotificationForm({
    required this.resize,
    required this.onNotificationSent,
  });

  @override
  State<_ComposeNotificationForm> createState() => _ComposeNotificationFormState();
}

class _ComposeNotificationFormState extends State<_ComposeNotificationForm> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  String _recipientType = 'all'; // 'all', 'camera', 'student'
  String? _selectedCameraId;
  String? _selectedStudentId;
  String? _attachmentType;
  String? _attachmentName;
  bool _isSending = false;

  Map<String, String> cameraNames = {};
  List<Student> allStudents = [];
  List<Student> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    cameraNames = await StudentService.getAllCameraNames();
    allStudents = await StudentService.getAllStudents();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget.resize.width * 0.025),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.resize.width * 0.012),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(widget.resize.width * 0.012),
                decoration: BoxDecoration(
                  color: const Color(0xFF3b82f6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(widget.resize.width * 0.008),
                ),
                child: Icon(
                  Icons.edit_notifications,
                  color: const Color(0xFF3b82f6),
                  size: widget.resize.iconSize * 2,
                ),
              ),
              SizedBox(width: widget.resize.width * 0.015),
              Text(
                'Compose New Notification',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: widget.resize.heading2,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1f2937),
                ),
              ),
            ],
          ),
          SizedBox(height: widget.resize.height * 0.03),
          
          // Recipient Selection
          _buildRecipientSection(),
          SizedBox(height: widget.resize.height * 0.025),
          
          // Title
          _buildTextField(
            'Notification Title *',
            'e.g., School Holiday Notice, Field Trip Reminder',
            _titleController,
            maxLines: 1,
          ),
          SizedBox(height: widget.resize.height * 0.02),
          
          // Message
          _buildTextField(
            'Message *',
            'Write your message to parents here...',
            _messageController,
            maxLines: 6,
          ),
          SizedBox(height: widget.resize.height * 0.025),
          
          // Attachment Section
          _buildAttachmentSection(),
          SizedBox(height: widget.resize.height * 0.03),
          
          // Send Button
          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildRecipientSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Send To *',
          style: GoogleFonts.spaceGrotesk(
            fontSize: widget.resize.fontSizeLarge,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1f2937),
          ),
        ),
        SizedBox(height: widget.resize.height * 0.015),
        
        // Recipient Type Buttons
        Row(
          children: [
            Expanded(
              child: _buildRecipientTypeButton(
                'all',
                'All Students',
                Icons.groups,
                'Send to all parents',
              ),
            ),
            SizedBox(width: widget.resize.width * 0.015),
            Expanded(
              child: _buildRecipientTypeButton(
                'camera',
                'Specific Camera',
                Icons.videocam,
                'Select a camera/class',
              ),
            ),
            SizedBox(width: widget.resize.width * 0.015),
            Expanded(
              child: _buildRecipientTypeButton(
                'student',
                'Single Student',
                Icons.person,
                'Select one student',
              ),
            ),
          ],
        ),
        
        // Dropdown for Camera/Student selection
        if (_recipientType == 'camera') ...[
          SizedBox(height: widget.resize.height * 0.015),
          _buildCameraDropdown(),
        ],
        if (_recipientType == 'student') ...[
          SizedBox(height: widget.resize.height * 0.015),
          _buildStudentDropdown(),
        ],
      ],
    );
  }

  Widget _buildRecipientTypeButton(
    String type,
    String title,
    IconData icon,
    String subtitle,
  ) {
    final isSelected = _recipientType == type;
    return InkWell(
      onTap: () {
        setState(() {
          _recipientType = type;
          _selectedCameraId = null;
          _selectedStudentId = null;
        });
      },
      child: Container(
        padding: EdgeInsets.all(widget.resize.width * 0.015),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3b82f6).withOpacity(0.1)
              : const Color(0xFFF9FAFB),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3b82f6)
                : const Color(0xFFE5E7EB),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(widget.resize.width * 0.008),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF3b82f6)
                  : const Color(0xFF6b7280),
              size: widget.resize.iconSize * 2,
            ),
            SizedBox(height: widget.resize.height * 0.01),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: widget.resize.fontSizebase,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF3b82f6)
                    : const Color(0xFF1f2937),
              ),
            ),
            SizedBox(height: widget.resize.height * 0.003),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                fontSize: widget.resize.fontSizeSmall,
                color: const Color(0xFF9ca3af),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraDropdown() {
    // Get cameras that have students
    final camerasWithStudents = cameraNames.entries.toList();
    
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select Camera',
        prefixIcon: const Icon(Icons.videocam, color: Color(0xFF3b82f6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.resize.width * 0.008),
        ),
      ),
      value: _selectedCameraId,
      items: camerasWithStudents.map((entry) {
        return DropdownMenuItem(
          value: entry.key,
          child: Text(
            entry.value,
            style: GoogleFonts.spaceGrotesk(fontSize: widget.resize.fontSizebase),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCameraId = value;
        });
      },
    );
  }

  Widget _buildStudentDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select Student',
        prefixIcon: const Icon(Icons.person, color: Color(0xFF3b82f6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.resize.width * 0.008),
        ),
      ),
      value: _selectedStudentId,
      items: allStudents.map((student) {
        return DropdownMenuItem(
          value: student.id,
          child: Text(
            student.fullName,
            style: GoogleFonts.spaceGrotesk(fontSize: widget.resize.fontSizebase),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedStudentId = value;
        });
      },
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: widget.resize.fontSizeLarge,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1f2937),
          ),
        ),
        SizedBox(height: widget.resize.height * 0.01),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.spaceGrotesk(
              fontSize: widget.resize.fontSizebase,
              color: const Color(0xFF9ca3af),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.resize.width * 0.008),
            ),
            contentPadding: EdgeInsets.all(widget.resize.width * 0.015),
          ),
          style: GoogleFonts.spaceGrotesk(fontSize: widget.resize.fontSizebase),
        ),
      ],
    );
  }

  Widget _buildAttachmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attachments (Optional)',
          style: GoogleFonts.spaceGrotesk(
            fontSize: widget.resize.fontSizeLarge,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1f2937),
          ),
        ),
        SizedBox(height: widget.resize.height * 0.015),
        Row(
          children: [
            Expanded(
              child: _buildAttachmentButton(
                'Image',
                Icons.image,
                'image',
                const Color(0xFF10b981),
              ),
            ),
            SizedBox(width: widget.resize.width * 0.015),
            Expanded(
              child: _buildAttachmentButton(
                'Video',
                Icons.videocam,
                'video',
                const Color(0xFFEF4444),
              ),
            ),
            SizedBox(width: widget.resize.width * 0.015),
            Expanded(
              child: _buildAttachmentButton(
                'Document',
                Icons.description,
                'document',
                const Color(0xFF8b5cf6),
              ),
            ),
          ],
        ),
        if (_attachmentType != null) ...[
          SizedBox(height: widget.resize.height * 0.015),
          Container(
            padding: EdgeInsets.all(widget.resize.width * 0.015),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(widget.resize.width * 0.006),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                Icon(
                  _attachmentType == 'image'
                      ? Icons.image
                      : _attachmentType == 'video'
                          ? Icons.videocam
                          : Icons.description,
                  color: const Color(0xFF3b82f6),
                  size: widget.resize.iconSize * 1.5,
                ),
                SizedBox(width: widget.resize.width * 0.01),
                Expanded(
                  child: Text(
                    _attachmentName ?? 'No file selected',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: widget.resize.fontSizebase,
                      color: const Color(0xFF1f2937),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFFEF4444)),
                  onPressed: () {
                    setState(() {
                      _attachmentType = null;
                      _attachmentName = null;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAttachmentButton(
    String label,
    IconData icon,
    String type,
    Color color,
  ) {
    return ElevatedButton.icon(
      onPressed: () {
        // Simulate file picker
        setState(() {
          _attachmentType = type;
          _attachmentName = 'sample_$type.${type == 'document' ? 'pdf' : type == 'image' ? 'jpg' : 'mp4'}';
        });
      },
      icon: Icon(icon, size: widget.resize.iconSize),
      label: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          fontSize: widget.resize.fontSizeSmall,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: widget.resize.width * 0.015,
          vertical: widget.resize.height * 0.015,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.resize.width * 0.006),
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isSending ? null : _sendNotification,
        icon: _isSending
            ? SizedBox(
                width: widget.resize.iconSize,
                height: widget.resize.iconSize,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(Icons.send, size: widget.resize.iconSize * 1.5),
        label: Text(
          _isSending ? 'Sending...' : 'Send Notification to Parents',
          style: GoogleFonts.spaceGrotesk(
            fontSize: widget.resize.fontSizeLarge,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3b82f6),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: widget.resize.height * 0.02,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.resize.width * 0.008),
          ),
        ),
      ),
    );
  }

  Future<void> _sendNotification() async {
    // Validation
    if (_titleController.text.trim().isEmpty) {
      _showError('Please enter a notification title');
      return;
    }
    if (_messageController.text.trim().isEmpty) {
      _showError('Please enter a message');
      return;
    }
    if (_recipientType == 'camera' && _selectedCameraId == null) {
      _showError('Please select a camera');
      return;
    }
    if (_recipientType == 'student' && _selectedStudentId == null) {
      _showError('Please select a student');
      return;
    }

    setState(() => _isSending = true);

    // Calculate recipient count and name
    int recipientCount = 0;
    String? recipientName;

    if (_recipientType == 'all') {
      recipientCount = allStudents.length;
    } else if (_recipientType == 'camera') {
      final studentsInCamera = await StudentService.getStudentsByCamera(_selectedCameraId!);
      recipientCount = studentsInCamera.length;
      recipientName = cameraNames[_selectedCameraId];
    } else {
      recipientCount = 1;
      recipientName = allStudents.firstWhere((s) => s.id == _selectedStudentId).fullName;
    }

    // Get current user
    final userName = await AuthService.getUserName() ?? 'Teacher';

    // Create notification
    final notification = SchoolNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      message: _messageController.text.trim(),
      createdAt: DateTime.now(),
      createdBy: userName,
      recipientType: _recipientType,
      recipientId: _recipientType == 'camera'
          ? _selectedCameraId
          : _recipientType == 'student'
              ? _selectedStudentId
              : null,
      recipientName: recipientName,
      attachmentType: _attachmentType,
      attachmentUrl: _attachmentName,
      attachmentName: _attachmentName,
      recipientCount: recipientCount,
    );

    await NotificationService.addNotification(notification);

    setState(() => _isSending = false);

    // Clear form
    _titleController.clear();
    _messageController.clear();
    setState(() {
      _recipientType = 'all';
      _selectedCameraId = null;
      _selectedStudentId = null;
      _attachmentType = null;
      _attachmentName = null;
    });

    // Show success
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: widget.resize.iconSize),
              SizedBox(width: widget.resize.width * 0.01),
              Text(
                'Notification sent to $recipientCount parent(s)!',
                style: GoogleFonts.spaceGrotesk(fontSize: widget.resize.fontSizeSmall),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF10b981),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.resize.width * 0.006),
          ),
        ),
      );
    }

    widget.onNotificationSent();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.spaceGrotesk(fontSize: widget.resize.fontSizeSmall),
        ),
        backgroundColor: const Color(0xFFEF4444),
      ),
    );
  }
}

