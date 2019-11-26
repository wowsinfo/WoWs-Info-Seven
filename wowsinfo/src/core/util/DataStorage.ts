/**
 * It has all data related functions
 */
export default class DataStorage {
  /// Singleton pattern
  private static _instance: DataStorage;
  private constructor() {}
  public static get Instance() {
    // This is only called once
    if (this._instance == null) this._instance = new DataStorage();
    return this._instance;
  }

  /// Some constants
  public static readonly OK = 'OK';

  /**
   * Initialise some basic but crutial preferences
   * - Load app theme
   * - Load app language
   * - Check if first launch
   * @returns if true, everything works and it's not first launch
   */
  async initSome(): Promise<boolean> {
    return true;
  }

  /**
   * Initialise the entire app
   * - Check for app update once a week
   * - Check for game update
   * - Update data every 2 weeks even if there are no updates
   * - Download and save data locally
   * - Load data locally
   * @returns error message or 'nothing'
   */
  async initAll(): Promise<string> {
    return DataStorage.OK;
  }
}

/**
 * App information
 */
export const AppInfo = {
  Version: '1.0.6.7',
  IOSVersion: '1.6.5',
  GameVersion: '0.8.5',
  GitHub: 'https://github.com/HenryQuan/WoWs-Info',
  AppStore: 'https://itunes.apple.com/app/id1202750166',
  GooglePlay: 'https://play.google.com/store/apps/details?id=com.yihengquan.wowsinfo',
  Developer: `mailto:development.henryquan@gmail.com?subject=[WoWs Info 1.1.0] `,
  Patreon: 'https://www.patreon.com/henryquan',
  PayPal: 'https://www.paypal.me/YihengQuan',
  WeChat: 'https://github.com/HenryQuan/WoWs-Info-Origin/blob/master/Support/WeChat.png',
  PersonalRating: 'https://wows-numbers.com/personal/rating',
  LatestRelease: 'https://github.com/HenryQuan/WoWs-Info-Origin/releases/latest'
}

/**
 * User perference
 */
export const UserPerference = {
  contact_list: '@WoWs_Info:playerList',
  user_account: '@WoWs_Info:userInfo',
  user_ship_data: '@WoWs_Info:userData',
  user_server: '@WoWs_Info:currServer',
  app_version: '@WoWs_Info:currVersion',
  game_version: '@WoWs_Info:gameVersion',
  // To do recent data for saved user only
  last_update: '@WoWs_Info:lastUpdate',
  // data_saver: '@WoWs_Info:dataSaver',
  theme_colour: '@WoWs_Info:themeColour',
  dark_mode: '@WoWs_Info:darkMode',
  swap_button: '@WoWs_Info:swapButton',
  // noImageMode: '@WoWs_Info:noImageMode',
  first_aunch: '@WoWs_Info:firstLaunch',
  // Language
  api_language: '@WoWs_Info:apiLanguage',
  user_perferred_language: '@WoWs_Info:userLanguage',
  // Save last visited location as a string
  last_location: '@WoWs_Info:lastLocation',
  // RS
  wowsrs_IP: '@WoWs_Info:rsIP',
  // No more ads
}

/**
 * Cached data from Wargming server
 */
export const Cached = {
  language: '@Data:language',
  encyclopedia_info: '@Data:encyclopedia',
  // shipType: '@Data:ship_type',
  achievement: '@Data:achievement',
  commander_skill: '@Data:commander_skill',
  collection: '@Data:collection',
  // collectionItem: '@Data:collection_item',
  warship: '@Data:warship',
  game_map: '@Data:gameMap',
  consumable: '@Data:consumable',
  personal_rating: '@Data:personal_rating',
}