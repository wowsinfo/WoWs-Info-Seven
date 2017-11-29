// This is my WarGaming Developer ID
// Please use yours or demo if you are running this app
export const ApplicationID = '***ApplicationID***';

export const API = {
  GameVersion: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' + ApplicationID + '&language=en&fields=game_version'
}

export const DataAPI = {
  
}

// All supported game servers
export const serverIndex = {
  Russia: 0,
  Europe: 1,
  NorthAmerica: 2,
  Asia: 3,
  // Chinese server is difference from all other servers
  China: 4,
}

// Data name from old IOS project
export const IOSDataName = {
  firstLaunch: 'first_launch',
  server: 'server',
  userName: 'username',
  hasPurchased: 'hasPurchased',
  friend: 'friend_list',
}

export const localDataName = {
  isPro: '@WoWs_Info:isPro',
  hasAds: '@WoWs_Info:hasAds',
  playerList: '@WoWs_Info:playerList',
  userInfo: '@WoWs_Info:userInfo',
  userData: '@WoWs_Info:userData',
  gameVersion: '@WoWs_Info:gameVersion',
  currDate: '@WoWs_Info:currDate',
  tokenDate: '@WoWs_Info:tokenDate',
  currServer: '@WoWs_Info:currServer',
  themeColour: '@WoWs_Info:themeColour',
  firstLaunch: '@WoWs_Info:firstLaunch',
  appLanguage: '@WoWs_Info:appLanguage',
  newsLanguage: '@WoWs_Info:newsLanguage',
  apiLanguage: 'WoWs_Info:apiLanguage',
}