/**
 * This is necessary for all data that can be saved locally
 * @pre Call `load()` before doing anything else
 * @post All methods will work normally
 */
export interface Cacheable {
  /**
   * Save data as a json string to AsyncStorage
   */
  save(): void;
  /**
   * Load data from AsyncStorage
   */
  load(): Promise<boolean>;
  /**
   * Parses json string and return the appropriate object
   */
  fromJSON(jsonString: string | null): void;
}

export enum DATA_KEY {
  /// User related
  user_account = '@WoWs_Info:userInfo',
  user_ship_data = '@WoWs_Info:userData',
  user_server = '@WoWs_Info:currServer',
  user_theme = '@WoWs_Info:themeColour',
  user_contact = '@WoWs_Info:playerList',
  user_app_version = '@WoWs_Info:currVersion',
  user_last_update = '@WoWs_Info:lastUpdate',
  user_first_launch = '@WoWs_Info:firstLaunch',
  user_server_language = '@WoWs_Info:apiLanguage',
  user_app_language = '@WoWs_Info:userLanguage',
  user_pro_version = '@WoWs_Info:proVersion',
  // for home bottom navigation
  // user_tab_index = '@WoWs_Info:tabIndex',

  /// Game version from server
  game_version = '@WoWs_Info:gameVersion',

  /// WoWs RS saved ip address
  wows_rs_ip = '@WoWs_Info:rsIP',
  
  // To do recent data for saved user only
  // data_saver = '@WoWs_Info:dataSaver',
  // dark_mode = '@WoWs_Info:darkMode',
  // swap_button = '@WoWs_Info:swapButton',
  // noImageMode = '@WoWs_Info:noImageMode',
  
  /// Wiki related
  wiki_available_language = '@Data:language',
  wiki_info = '@Data:encyclopedia',
  // shipType = '@Data:ship_type',
  wiki_achievement = '@Data:achievement',
  wiki_commander_skill = '@Data:commander_skill',
  wiki_collection = '@Data:collection',
  // collectionItem = '@Data:collection_item',
  wiki_warship = '@Data:warship',
  wiki_game_map = '@Data:gameMap',
  wiki_consumable = '@Data:consumable',

  /// Personal rating from wows-number.com
  personal_rating = '@Data:personal_rating',
};
