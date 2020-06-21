import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/services/data/BaseConfiguration.dart';
import 'package:wowsinfo/core/services/data/BaseDataProvider.dart';
import 'package:wowsinfo/core/services/storage/BaseStorage.dart';
import 'package:wowsinfo/core/utils/Utils.dart';

class CachedData<String, V extends Cacheable>
    extends BaseConfiguration<String, V> {
  BaseDataProvider<V> dataProvider;
  V Function(dynamic) _creator;

  CachedData(this._creator, BaseStorage<String, V> storage, this.dataProvider, String key) {
    this.storage = storage;
    this.key = key;
  }

  @override
  Future<bool> load() async {
    try {
      // Load data from storage
      Cacheable data = await storage.load(key, creator: this._creator);
      // If data is null or corrupted, load from data provider
      if (data == null || !data.isValid()) {
        data = await dataProvider.requestData(creator: this._creator);
      }

      this.value = data;

      return true;
    } catch (e) {
      Utils.debugPrint(e);
      return false;
    }
  }

  @override
  Future<void> save() => storage.save(key, value.output());
}
