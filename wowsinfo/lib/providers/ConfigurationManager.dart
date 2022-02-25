import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wowsinfo/constants/AppConstant.dart';
import 'package:wowsinfo/providers/LocalData.dart';
import 'package:wowsinfo/models/game_server.dart';
import 'package:wowsinfo/models/User/ContactList.dart';
import 'package:wowsinfo/models/User/Player.dart';
import 'package:wowsinfo/extensions/DateTimeExtension.dart';
import 'package:wowsinfo/utils/Utils.dart';

/// This is the `Preference` class
/// - it manages all const a preferences including those that are used in app provider
/// - mainly changable ones
class ConfigurationManager with ChangeNotifier {
  /// `KEYS` are stored here so that I won't have any typo or changed the string accidentally
  static const BOX_NAME = 'preference';
  static const FIRST_LAUNCH = 'first_launch';
  static const MAIN_ACCOUNT = 'main_account';
  // This saves all user ship data once for a while
  static const CACHED_USER_SHIP_DATA = 'cached_user_ship_data';
  static const GAME_SERVER = 'game_server';
  static const CONTACT_LIST = 'contact_list';
  // This is the date the app last updated (so update every week)
  static const LAST_UPDATE = 'last_update';
  static const SERVER_LANGUAGE = 'server_language';
  static const APP_LANGUAGE = 'app_language';
  static const PRO_VERSION = 'pro_version';
  // This remembers the last tab user uses
  static const BOTTOM_TAB_INDEX = 'bottom_tab_index';
  // This is the last entered ip address for realtime stats
  static const REALTIME_IP = 'real_time_ip';
  // These two saves
  static const GAME_VERSION = 'game_version';
  static const APP_VERSION = 'app_version';

  ///
  /// Variables, default value will be provided as well
  ///

  bool get firstLaunch => this.box.get(FIRST_LAUNCH) ?? true;
  set firstLaunch(bool value) => this.box.put(FIRST_LAUNCH, value);

  /// it is just a player and returns null if no account has been set
  Player get mainAccount {
    final jsonString = this.box.get(MAIN_ACCOUNT);
    if (jsonString != null) return Player.fromJson(jsonDecode(jsonString));
    return null;
  }

  set mainAccount(Player player) =>
      this.box.put(MAIN_ACCOUNT, jsonEncode(player));

  /// it returns a game server object and it is by default 3
  GameServer get gameServer =>
      GameServer.fromIndex(this.box.get(GAME_SERVER) ?? 3);
  set gameServer(GameServer value) => this.box.put(GAME_SERVER, value.index);

  /// returns saved player contact or an empty one
  ContactList get contactList {
    final jsonString = this.box.get(CONTACT_LIST);
    if (jsonString != null)
      return ContactList.fromJson(jsonDecode(jsonString), this);
    return ContactList(this);
  }

  set contactList(ContactList contact) =>
      this.box.put(CONTACT_LIST, jsonEncode(contact));

  /// the default date is the date I first published this app
  DateTime get lastUpdate =>
      DateTime.parse(this.box.get(LAST_UPDATE) ?? '2017-02-06');
  set lastUpdate(DateTime value) =>
      this.box.put(LAST_UPDATE, value.toHumanString());

  /// Provide a default language
  String get serverLanguage => this.box.get(SERVER_LANGUAGE) ?? 'en';
  set serverLanguage(String value) => this.box.put(SERVER_LANGUAGE, value);

  String get appLanguage => this.box.get(APP_LANGUAGE);
  set appLanguage(String value) => this.box.put(APP_LANGUAGE, value);

  bool get proVersion => this.box.get(PRO_VERSION) ?? false;
  set proVersion(bool value) => this.box.put(PRO_VERSION, value);

  int get bottomTabIndex => this.box.get(BOTTOM_TAB_INDEX) ?? 0;
  set bottomTabIndex(int value) => _update(BOTTOM_TAB_INDEX, value);

  String get realtimeIP => this.box.get(REALTIME_IP);
  set realtimeIP(String value) => this.box.put(REALTIME_IP, value);

  String get gameVersion =>
      this.box.get(GAME_VERSION) ?? AppConstant.APP_VERSION;
  set gameVersion(String value) => this.box.put(GAME_VERSION, value);

  String get appVersion => this.box.get(APP_VERSION) ?? '1.0.8';
  set appVersion(String value) => this.box.put(APP_VERSION, value);

  /// This updates key-value and also notify listeners
  _update(dynamic key, dynamic value) {
    this.box.put(key, value);
    notifyListeners();
  }

  ///
  /// Functions
  ///

  /// This is necessary to be called before using anything else
  @override
  Future<bool> init() async {
    this.box = await Hive.openBox(BOX_NAME);
    Utils.debugPrint('$BOX_NAME box has been loaded');
    debug();

    // Test new entries here
    return true;
  }
}
