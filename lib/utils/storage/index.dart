import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  static late SharedPreferences _preferences;

  //  初始化
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //  设置字符串 - string
  static Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  //  获取字符串 - string
  static String? getString(String key) {
    return _preferences.getString(key);
  }

  //  设置整数 - int
  static Future<void> setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  //  获取整数  - int
  static int? getInt(String key) {
    return _preferences.getInt(key);
  }

  //  设置双精度浮点数  - double
  static Future<void> setDouble(String key, double value) async {
    await _preferences.setDouble(key, value);
  }

  // 获取双精度浮点数  - double
  static double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  // 设置布尔值  - bool
  static Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  // 获取布尔值  - bool
  static bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  // 保存字符串列表
  static Future<bool> saveStringList(String key, List<String> value) {
    return _preferences.setStringList(key, value);
  }

  // 获取字符串列表 - 如果不存在则返回空列表
  static List<String> getStringList(String key) {
    return _preferences.getStringList(key) ?? [];
  }

  // 设置对象 - Map<String, dynamic>
  static Future<void> setObject(String key, Map<String, dynamic> value) async {
    String jsonString = jsonEncode(value);
    await _preferences.setString(key, jsonString);
  }

  // 获取对象 - Map<String, dynamic>
  static Map<String, dynamic>? getObject(String key) {
    String? jsonString = _preferences.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }

  // 检查是否存在某个 key
  static bool containsKey(String key) {
    return _preferences.containsKey(key);
  }

  // 获取所有 key
  static Set<String> getKeys() {
    return _preferences.getKeys();
  }

  // 删除指定键值对
  static Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  // clear 所有数据
  static Future<void> clear() async {
    await _preferences.clear();
  }

  // 泛型保存和读取
  static Future<bool> save<T>(String key, T value) {
    try {
      if (T == String || value is String) {
        return _preferences.setString(key, value as String);
      }
      if (T == int || value is int) {
        return _preferences.setInt(key, value as int);
      }
      if (T == double || value is double) {
        return _preferences.setDouble(key, value as double);
      }
      if (T == bool || value is bool) {
        return _preferences.setBool(key, value as bool);
      }
      if (value is List<String>) {
        return _preferences.setStringList(key, value);
      }
      // 对于复杂对象，使用 JSON 编码
      return _preferences.setString(key, jsonEncode(value));
    } catch (e) {
      return Future.error(UnsupportedError('Unsupported value type: $e'));
    }
  }

  static T? read<T>(String key) {
    try {
      if (!_preferences.containsKey(key)) return null;

      if (T == String) {
        return _preferences.getString(key) as T?;
      }
      if (T == int) {
        return _preferences.getInt(key) as T?;
      }
      if (T == double) {
        return _preferences.getDouble(key) as T?;
      }
      if (T == bool) {
        return _preferences.getBool(key) as T?;
      }
      if (T == List || T == List<String>) {
        return _preferences.getStringList(key) as T?;
      }
      // 复杂对象：从 JSON 反序列化
      final String? jsonString = _preferences.getString(key);
      if (jsonString == null) return null;
      final decoded = jsonDecode(jsonString);
      return decoded as T;
    } catch (e) {
      return null;
    }
  }
}
