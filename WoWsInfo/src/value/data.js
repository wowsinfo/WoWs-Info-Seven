import { SafeStorage, SafeValue } from "../core";
import { Actions } from 'react-native-router-flux';
import { getAvailablePurchases, getPurchaseHistory } from 'react-native-iap';
import { Alert, Platform } from 'react-native';

/**
 * App information
 */
export const APP = {
  Version: '1.0.7.1',
  IOSVersion: '1.6.7',
  GameVersion: '0.9.1.0',
  Github: 'https://github.com/HenryQuan/WoWs-Info',
  AppStore: 'https://itunes.apple.com/app/id1202750166',
  GooglePlay: 'https://play.google.com/store/apps/details?id=com.yihengquan.wowsinfo',
  Developer: `mailto:development.henryquan@gmail.com?subject=[WoWs Info 1.0.7.1] `,
  Patreon: 'https://www.patreon.com/henryquan',
  PayPal: 'https://www.paypal.me/YihengQuan',
  WeChat: 'https://github.com/HenryQuan/WoWs-Info-Origin/blob/master/Support/WeChat.png',
  PersonalRating: 'https://wows-numbers.com/personal/rating',
  LatestRelease: 'https://github.com/HenryQuan/WoWs-Info-Origin/releases/latest'
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
  noImageMode: '@WoWs_Info:noImageMode',
  firstLaunch: '@WoWs_Info:firstLaunch',
  // Language
  apiLanguage: '@WoWs_Info:apiLanguage',
  userLanguage: '@WoWs_Info:userLanguage',
  // Save last visited location as a string
  lastLocation: '@WoWs_Info:lastLocation',
  // If user has purchased pro version
  proVersion: '@WoWs_Info:proVersion',
  // RS
  rsIP: '@WoWs_Info:rsIP',
  // Suport me
  showBanner: '@WoWs_Info:banner_ads',
  showFullscreen: '@WoWs_Info:fullscreen_ads',
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
 * First launch
 */
export const getFirstLaunch = () => {
  return DATA[LOCAL.firstLaunch];
}

export const setFirstLaunch = (mode) => {
  DATA[LOCAL.firstLaunch] = mode;
  SafeStorage.set(LOCAL.firstLaunch, mode);
}

/**
 * Server 
 */
export const SERVER = ['ru', 'eu', 'com', 'asia'];

export const getCurrDomain = () => {
  return SERVER[getCurrServer()];
};

export const getDomain = (index) => {
  return SERVER[index];
};

export const getCurrPrefix = () => {
  let prefix = getCurrDomain();
  if (prefix === 'com') prefix = 'na';
  return prefix;
};

export const getPrefix = (index) => {
  let prefix = getDomain(index);
  if (prefix === 'com') prefix = 'na';
  return prefix;
}

export const getCurrServer = () => {
  return SafeValue(DATA[LOCAL.userServer], 3);
};

export const setCurrServer = (index) => {
  let str = LOCAL.userServer;
  DATA[str] = index;
  SafeStorage.set(str, index);
};

/**
 * User Language
 */
export const getUserLang = () => {
  return SafeValue(DATA[LOCAL.userLanguage], 'en');
}

export const setUserLang = (lang) => {
  let str = LOCAL.userLanguage;
  DATA[str] = lang;
  SafeStorage.set(str, lang);
}

/**
 * API Language
 */
export const getAPILanguage = () => {
  return SafeValue(DATA[LOCAL.apiLanguage], 'en');
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

/**
 * No Image Mode
 */
export const getImageMode = () => {
  return DATA[LOCAL.noImageMode];
}

export const setImageMode = (image) => {
  NOIMAGEMODE = image;
  let str = LOCAL.noImageMode;
  DATA[str] = image;
  SafeStorage.set(str, image);
}

/**
 * Last Location
 */
export const setLastLocation = (str) => {
  let loc = LOCAL.lastLocation;
  DATA[loc] = str;
  SafeStorage.set(loc, str);
}

export const isProVersion = () => {
  return DATA[LOCAL.proVersion] === true;
}

export const setProVersion = (pro) => {
  let str = LOCAL.proVersion;
  DATA[str] = pro;
  SafeStorage.set(str, pro);
}

/**
 * Check if the user is using pro version, 
 * push to ProVersion if necessary
 * @returns whether pro version
 */
export const onlyProVersion = () => {
  if (isProVersion()) return true;
  // Only push if user is not using pro version
  Actions.ProVersion();
  return false;
}

export const validateProVersion = async () => {
  try {
    const history = await getAvailablePurchases();
    console.log(history);
    if (history.length > 0) {
      // Sort by date first
      let latest = history.sort((a, b) => a.transactionDate - b.transactionDate)[history.length - 1];
      console.log(latest);
      const receipt = latest.transactionReceipt;
      const date = latest.transactionDate;
      if (receipt && date) {
        console.log('Valid purchase');
        if (Platform.OS === 'android') {
          // Only need to check if renew is still on
          if (latest.autoRenewingAndroid === true) {
            // Set it to true
            setProVersion(true);
            return;
          }
        } else if (Platform.OS === 'ios') {
          // Check if it expires
          const purchaseDate = new Date(date);
          purchaseDate.setFullYear(purchaseDate.getFullYear() + 1);
          const todayDate = new Date();
          console.log(`today: ${todayDate}\nexpire: ${purchaseDate}`);
          if (todayDate < purchaseDate) {
            // Still valid
            setProVersion(true);
            return;
          }
        }
      }
    }

    // Should not be pro version
    setProVersion(false);
    throw new Error('No payment history has been found');
  } catch (err) {
    Alert.alert('Failed to restore', err.message);
  }
}

export const getCurrDate = () => {
  return DATA[LOCAL.date];  
}

/**
 * get the date now and update saved date
 */
export const updateCurrData = () => {
  const today = new Date().toDateString();
  let str = LOCAL.date;
  DATA[str] = today;
  SafeStorage.set(str, today);
}

export const getLastUpdate = () => {
  return DATA[LOCAL.lastUpdate];
}

/**
 * Check if it has been 7 compared to curr date
 */
export const shouldUpdateWithCycle = () => {
  const curr = new Date(getCurrDate());
  const last = new Date(getLastUpdate());

  const diff = Math.abs(curr - last);
  // Convert ut to days
  const diffDays = Math.ceil(diff / (1000 * 60 * 60 * 24));
  console.log(`${diffDays} day(s)`);
  return diffDays >= 7;
}