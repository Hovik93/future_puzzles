import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {
  static const String _onboardingKey = 'onboarding_seen';
  static const String _userNameKey = 'user_name';
  static const String _recentDataKey = 'recent_data';

  static Future<bool> isOnboardingSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> setOnboardingSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  static Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey) ?? "User";
  }

  static Future<void> setUserName(String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, userName);
  }

  // Управление recentData
  static Future<List<Map<String, dynamic>>> getRecentData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_recentDataKey);
    if (jsonString == null) return [];
    final List<dynamic> decodedList = json.decode(jsonString);
    return decodedList.cast<Map<String, dynamic>>();
  }

  static Future<void> addRecentData(Map<String, dynamic> newData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> currentList = await getRecentData();

    // Добавляем новый элемент
    currentList.insert(0, newData);

    // Удаляем старые элементы, если их больше 10
    if (currentList.length > 10) {
      currentList = currentList.sublist(0, 10);
    }

    // Сохраняем обновленный список
    final String jsonString = json.encode(currentList);
    await prefs.setString(_recentDataKey, jsonString);
  }

  static Future<void> clearRecentData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentDataKey);
  }
}
