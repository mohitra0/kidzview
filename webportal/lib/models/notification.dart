class SchoolNotification {
  final String id;
  final String title;
  final String message;
  final DateTime createdAt;
  final String createdBy;
  final String recipientType; // 'all', 'camera', 'student'
  final String? recipientId; // null for 'all', cameraId or studentId
  final String? recipientName; // for display purposes
  final String? attachmentType; // 'image', 'video', 'document', null
  final String? attachmentUrl; // file path or URL
  final String? attachmentName; // original file name
  final bool isRead;
  final int recipientCount; // number of recipients

  SchoolNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.createdBy,
    required this.recipientType,
    this.recipientId,
    this.recipientName,
    this.attachmentType,
    this.attachmentUrl,
    this.attachmentName,
    this.isRead = false,
    required this.recipientCount,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
      'recipientType': recipientType,
      'recipientId': recipientId,
      'recipientName': recipientName,
      'attachmentType': attachmentType,
      'attachmentUrl': attachmentUrl,
      'attachmentName': attachmentName,
      'isRead': isRead,
      'recipientCount': recipientCount,
    };
  }

  // Create from JSON
  factory SchoolNotification.fromJson(Map<String, dynamic> json) {
    return SchoolNotification(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
      createdBy: json['createdBy'],
      recipientType: json['recipientType'],
      recipientId: json['recipientId'],
      recipientName: json['recipientName'],
      attachmentType: json['attachmentType'],
      attachmentUrl: json['attachmentUrl'],
      attachmentName: json['attachmentName'],
      isRead: json['isRead'] ?? false,
      recipientCount: json['recipientCount'] ?? 0,
    );
  }

  // Get recipient description
  String get recipientDescription {
    switch (recipientType) {
      case 'all':
        return 'All Students ($recipientCount recipients)';
      case 'camera':
        return '$recipientName ($recipientCount students)';
      case 'student':
        return recipientName ?? 'Unknown Student';
      default:
        return 'Unknown';
    }
  }

  // Get attachment icon
  String get attachmentIcon {
    switch (attachmentType) {
      case 'image':
        return '🖼️';
      case 'video':
        return '🎥';
      case 'document':
        return '📄';
      default:
        return '';
    }
  }
}

