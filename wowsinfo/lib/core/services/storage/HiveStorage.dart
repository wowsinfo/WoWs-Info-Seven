import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/services/storage/BaseStorage.dart';

/// This uses hive as the storage provider
class HiveStorage<String, V extends Cacheable> extends BaseStorage<String, V> {
  // The box is important for read and write
  Box _box;
  HiveStorage(this._box);

  @override
  Future<V> load(String key, {V Function(dynamic) creator}) async {
    if (creator == null) throw Exception('Creator for HiveStorage must not be null');
    return creator(jsonDecode(_box.get(key)));
  }

  @override
  void save(String key, V value) {
    _box.put(key, value);
  }
}
