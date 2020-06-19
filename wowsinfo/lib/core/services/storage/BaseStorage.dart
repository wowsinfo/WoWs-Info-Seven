/// The storage service should take care of 
/// - Loading data from any data storage 
/// - Saving/updating that data
/// 
/// K - Key, V - Value 
abstract class BaseStorage<K, V> {
  /// Load data from a key to read, returns null if it is not valid
  V load(K key);
  /// Save data to that key
  void save(K key, V cache);
}
