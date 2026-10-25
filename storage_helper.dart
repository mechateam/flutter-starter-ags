import 'package:shared_preferences/shared_preferences.dart';

/// Alta Global School: IT SHS (Grades 10 & 11)
/// Week 14 & 15 Combined: Sprint 3 Storage & Data Helper
/// Teacher: Meldi
///
/// This helper handles phone disk storage (Local Storage) using SharedPreferences.
/// It solves the App Amnesia problem by saving:
/// 1. User Name (Week 14)
/// 2. Team Items List (Week 15)
///
/// To install the storage package, run this command in your project terminal:
/// flutter pub add shared_preferences
class StorageHelper {
  static const String _userNameKey = 'user_name';
  static const String _itemsKey = 'team_items_list';

  /// Save user name to phone disk
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
  }

  /// Read user name from phone disk
  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey) ?? 'Guest';
  }

  /// Save list of text items to phone disk
  static Future<void> saveItems(List<String> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_itemsKey, items);
  }

  /// Read list of text items from phone disk
  /// If nothing was saved yet, it returns the provided default starter items
  static Future<List<String>> getItems(List<String> defaultItems) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? saved = prefs.getStringList(_itemsKey);
    if (saved != null && saved.isNotEmpty) {
      return saved;
    }
    return List<String>.from(defaultItems);
  }

  /// Reset or clear stored data
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
