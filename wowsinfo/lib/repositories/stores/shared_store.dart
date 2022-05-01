import 'package:shared_preferences/shared_preferences.dart';

import 'store_interface.dart';

/// A shared store across the entire app.
class SharedStore extends StoreInterface {
  late final SharedPreferences _prefs;

  @override
  Future<bool> load() async {
    _prefs = await SharedPreferences.getInstance();
    return true;
  }

  @override
  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  @override
  Future<bool> clear() {
    throw AssertionError('''
      Calling clear() on SharedStore will erase all data.
      This is extremely dangerous.
      Only uncomment this if you know what you are doing.
      ''');

    return _prefs.clear();
  }

  @override
  Object? get(String key) {
    return _prefs.get(key);
  }

  @override
  Future<bool> set(String key, Object value) {
    if (value is String) return _prefs.setString(key, value);
    if (value is bool) return _prefs.setBool(key, value);
    if (value is int) return _prefs.setInt(key, value);
    if (value is double) return _prefs.setDouble(key, value);
    if (value is List<String>) return _prefs.setStringList(key, value);
    return Future.value(false);
  }

  @override
  bool has(String key) {
    return _prefs.containsKey(key);
  }
}
