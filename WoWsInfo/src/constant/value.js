// Please use your id or demo if you are running this app
export const ApplicationID = '4e54ba74077a8230e457bf3e7e9ae858';

export const VERSION = '1.0.1';
export const IOSVersion = '1.5.2';
export const AndroidVersion = '1.0.2';
export const Github = 'https://github.com/HenryQuan/WoWs-Info-Go';
export const AppStore = 'https://itunes.apple.com/app/id1202750166';
export const GooglePlay = 'https://play.google.com/store/apps/details?id=com.yihengquan.wowsinfo';
export const Developer = 'mailto:development.henryquan@gmail.com';

export const API = {
  GameVersion: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' +  ApplicationID + '&fields=game_version',
  PlayerOnline: 'https://api.worldoftanks.{0}/wgn/servers/info/?application_id=' + ApplicationID + '&fields=players_online&game=wows',
  News: 'https://worldofwarships.{0}/',
  PlayerClan: 'https://api.worldofwarships.{0}/wows/clans/accountinfo/?application_id=' + ApplicationID + '&extra=clan&fields=clan.tag&account_id=',
  PlayerSearch: 'https://api.worldofwarships.{0}/wows/account/list/?application_id=' + ApplicationID + '&search=',
  PlayerInfo: 'https://api.worldofwarships.{0}/wows/account/info/?application_id=' + ApplicationID + '&account_id=',
  CreatedAt: 'https://api.worldoftanks.{0}/wgn/account/list/?application_id=' + ApplicationID + '&fields=created_at&search=',
  ShipInfo: 'https://api.worldofwarships.{0}/wows/ships/stats/?application_id=' + ApplicationID + '&fields=pvp.max_planes_killed%2Cpvp.damage_dealt%2Cpvp.wins%2Cpvp.max_damage_dealt%2Cpvp.ramming%2Cpvp.torpedoes%2Cpvp.aircraft%2Cpvp.frags%2Cpvp.battles%2Cpvp.max_xp%2Cpvp.survived_battles%2Cship_id%2Cpvp.max_frags_battle%2Cpvp.main_battery%2Cpvp.second_battery%2Cpvp.xp&account_id=',
  RankInfo: 'https://api.worldofwarships.{0}/wows/seasons/accountinfo/?application_id=' + ApplicationID + '&fields=seasons.rank_solo.damage_dealt%2Cseasons.rank_solo.wins%2Cseasons.rank_solo.battles%2Cseasons.rank_info&account_id=',
  RankShipInfo: 'https://api.worldofwarships.{0}/wows/seasons/shipstats/?application_id=' + ApplicationID + '&fields=ship_id%2Cseasons.rank_solo&account_id=',
  CurrRankInfo: 'https://api.worldofwarships.{0}/wows/seasons/accountinfo/?application_id=' + ApplicationID +'&fields=seasons.rank_info.rank&account_id=',
  AchievementInfo: 'https://api.worldofwarships.{0}/wows/account/achievements/?application_id=' + ApplicationID + '&language=en&fields=battle&account_id=',
  ClanSearch: 'https://api.worldofwarships.{0}/wows/clans/list/?application_id=' + ApplicationID + '&fields=clan_id%2Ctag&search=',
  ClanInfo: 'https://api.worldofwarships.{0}/wows/clans/info/?application_id=' + ApplicationID + '&extra=members&fields=-members_ids&clan_id=',
  Ship_Wiki: 'https://api.worldofwarships.{0}/wows/encyclopedia/ships/?application_id=' + ApplicationID + '&ship_id={1}'
}

export const DataAPI = {
  PersonalRating: 'https://wows-numbers.com/personal/rating/expected/json/',
  Achievement: 'https://api.worldofwarships.{0}/wows/encyclopedia/achievements/?application_id=' +  ApplicationID + '&fields=battle.hidden%2Cbattle.name%2Cbattle.image%2Cbattle.image_inactive%2Cbattle.description',
  CommanderSkill: 'https://api.worldofwarships.{0}/wows/encyclopedia/crewskills/?application_id=' +  ApplicationID + '&fields=icon%2Cname%2Ctier%2Cperks.description',
  GameMap: 'https://api.worldofwarships.{0}/wows/encyclopedia/battlearenas/?application_id=' +  ApplicationID + '&fields=name%2Cicon%2Cdescription',
  Language: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' +  ApplicationID + '&fields=languages',
  Encyclopedia: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' +  ApplicationID + '&fields=ship_nations%2Cship_modules',
  ShipType: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' +  ApplicationID + '&fields=ship_types',
  Consumable: 'https://api.worldofwarships.{0}/wows/encyclopedia/consumables/?application_id=' +  ApplicationID + '&fields=type%2Cdescription%2Cname%2Cimage%2Cprice_credit%2Cprice_gold%2Cprofile.description',
  Warship: 'https://api.worldofwarships.{0}/wows/encyclopedia/ships/?application_id=' +  ApplicationID + '&fields=name%2Cnation%2Ctype%2Ctier%2Cship_id%2Cship_id_str%2Cimages.small',
  Collection: 'https://api.worldofwarships.{0}/wows/encyclopedia/collections/?application_id=' + ApplicationID + '&fields=-card_cost%2C-tag',
  CollectionItem: 'https://api.worldofwarships.{0}/wows/encyclopedia/collectioncards/?application_id=' + ApplicationID + '&fields=images.small%2Ccard_id%2Ccollection_id%2Cdescription%2Cname',
}

// All supported game servers
export const ServerIndex = {
  Russia: 0,
  Europe: 1,
  NorthAmerica: 2,
  Asia: 3
}

export const WikiIndex = {
  Achievement: 0,
  FlagCamouflage: 1,
  Warship: 2,
  Commander: 3,
  Upgrade: 4,
  Map: 5,
  Collection: 6
}

// Data name from old IOS project
export const IOSData = {
  first_launch: 'first_launch',
  server: 'server',
  username: 'username',
  has_purchased: 'hasPurchased',
  friend: 'friend_list',
  is_advanced_unlocked: 'advancedunlocked',
}

export const LocalData = {
  has_ads: '@WoWs_Info:hasAds',
  friend: '@WoWs_Info:playerList',
  user_info: '@WoWs_Info:userInfo',
  userdata: '@WoWs_Info:userData',
  curr_version: '@WoWs_Info:currVersion',
  game_version: '@WoWs_Info:gameVersion',
  date: '@WoWs_Info:currDate',
  // To do recent data for saved user only
  last_update: '@WoWs_Info:lastUpdate',
  data_saver: '@WoWs_Info:dataSaver',
  server: '@WoWs_Info:currServer',
  theme: '@WoWs_Info:themeColour',
  first_launch: '@WoWs_Info:firstLaunch',
  api_language: '@WoWs_Info:apiLanguage',
  news_language: '@WoWs_Info:newsLanguage',
  // IOS Tab
  saved_tab: '@WoWs_Info:savedTab',
}

export const SavedData = {
  language: '@Data:language',
  encyclopedia: '@Data:encyclopedia',
  ship_type: '@Data:ship_type',
  achievement: '@Data:achievement',
  commander_skill: '@Data:commander_skill',
  collection: '@Data:collection',
  collection_item: '@Data:collection_item',
  warship: '@Data:warship',
  map: '@Data:gameMap',
  consumable: '@Data:consumable',
  personal_rating: '@Data:personal_rating',
}