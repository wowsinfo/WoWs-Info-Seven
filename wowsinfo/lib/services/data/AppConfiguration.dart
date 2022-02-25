import 'package:wowsinfo/models/Cacheable.dart';
import 'package:wowsinfo/services/data/BaseConfiguration.dart';
import 'package:wowsinfo/services/storage/BaseStorage.dart';
import 'package:wowsinfo/utils/Utils.dart';

class AppConfiguration<String, V extends Cacheable>
    extends BaseConfiguration<String, V> {
  V _defaultValue;

  AppConfiguration(BaseStorage<String, V> storage, String key,
      {V defaultValue}) {
    this.storage = storage;
    this.key = key;
    this._defaultValue = defaultValue;
  }

  @override
  Future<bool> load() async {
    try {
      this.value = await storage.load(key) ?? _defaultValue;
      return true;
    } catch (e) {
      Utils.debugPrint(e);
      return false;
    }
  }

  @override
  Future<void> save() => storage.save(key, value.output());
}
