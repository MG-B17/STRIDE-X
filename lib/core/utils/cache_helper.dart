import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }


  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }


  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    switch (value) {
      case String():
        return await sharedPreferences.setString(key, value);
      case int():
        return await sharedPreferences.setInt(key, value);
      case bool():
        return await sharedPreferences.setBool(key, value);
      case double():
        return await sharedPreferences.setDouble(key, value);
      case List<String>():
        return await sharedPreferences.setStringList(key, value);
      default:
        return false;
    }
  }


  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }

  /// Clear all data from cache.
  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  /// Check if a key exists in cache.
  static bool containsKey({required String key}) {
    return sharedPreferences.containsKey(key);
  }
}
