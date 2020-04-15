import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:wowsinfo/core/data/Constant.dart';
import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/data/LocalData.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/models/GitHub/PRData.dart';
import 'package:wowsinfo/core/models/GitHub/ShipAlias.dart';
import 'package:wowsinfo/core/models/Wiki/WikiAchievement.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCollection.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCollectionItem.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCommanderSkill.dart';
import 'package:wowsinfo/core/models/Wiki/WikiConsumable.dart';
import 'package:wowsinfo/core/models/Wiki/WikiEncyclopedia.dart';
import 'package:wowsinfo/core/models/Wiki/WikiGameMap.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/core/extensions/DateTimeExtension.dart';
import 'package:wowsinfo/core/parsers/API/APIParser.dart';
import 'package:wowsinfo/core/parsers/API/WikiAchievementParser.dart';
import 'package:wowsinfo/core/parsers/API/WikiCollectionItemParser.dart';
import 'package:wowsinfo/core/parsers/API/WikiCollectionParser.dart';
import 'package:wowsinfo/core/parsers/API/WikiCommanderSkillParser.dart';
import 'package:wowsinfo/core/parsers/API/WikiConsumableParser.dart';
import 'package:wowsinfo/core/parsers/API/WikiEncyclopediaParser.dart';
import 'package:wowsinfo/core/parsers/API/WikiGameMapParser.dart';
import 'package:wowsinfo/core/parsers/API/WikiWarshipParser.dart';
import 'package:wowsinfo/core/parsers/GitHub/GitHubParser.dart';
import 'package:wowsinfo/core/parsers/GitHub/PRDataParser.dart';
import 'package:wowsinfo/core/parsers/GitHub/ShipAliasParser.dart';


const BOX_NAME = 'cached_data';

const PERSONAL_RATING = 'personal_rating';
const SHIP_ALIAS = 'ship_alias';

const WIKI_ACHIEVEMENT = 'ship_achievement';
const WIKI_COLLECTION = 'wiki_collection';
const WIKI_COLLECTION_ITEM = 'wiki_collection_item';
const WIKI_COMMANDER_SKILL = 'wiki_commander_skill';
const WIKI_CONSUMABLE = 'wiki_consumable';
const WIKI_ENCYCLOPEDIA = 'wiki_encyclopedia';
const WIKI_GAME_MAP = 'wiki_game_map';
const WIKI_WARSHIP = 'wiki_warship';

/// It handles cached data but mainly wiki
/// - it is usually read only
/// - it only updates when necessary
class CachedData extends LocalData {
  /// Singleton pattern 
  CachedData._init();
  static final CachedData shared = CachedData._init();

  ///
  /// Variables
  ///
  
  final pref = Preference.shared;

  PRData _prData;
  void loadPRData() => _prData = decode(PERSONAL_RATING, (j) => PRData.fromJson(j));
  void savePRData(PRData data) {
    _prData = data;
    box.put(PERSONAL_RATING, jsonEncode(data.toJson()));
  }

  ShipAlias _alias;
  void loadAlias() => _alias = decode(SHIP_ALIAS, (j) => ShipAlias.fromJson(j));
  void saveAlias(ShipAlias data) {
    _alias = data;
    box.put(SHIP_ALIAS, jsonEncode(data.toJson()));
  }

  WikiAchievement _achievement;
  void loadAchievement() => _achievement = decode(WIKI_ACHIEVEMENT, (j) => WikiAchievement.fromJson(j));
  void saveAchievement(WikiAchievement data) {
    _achievement = data;
    box.put(WIKI_ACHIEVEMENT, jsonEncode(data.toJson()));
  }

  WikiWarship _warship;
  Map<String, Warship> get warship => _warship.ships;
  /// Sort by tier, then by type, ignore ships starts with `[`
  List<Warship> get sortedWarshipList {
    return warship.values.where((e) => !e.name.startsWith('[')).toList(growable: false)..sort((b, a) {
      // `a` first then 'd', smaller ones first
      if (a.tier == b.tier) return b.type.compareTo(a.type);
      // 10 first, larger ones first
      return a.tier - b.tier;
    });
  }
  void loadWarship() => _warship = decode(WIKI_WARSHIP, (j) => WikiWarship.fromJson(j));
  void saveWarship(WikiWarship data) {
    _warship = data;
    box.put(WIKI_WARSHIP, jsonEncode(data.toJson()));
  }

  WikiCollection _collection;
  void loadCollection() => _collection = decode(WIKI_COLLECTION, (j) => WikiCollection.fromJson(j));
  void saveCollection(WikiCollection data) {
    _collection = data;
    box.put(WIKI_COLLECTION, jsonEncode(data.toJson()));
  }

