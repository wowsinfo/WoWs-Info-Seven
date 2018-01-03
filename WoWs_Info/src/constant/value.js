// This is my WarGaming Developer ID
// Please use yours or demo if you are running this app
export const ApplicationID = '***ApplicationID***';

export const API = {
  GameVersion: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' +  ApplicationID + '&fields=game_version',
  PlayerOnline: 'https://api.worldoftanks.{0}/wgn/servers/info/?application_id=' + ApplicationID + '&fields=players_online&game=wows',
  News: 'https://worldofwarships.{0}/',
  PlayerSearch: 'https://api.worldofwarships.{0}/wows/account/list/?application_id=' + ApplicationID + '&search=',
  PlayerInfo: 'https://api.worldofwarships.{0}/wows/account/info/?application_id=' + ApplicationID + '&account_id=',
  CreatedAt: 'https://api.worldoftanks.{0}/wgn/account/list/?application_id=' + ApplicationID + '&fields=created_at&search=',
  ShipInfo: 'https://api.worldofwarships.{0}/wows/ships/stats/?application_id=' + ApplicationID + '&fields=pvp.max_planes_killed%2Cpvp.damage_dealt%2Cpvp.wins%2Cpvp.max_damage_dealt%2Cpvp.ramming%2Cpvp.torpedoes%2Cpvp.aircraft%2Cpvp.frags%2Cpvp.battles%2Cpvp.max_xp%2Cpvp.survived_battles%2Cship_id%2Cpvp.max_frags_battle%2Cpvp.main_battery%2Cpvp.second_battery%2Cpvp.xp&account_id=',
  RankInfo: 'https://api.worldofwarships.{0}/wows/seasons/accountinfo/?application_id=' + ApplicationID + '&fields=seasons.rank_solo.damage_dealt%2Cseasons.rank_solo.wins%2Cseasons.rank_solo.battles%2Cseasons.rank_info&account_id=',
  RankShipInfo: 'https://api.worldofwarships.{0}/wows/seasons/shipstats/?application_id=' + ApplicationID + '&fields=ship_id%2Cseasons.rank_solo&account_id=',
}

export const DataAPI = {
  Achievement: 'https://api.worldofwarships.{0}/wows/encyclopedia/achievements/?application_id=' +  ApplicationID + '&fields=battle.hidden%2Cbattle.name%2Cbattle.image%2Cbattle.image_inactive%2Cbattle.description',
  CommanderSkill: 'https://api.worldofwarships.{0}/wows/encyclopedia/crewskills/?application_id=' +  ApplicationID + '&fields=icon%2Cname%2Ctier%2Cperks.description',
  GameMap: 'https://api.worldofwarships.{0}/wows/encyclopedia/battlearenas/?application_id=' +  ApplicationID + '&fields=name%2Cicon%2Cdescription',
  Language: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' +  ApplicationID + '&fields=languages',
  Encyclopedia: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' +  ApplicationID + '&fields=ship_nations%2Cship_modules',
  ShipType: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' +  ApplicationID + '&fields=ship_types&language=en',
  Consumable: 'https://api.worldofwarships.{0}/wows/encyclopedia/consumables/?application_id=' +  ApplicationID + '&fields=type%2Cdescription%2Cname%2Cimage%2Cprice_credit%2Cprice_gold%2Cprofile.description',
  Warship: 'https://api.worldofwarships.{0}/wows/encyclopedia/ships/?application_id=' +  ApplicationID + '&fields=name%2Cnation%2Ctype%2Ctier%2Cship_id%2Cship_id_str%2Cimages.small',
  Collection: 'https://api.worldofwarships.{0}/wows/encyclopedia/collections/?application_id=' + ApplicationID + '&fields=-card_cost%2C-tag',
  CollectionItem: 'https://api.worldofwarships.{0}/wows/encyclopedia/collectioncards/?application_id=' + ApplicationID + '&fields=images.small%2Ccard_id%2Ccollection_id%2Cdescription%2Cname',
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

export const wikiIndex = {
  Achievement: 0,
  Flag_Camouflage: 1,
  Warship: 2,
  Commander: 3,
  Upgrade: 4,
  Map: 5,
  Collection: 6,
}

// Data name from old IOS project
export const IOSDataName = {
  firstLaunch: 'first_launch',
  server: 'server',
  userName: 'username',
  hasPurchased: 'hasPurchased',
  friend: 'friend_list',
  isAdvancedUnlocked: 'advancedunlocked',
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
  moeMode: '@WoWs_Info:moeMode',
}

export const savedDataName = {
  language: '@Data:language',
  encyclopedia: '@Data:encyclopedia',
  shipType: '@Data:shipType',
  achievement: '@Data:achievement',
  commanderSkill: '@Data:commanderSkill',
  collection: '@Data:collection',
  collectionItem: '@Data:collectionItem',
  warship: '@Data:warship',
  gameMap: '@Data:gameMap',
  consumable: '@Data:consumable',
  alias: '@Data:alias',
  personalRating: '@Data:personalRating',
}