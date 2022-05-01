import 'package:wowsinfo/repositories/stores/store_interface.dart';

/// A dummy store using map for testing.
class DummyStore implements StoreInterface {
  final Map<String, Object> _store = {};

  @override
  Future<bool> load() async {
    return true;
  }

  @override
  Future<bool> remove(String key) async {
    _store.remove(key);
    return true;
  }

  @override
  Future<bool> clear() async {
    _store.clear();
    return true;
  }

  @override
  bool has(String key) {
    return _store.containsKey(key);
  }

  @override
  Object? get(String key) {
    return _store[key];
  }

  @override
  Future<bool> set(String key, Object value) async {
    _store[key] = value;
    return true;
  }
}
