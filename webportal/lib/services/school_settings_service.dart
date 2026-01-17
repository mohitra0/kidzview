import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/school_settings.dart';

class SchoolSettingsService {
  static const String _keySettings = 'school_settings';

  // Get school settings
  static Future<SchoolSettings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final String? settingsJson = prefs.getString(_keySettings);
    
    if (settingsJson == null) {
      // Return default settings if none exist
      return SchoolSettings.defaults();
    }
    
    return SchoolSettings.fromJson(jsonDecode(settingsJson));
  }

  // Save school settings
  static Future<void> saveSettings(SchoolSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keySettings, jsonEncode(settings.toJson()));
  }

  // Check if settings have been configured
  static Future<bool> isConfigured() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keySettings);
  }

  // Reset to defaults
  static Future<void> resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keySettings);
  }

  // Update specific field
  static Future<void> updateField(String field, dynamic value) async {
    final settings = await getSettings();
    SchoolSettings updatedSettings;

    switch (field) {
      case 'logoUrl':
        updatedSettings = settings.copyWith(logoUrl: value as String?);
        break;
      case 'primaryColor':
        updatedSettings = settings.copyWith(primaryColor: value as String);
        break;
      case 'schoolName':
        updatedSettings = settings.copyWith(schoolName: value as String);
        break;
      case 'tagline':
        updatedSettings = settings.copyWith(tagline: value as String);
        break;
      case 'schoolAddress':
        updatedSettings = settings.copyWith(schoolAddress: value as String);
        break;
      case 'phoneNumber':
        updatedSettings = settings.copyWith(phoneNumber: value as String);
        break;
      case 'email':
        updatedSettings = settings.copyWith(email: value as String);
        break;
      case 'website':
        updatedSettings = settings.copyWith(website: value as String);
        break;
      case 'principalName':
        updatedSettings = settings.copyWith(principalName: value as String);
        break;
      case 'establishedYear':
        updatedSettings = settings.copyWith(establishedYear: value as String);
        break;
      case 'schoolTiming':
        updatedSettings = settings.copyWith(schoolTiming: value as String);
        break;
      case 'aboutUs':
        updatedSettings = settings.copyWith(aboutUs: value as String);
        break;
      case 'appDisplayName':
        updatedSettings = settings.copyWith(appDisplayName: value as String);
        break;
      case 'welcomeMessage':
        updatedSettings = settings.copyWith(welcomeMessage: value as String);
        break;
      case 'emergencyContact':
        updatedSettings = settings.copyWith(emergencyContact: value as String);
        break;
      case 'facebookUrl':
        updatedSettings = settings.copyWith(facebookUrl: value as String?);
        break;
      case 'instagramUrl':
        updatedSettings = settings.copyWith(instagramUrl: value as String?);
        break;
      case 'twitterUrl':
        updatedSettings = settings.copyWith(twitterUrl: value as String?);
        break;
      case 'youtubeUrl':
        updatedSettings = settings.copyWith(youtubeUrl: value as String?);
        break;
      default:
        return;
    }

    await saveSettings(updatedSettings);
  }
}

