import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/data/LocalData.dart';
import 'package:wowsinfo/core/models/User/ContactList.dart';
import 'package:wowsinfo/core/models/User/Player.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/core/extensions/DateTimeExtension.dart';

/// `KEYS` are stored here so that I won't have any typo or changed the string accidentally
const BOX_NAME = 'preference';
const FIRST_LAUNCH = 'first_launch';
const MAIN_ACCOUNT = 'main_account';
// This saves all user ship data once for a while
const CACHED_USER_SHIP_DATA = 'cached_user_ship_data';
const GAME_SERVER = 'game_server';
const CONTACT_LIST = 'contact_list';
// This is the date the app last updated (so update every week)
const LAST_UPDATE = 'last_update';
const SERVER_LANGUAGE = 'server_language';
const APP_LANGUAGE = 'app_language';
const PRO_VERSION = 'pro_version';
// This remembers the last tab user uses
const BOTTOM_TAB_INDEX = 'bottom_tab_index';
// This is the last entered ip address for realtime stats
const REALTIME_IP = 'real_time_ip';
// These two saves
const GAME_VERSION = 'game_version';
const APP_VERSION = 'app_version';

/// This is the `Preference` class
/// - it manages all const a preferences including those that are used in app provider
/// - mainly changable ones
class Preference extends LocalData {
  /// Singleton pattern 
  Preference._init();
  static final Preference shared = Preference._init();

  ///
  /// Variables, default value will be provided as well
  ///

  bool get firstLaunch => this.box.get(FIRST_LAUNCH) ?? true;
  setFirstLaunch(bool value) => this.box.put(FIRST_LAUNCH, value);

  /// it is just a player and returns null if no account has been set
  Player get mainAccount {
    final jsonString = this.box.get(MAIN_ACCOUNT);
    if (jsonString != null) return Player.fromJson(jsonDecode(jsonString));
    return null;
  }
  setMainAccount(Player player) => this.box.put(MAIN_ACCOUNT, jsonEncode(player));

  int get gameServer => this.box.get(GAME_SERVER);
  setGameServer(Server value) => this.box.put(GAME_SERVER, value.index);

  /// returns saved player contact or an empty one
  ContactList get contactList {
    final jsonString = this.box.get(CONTACT_LIST);
    if (jsonString != null) return ContactList.fromJson(jsonDecode(jsonString));
    return ContactList();
  }
  setContactList(ContactList contact) => this.box.put(CONTACT_LIST, jsonEncode(contact));

  /// the default date is the date I first published this app
  DateTime get lastUpdate => DateTime.parse(this.box.get(LAST_UPDATE) ?? '2017-02-06');
  setLastUpdate(DateTime value) => this.box.put(LAST_UPDATE, value.toHumanString());

  /// Provide a default language
  String get serverLanguage => this.box.get(SERVER_LANGUAGE) ?? 'en';
  setServerLanguage(String value) => this.box.put(SERVER_LANGUAGE, value);

  String get appLanguage => this.box.get(APP_LANGUAGE);
  setAppLanguage(String value) => this.box.put(APP_LANGUAGE, value);

  bool get proVersion => this.box.get(PRO_VERSION) ?? false;
  setProVersion(bool value) => this.box.put(PRO_VERSION, value);

  int get bottomTabIndex => this.box.get(BOTTOM_TAB_INDEX) ?? 0;
  setBottomTabIndex(int value) => this.box.put(BOTTOM_TAB_INDEX, value);

  String get realtimeIP => this.box.get(REALTIME_IP);
  setRealtimeIP(String value) => this.box.put(REALTIME_IP, value);

  String get gameVersion => this.box.get(GAME_VERSION) ?? '0.9.3.0';
  setGameVersion(String value) => this.box.put(GAME_VERSION, value);

  String get appVersion => this.box.get(APP_VERSION) ?? '1.0.8';
  setAppVersion(String value) => this.box.put(APP_VERSION, value);

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

