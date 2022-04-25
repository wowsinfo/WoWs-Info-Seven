/// The interface of the store, it can be database, shared preferences, etc.
abstract class StoreInterface {
  Future<bool> load();
  Future<bool> remove(String key);
  Future<bool> clear();
  Object? get(String key);
  Future<bool> set(String key, Object value);
}
