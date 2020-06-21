/// The storage service should take care of
/// - Loading data from any data storage
/// - Saving/updating that data
///
/// K - Key, V - Value
abstract class BaseStorage<K, V> {
  /// Load data from a key to read, returns null if it is not valid
  Future<V> load(K key, {V Function(dynamic) creator});

  /// Save data to that key
  void save(K key, V value);
}
