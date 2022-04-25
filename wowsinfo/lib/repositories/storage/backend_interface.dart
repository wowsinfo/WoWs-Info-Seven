/// The interface for the database backend.
abstract class BackendInterface {
  Future<bool> load();
  Future<bool> remove(String key);
  Future<bool> clear();
  Object? get(String key);
  Future<bool> set(String key, Object value);
}
