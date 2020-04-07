import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wowsinfo/core/others/Utils.dart';

const FIRST_LAUNCH = 'first_launch';
/// const a related
const account = '';
const ship_data = '';
const server = '';
const theme_colour = '';
const contact_LIST = 'contact_list';
const last_update = 'last_update';
const server_language = 'server_language';
const app_language = 'app_language';
const pro_version = 'pro_version';
const BOTTOM_TAB_INDEX = 'bottom_tab_index';
// This is the last entered ip address for realtime stats
const REALTIME_IP = 'real_time_ip';
// These two saves
const GAME_VERSION = 'game_version';
const APP_VERSION = 'app_version';

/// This is the `Preference` class
/// - It manages all const a preferences including those that are used in app provider
/// - Mainly changable ones
class Preference {
  static const box_name = 'preference';
  /// Singleton pattern 
  Preference._init();
  static final Preference _instance = Preference._init();
  // Use dart's factory constructor to implement this patternx
  factory Preference() => _instance;

  ///
  /// Variables, default value will be provided as well
  ///
  Box box;

  bool get firstLaunch => this.box.get(FIRST_LAUNCH) ?? true;
  setFirstLaunch(bool value) => this.box.put(FIRST_LAUNCH, value);


  ///
  /// Functions
  /// 

  /// This is necessary to be called before using anything else
  Future<bool> init() async {
    this.box = await Hive.openBox(box_name);
    Utils.debugPrint('$box_name box has been loaded');
    _debug();
    return true;
  }

  /// This is only used for debug by printing out everything in the box
  void _debug() {
    if (kDebugMode) {
      this.box.keys.forEach((key) {
        Utils.debugPrint('$key - ${box.get(key)}');
      });
    }
  }
}

