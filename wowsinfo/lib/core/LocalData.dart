import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wowsinfo/core/others/Preference.dart';

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

  // Whether the app is initialsed
  bool _shouldInit = true;
  Preference _preference;
  bool get firstLaunch => _preference.firstLaunch;
  
  /// 
  /// Functions
  /// 

  /// Load data from `Hive`
  Future<bool> init() async {
    // Only init once
    if (_shouldInit) {
      // Setup hive database
      await Hive.initFlutter();
      final pref = await Hive.openBox<String>(LocalData.perference_key);
      _preference = Preference.fromJson(_getData(pref));

      _shouldInit = false;
    }

    return true;
  }

  Map<String, dynamic> _getData(Box box) {
    final data = box.get('data');
    if (data != null) {
      return jsonDecode(data);
    }

    return null;
  }
}