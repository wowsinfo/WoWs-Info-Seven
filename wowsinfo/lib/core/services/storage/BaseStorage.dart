import 'package:wowsinfo/core/services/caching/BaseCache.dart';

/// The storage service should take care of 
/// - Loading data from any data storage 
/// - Saving/updating that data
/// 
/// This assumes that data is 
abstract class BaseStorage<T> {
  /// Load data from a key to read
  dynamic load(T key);
  /// Save data to that key
  void save(T key, BaseCache cache);
}
