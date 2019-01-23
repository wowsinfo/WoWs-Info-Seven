import { SafeStorage } from "../core";

/**
 * App information
 */
export const APP = {
  Version: '1.0.6',
  IOSVersion: '1.6.6',
  GameVersion: '0.7.11.1',
  Github: 'https://github.com/HenryQuan/WoWs-Info',
  AppStore: 'https://itunes.apple.com/app/id1202750166',
  GooglePlay: 'https://play.google.com/store/apps/details?id=com.yihengquan.wowsinfo',
  Developer: 'mailto:development.henryquan@gmail.com?subject=[WoWs Info 1.0.6] ',
}

/**
 * User perference
 */
export const LOCAL = {
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
  firstLaunch: '@WoWs_Info:firstLaunch',
  apiLanguage: '@WoWs_Info:apiLanguage',
}

/**
 * Cached data from Wargming server
 */
export const SAVED = {
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

/**
 * Server 
 */
export const SERVER = ['ru', 'eu', 'com', 'asia'];

export const getCurrDomain = () => {
  return SERVER[getCurrServer()];
};

export const getCurrServer = () => {
  return DATA[LOCAL.userServer];
};

export const setCurrServer = (index) => {
  let str = LOCAL.userServer;
  DATA[str] = index;
  SafeStorage.set(str, index);
};

/**
 * API Language
 */
export const getAPILanguage = () => {
  return DATA[LOCAL.apiLanguage];
};

export const getAPILangName = () => {
  return getAPIList()[getAPILanguage()];
}

export const langStr = () => {
  return `&language=${getAPILanguage()}`;
};

export const getAPIList = () => {
  return DATA[SAVED.language];
};

export const setAPILanguage = (lang) => {
  let str = LOCAL.apiLanguage;
  DATA[str] = lang;
  SafeStorage.set(str, lang);
};

/**
 * Swap Button
 */
export const getSwapButton = () => {
  return DATA[LOCAL.swapButton];
}

export const setSwapButton = (swap) => {
  SWAPBUTTON = swap;
  let str = LOCAL.swapButton;
  DATA[str] = swap;
  SafeStorage.set(str, swap);
}