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
     * Initialise the entire app
     * - Check for app update once a week
     * - Check for game update
     * - Download and save data locally
     * - Load data locally
     * @returns error message or 'nothing'
     */
    async init(): Promise<string> {
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
  Github: 'https://github.com/HenryQuan/WoWs-Info',
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
  // ads: '@WoWs_Info:hasAds',
  friendList: '@WoWs_Info:playerList',
  userInfo: '@WoWs_Info:userInfo',
  userData: '@WoWs_Info:userData',
  userServer: '@WoWs_Info:currServer',
  appVersion: '@WoWs_Info:currVersion',
  gameVersion: '@WoWs_Info:gameVersion',
  date: '@WoWs_Info:currDate',
  // To do recent data for saved user only
  lastUpdate: '@WoWs_Info:lastUpdate',
  // data_saver: '@WoWs_Info:dataSaver',
  theme: '@WoWs_Info:themeColour',
  darkMode: '@WoWs_Info:darkMode',
  swapButton: '@WoWs_Info:swapButton',
  noImageMode: '@WoWs_Info:noImageMode',
  firstLaunch: '@WoWs_Info:firstLaunch',
  // Language
  apiLanguage: '@WoWs_Info:apiLanguage',
  userLanguage: '@WoWs_Info:userLanguage',
  // Save last visited location as a string
  lastLocation: '@WoWs_Info:lastLocation',
  // RS
  rsIP: '@WoWs_Info:rsIP',
  // Suport me
  showBanner: '@WoWs_Info:banner_ads',
  showFullscreen: '@WoWs_Info:fullscreen_ads',
}

/**
 * Cached data from Wargming server
 */
export const Cached = {
  language: '@Data:language',
  encyclopedia: '@Data:encyclopedia',
  // shipType: '@Data:ship_type',
  achievement: '@Data:achievement',
  commanderSkill: '@Data:commander_skill',
  collection: '@Data:collection',
  // collectionItem: '@Data:collection_item',
  warship: '@Data:warship',
  map: '@Data:gameMap',
  consumable: '@Data:consumable',
  pr: '@Data:personal_rating',
}