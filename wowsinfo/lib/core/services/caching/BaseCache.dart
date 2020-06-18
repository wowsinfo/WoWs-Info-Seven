
import 'package:wowsinfo/core/services/api/BaseApiService.dart';
import 'package:wowsinfo/core/services/storage/BaseStorage.dart';

/// A cache should be able to 
/// - Retrieve data from storage services
/// - Call api services to request data from api
/// - Save data from api through storage service
/// - Update automatically and can force update
/// It should contain a model that can be saved locally, an api service and a storage service 
abstract class BaseCache {
  final BaseApiService api;
  final BaseStorage storage;

  BaseCache(this.api, this.storage);
}
