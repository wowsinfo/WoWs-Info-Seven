import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

/// The parent of all local data manager that wraps `Hive`
abstract class LocalData {
  Box box;
  Future<void> init();
  Future<void> close() => this.box.close();
  void debug({bool keysOnly = false}) {
    if (kDebugMode) this.box.keys.forEach((key) => print(keysOnly ? '$key' : '$key - ${box.get(key)}'));
  }
}
