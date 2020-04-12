import 'package:hive/hive.dart';
import 'package:wowsinfo/core/data/LocalData.dart';
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

  @override
  Future<bool> init() async {
    this.box = await Hive.openBox(BOX_NAME);
    Utils.debugPrint('$BOX_NAME box has been loaded');

    debug();
    return true;
  }
}
