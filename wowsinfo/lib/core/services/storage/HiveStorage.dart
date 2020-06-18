import 'package:wowsinfo/core/services/caching/BaseCache.dart';
import 'package:wowsinfo/core/services/storage/BaseStorage.dart';

/// This uses hive as the storage provider
class HiveStorage extends BaseStorage<String> {
  @override
  String load(String key) {
    
  }

  @override
  void save(String key, BaseCache cache) {
    // TODO: implement save
  }

}