  WikiCollectionItem _collectionItem;
  void loadCollectionItem() => _collectionItem = decode(WIKI_COLLECTION_ITEM, (j) => WikiCollectionItem.fromJson(j));
  void saveCollectionItem(WikiCollectionItem data) {
    _collectionItem = data;
    box.put(WIKI_COLLECTION_ITEM, jsonEncode(data.toJson()));
  }

  WikiCommanderSkill _commanderSkill;
  void loadCommanderSkill() => _commanderSkill = decode(WIKI_COMMANDER_SKILL, (j) => WikiCommanderSkill.fromJson(j));
  void saveCommanderSkill(WikiCommanderSkill data) {
    _commanderSkill = data;
    box.put(WIKI_COMMANDER_SKILL, jsonEncode(data.toJson()));
  }

  WikiGameMap _gameMap;
  void loadGameMap() => _gameMap = decode(WIKI_GAME_MAP, (j) => WikiGameMap.fromJson(j));
  void saveGameMap(WikiGameMap data) {
    _gameMap = data;
    box.put(WIKI_GAME_MAP, jsonEncode(data.toJson()));
  }

  WikiConsumable _consumable;
  void loadConsumable() => _consumable = decode(WIKI_CONSUMABLE, (j) => WikiConsumable.fromJson(j));
  void saveConsumable(WikiConsumable data) {
    _consumable = data;
    box.put(WIKI_CONSUMABLE, jsonEncode(data.toJson()));
  }

  WikiEncyclopedia _encyclopedia;
  /// A map with language code and its value
  Map<String, String> get serverLanguage => _encyclopedia.language;
  Map<String, String> get shipNation => _encyclopedia.shipNation;
  Map<String, String> get shipType => _encyclopedia.shipType;
  String get gameVersion => _encyclopedia.gameVersion;
  void loadEncyclopedia() => _encyclopedia = decode(WIKI_ENCYCLOPEDIA, (j) => WikiEncyclopedia.fromJson(j));
  void saveEncyclopedia(WikiEncyclopedia data) {
    _encyclopedia = data;
    box.put(WIKI_ENCYCLOPEDIA, jsonEncode(data.toJson()));
  }

  ///
  /// Functions
  ///

  @override
  Future<bool> init() async {
    this.box = await Hive.openBox(BOX_NAME);
    Utils.debugPrint('$BOX_NAME box has been loaded');

    // Debug and close
    debug(keysOnly: true);
    return true;
  }

  /// Check for update and only update when game updates, app updates or it has been a week
  Future<bool> update({bool force = false}) async {
    // Open the box again if it is closed
    this.box = await Hive.openBox(BOX_NAME);
    // Load everything from storage, it is fine because if there are new data, it will be replaced
    loadAll();

    final server = pref.gameServer;
    final parser = WikiEncyclopediaParser(server);
    final encyclopedia = parser.parse(await parser.download());

    // Either game updates, app updates or the data is too old
    if (force
      || (encyclopedia != null && encyclopedia.gameVersion != this.gameVersion)
      || pref.appVersion != Constant.app_version
      || pref.lastUpdate.dayDifference(DateTime.now()) > 10) {
      // Update data here
      List<APIParser> wows = [
        WikiAchievementParser(server),
        WikiCollectionParser(server),
        WikiCollectionItemParser(server),
        WikiCommanderSkillParser(server),
        WikiConsumableParser(server),
        // Encyclopedia will also be updated
        // WikiEncyclopediaParser(server),
        WikiGameMapParser(server),
        WikiWarshipParser(server),
      ];
      // Extra data from GitHub
      List<GitHubParser> github = [
        ShipAliasParser(),
        PRDataParser(),
      ];

      // Download from WarGaming API
      await Future.wait(wows.map((element) async {
        Cacheable data = element.parse(await element.download());
        data?.save();
      }));

      // Download from GitHub
      await Future.wait(github.map((element) async {
        Cacheable data = element.parse(await element.download());
        data?.save();
      }));

      // Only save new version here
      encyclopedia.save();
      return true;
    }


    // Close the box after everything has been loadded
    return false;
  }

  /// Load all cached data into memory
  /// TODO: this can be optimised like when load when necessary
  void loadAll() {
    loadAchievement();
    loadAlias();
    loadCollection();
    loadCollectionItem();
    loadConsumable();
    loadEncyclopedia();
    loadGameMap();
    loadPRData();
    loadWarship();
    loadCommanderSkill();
  }

  /// Shorten decode process and extra check
  dynamic decode(String key, Function f) {
    final saved = box.get(key);
    if (saved == null) return null;
    return f(jsonDecode(saved));
  }

  @override
  Future close() async {
    // Clean up this box because it has quite a lot of data
    await box.compact();
    Utils.debugPrint('$BOX_NAME box has been cleaned');
    return super.close();
  }
}
