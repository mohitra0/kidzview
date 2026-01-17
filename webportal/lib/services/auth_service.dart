import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserEmail = 'userEmail';
  static const String _keyUserName = 'userName';

  // Save login state
  static Future<void> saveLoginState({
    required String email,
    required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUserEmail, email);
    await prefs.setString(_keyUserName, name);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Get user email
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail);
  }

  // Get user name
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

