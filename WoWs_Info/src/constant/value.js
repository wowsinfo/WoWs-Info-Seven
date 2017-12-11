// This is my WarGaming Developer ID
// Please use yours or demo if you are running this app
export const ApplicationID = '4e54ba74077a8230e457bf3e7e9ae858';

export const API = {
  GameVersion: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' +  ApplicationID + '&fields=game_version',
  PlayerOnline: 'https://api.worldoftanks.{0}/wgn/servers/info/?application_id=' + ApplicationID + '&fields=players_online&game=wows'
}

export const DataAPI = {
  Achievement: 'https://api.worldofwarships.{0}/wows/encyclopedia/achievements/?application_id=' +  ApplicationID + '&fields=battle.hidden%2Cbattle.name%2Cbattle.image%2Cbattle.image_inactive%2Cbattle.description',
  CommanderSkill: 'https://api.worldofwarships.{0}/wows/encyclopedia/crewskills/?application_id=' +  ApplicationID + '&fields=icon%2Cname%2Ctier%2Cperks.description',
  GameMap: 'https://api.worldofwarships.{0}/wows/encyclopedia/battlearenas/?application_id=' +  ApplicationID + '&fields=name%2Cicon%2Cdescription',
  Language: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' +  ApplicationID + '&fields=languages',
  Encyclopedia: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' +  ApplicationID + '&fields=ship_nations%2Cship_types%2Cship_modules',
  Consumable: 'https://api.worldofwarships.{0}/wows/encyclopedia/consumables/?application_id=' +  ApplicationID + '&fields=type%2Cdescription%2Cname%2Cimage%2Cprice_credit%2Cprice_gold',
  Warship: 'https://api.worldofwarships.{0}/wows/encyclopedia/ships/?application_id=' +  ApplicationID + '&fields=name%2Cnation%2Ctype%2Ctier%2Cship_id%2Cship_id_str%2Cimages.small',
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
  apiLanguage: '@WoWs_Info:apiLanguage',
}

export const savedDataName = {
  language: '@Data:language',
  encyclopedia: '@Data:encyclopedia',
  achievement: '@Data:achievement',
  commanderSkill: '@Data:commanderSkill',
  warship: '@Data:warship',
  gameMap: '@Data:gameMap',
  consumable: '@Data:consumable',
}