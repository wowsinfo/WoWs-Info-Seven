import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:wowsinfo/core/data/LocalData.dart';
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
  
  PRData _prData;
  ShipAlias _alias;

  WikiAchievement _achievement;
  WikiWarship _warship;
  WikiCollection _collection;
  WikiCollectionItem _collectionItem;
  WikiCommanderSkill _commanderSkill;
  WikiGameMap _gameMap;
  WikiConsumable _consumable;
  WikiEncyclopedia _encyclopedia;

  ///
  /// Functions
  ///

  @override
  Future<bool> init() async {
    this.box = await Hive.openBox(BOX_NAME);
    Utils.debugPrint('$BOX_NAME box has been loaded');

    // Debug and close
    debug();
    return true;
  }

  /// Check for update and only update when game updates, app updates or it has been a week
  void update() {

  }

  /// Load all cached data into memory
  /// TODO: this can be optimised like when load when necessary
  void loadAll() {
    _prData = PRData.fromJson(decode(PERSONAL_RATING));
    _alias = ShipAlias.fromJson(decode(SHIP_ALIAS));

    _achievement = WikiAchievement.fromJson(decode(WIKI_ACHIEVEMENT));
    _collection = WikiCollection.fromJson(decode(WIKI_COLLECTION));
    _collectionItem = WikiCollectionItem.fromJson(decode(WIKI_COLLECTION_ITEM));
    _commanderSkill = WikiCommanderSkill.fromJson(decode(WIKI_COMMANDER_SKILL));
    _consumable = WikiConsumable.fromJson(decode(WIKI_CONSUMABLE));
    _encyclopedia = WikiEncyclopedia.fromJson(decode(WIKI_ENCYCLOPEDIA));
    _gameMap = WikiGameMap.fromJson(decode(WIKI_GAME_MAP));
    _warship = WikiWarship.fromJson(decode(WIKI_WARSHIP));
    close();
  }

  /// Shorten decode process
  Map<String, dynamic> decode(String key) => jsonDecode(box.get(key));
}
