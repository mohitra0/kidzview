import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification.dart';

class NotificationService {
  static const String _keyNotifications = 'school_notifications';

  // Get all notifications
  static Future<List<SchoolNotification>> getAllNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notificationsJson = prefs.getString(_keyNotifications);
    
    if (notificationsJson == null) return [];
    
    final List<dynamic> decoded = jsonDecode(notificationsJson);
    return decoded.map((json) => SchoolNotification.fromJson(json)).toList();
  }

  // Get notifications sorted by date (newest first)
  static Future<List<SchoolNotification>> getNotificationsSorted() async {
    final notifications = await getAllNotifications();
    notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return notifications;
  }

  // Add notification
  static Future<void> addNotification(SchoolNotification notification) async {
    final notifications = await getAllNotifications();
    notifications.add(notification);
    await _saveNotifications(notifications);
  }

  // Update notification
  static Future<void> updateNotification(SchoolNotification notification) async {
    final notifications = await getAllNotifications();
    final index = notifications.indexWhere((n) => n.id == notification.id);
    if (index != -1) {
      notifications[index] = notification;
      await _saveNotifications(notifications);
    }
  }

  // Delete notification
  static Future<void> deleteNotification(String notificationId) async {
    final notifications = await getAllNotifications();
    notifications.removeWhere((n) => n.id == notificationId);
    await _saveNotifications(notifications);
  }

  // Save notifications to storage
  static Future<void> _saveNotifications(List<SchoolNotification> notifications) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        notifications.map((n) => n.toJson()).toList();
    await prefs.setString(_keyNotifications, jsonEncode(jsonList));
  }

  // Get notification count
  static Future<int> getNotificationCount() async {
    final notifications = await getAllNotifications();
    return notifications.length;
  }

  // Get unread notification count
  static Future<int> getUnreadCount() async {
    final notifications = await getAllNotifications();
    return notifications.where((n) => !n.isRead).length;
  }

  // Mark notification as read
  static Future<void> markAsRead(String notificationId) async {
    final notifications = await getAllNotifications();
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      final notification = notifications[index];
      final updatedNotification = SchoolNotification(
        id: notification.id,
        title: notification.title,
        message: notification.message,
        createdAt: notification.createdAt,
        createdBy: notification.createdBy,
        recipientType: notification.recipientType,
        recipientId: notification.recipientId,
        recipientName: notification.recipientName,
        attachmentType: notification.attachmentType,
        attachmentUrl: notification.attachmentUrl,
        attachmentName: notification.attachmentName,
        isRead: true,
        recipientCount: notification.recipientCount,
      );
      notifications[index] = updatedNotification;
      await _saveNotifications(notifications);
    }
  }

  // Get notifications by recipient type
  static Future<List<SchoolNotification>> getNotificationsByType(String type) async {
    final notifications = await getAllNotifications();
    return notifications.where((n) => n.recipientType == type).toList();
  }
}

