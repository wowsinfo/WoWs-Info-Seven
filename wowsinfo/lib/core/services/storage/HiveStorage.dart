import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/services/storage/BaseStorage.dart';

/// This uses hive as the storage provider
class HiveStorage extends BaseStorage<String, Cacheable> {
  @override
  Cacheable load(String key) {
    
  }

  @override
  void save(String key, Cacheable cache) {

  }

}
