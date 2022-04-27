/// The interface of the store
///
/// The store can be database, shared preferences or anything.
abstract class StoreInterface {
  Future<bool> load();
  Future<bool> remove(String key);
  Future<bool> clear();
  bool has(String key);
  Object? get(String key);
  Future<bool> set(String key, Object value);
}
