import 'package:shared_preferences/shared_preferences.dart';

/// Alta Global School - IT SHS (Grades 10 & 11)
/// Week 14: Sprint 3 - Local Storage Helper
///
/// This helper shows you how to save and load 1 piece of text (like your user's name)
/// so your app remembers it even if the phone restarts or the app is closed!
///
/// Remember to add this to your pubspec.yaml:
/// dependencies:
///   flutter:
///     sdk: flutter
///   shared_preferences: ^2.2.2
class StorageHelper {
  // Key name used in the phone's storage
  static const String _userNameKey = 'user_name';

  /// Save the user's name to disk
  static Future<void> saveUserName(String name) async {
    // 1. Open the phone's storage notebook
    final prefs = await SharedPreferences.getInstance();

    // 2. Write the name into storage
    await prefs.setString(_userNameKey, name);
  }

  /// Read the user's name from disk
  static Future<String> getUserName() async {
    // 1. Open the phone's storage notebook
    final prefs = await SharedPreferences.getInstance();

    // 2. Read the name (or return 'Guest' if nothing is saved yet)
    return prefs.getString(_userNameKey) ?? 'Guest';
  }

  /// Delete or reset the saved name
  static Future<void> clearUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userNameKey);
  }
}
