import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalData {
  /// Singleton pattern 
  LocalData._init();
  static final LocalData _instance = LocalData._init();
  // Use dart's factory constructor to implement this patternx
  factory LocalData() => _instance;

  /// 
  /// Constants
  /// 

  static const perference_key = 'preference';

  /// 
  /// Variables
  /// 

  bool _shouldInit = true;
  
  /// 
  /// Functions
  /// 

  /// Load data from `Hive`
  Future<bool> init() async {
    // Only init once
    if (_shouldInit) {
      // Setup hive database
      await Hive.initFlutter();
      final pref = await Hive.openBox(LocalData.perference_key);
      print(pref.values.first);
      _shouldInit = false;
    }

    return true;
  }
}