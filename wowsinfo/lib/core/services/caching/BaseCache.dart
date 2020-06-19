import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/services/api/BaseApiService.dart';
import 'package:wowsinfo/core/services/storage/BaseStorage.dart';
import 'package:wowsinfo/core/utils/Utils.dart';

/// A cache should be able to 
/// - Retrieve data from storage services
/// - Call api services to request data from api
/// - Save data from api through storage service
/// - Update automatically and can force update
/// It should contain a model that can be saved locally, an api service and a storage service 
/// 
/// K - Key, V - Value
abstract class BaseCache<K, V> {
  final BaseApiService<V> api;
  final BaseStorage<K, V> storage;
  final K key;

  V _model;
  V get value => _model;

  BaseCache(this.api, this.storage, this.key);

  Future<bool> load() async {
    try {
      V value = storage.load(key);

      // Data not found
      if (value == null) {
        // Request to api
        value = await api.requestData();
        // Failed to request data and no local data
        if (value == null) return false;
      }

      _model = value;
      return true;
    } catch (e) {
      Utils.debugPrint(e);
      return false;
    }
  }
}
