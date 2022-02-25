import 'package:wowsinfo/services/storage/BaseStorage.dart';

/// A cache should be able to
/// - Retrieve data from storage services
/// - Call api services to request data from api
/// - Save data from api through storage service
/// - Update automatically and can force update
/// It should contain a model that can be saved locally, an api service and a storage service
///
/// K - Key, V - Value
abstract class BaseConfiguration<K, V> {
  BaseStorage<K, V> storage;
  K key;

  V _value;
  V get value => _value;
  set value(V newValue) {
    // This is only used for the first init
    _value ??= newValue;
    // Only update if values are different
    if (newValue != _value) {
      _value = newValue;
      save();
    }
  }

  /// Load value from storage
  Future<bool> load();

  /// Save value to storage
  Future<void> save();
}
