import AppKey from '../value/key';

class API {
  constructor(server, extra) {
    // Buil the request url
  }
}

export const WoWsAPI = {
  AchievementInfo: 'https://api.worldofwarships.{0}/wows/account/achievements/?application_id=' + AppKey + '&language=en&fields=battle&account_id=',
  GameVersion: 'https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=' +  AppKey + '&fields=game_version',
  // Player
  PlayerInfo: 'https://api.worldofwarships.{0}/wows/account/info/?application_id=' + AppKey + '&account_id=',
  CreatedAt: 'https://api.worldoftanks.{0}/wgn/account/list/?application_id=' + AppKey + '&fields=created_at&search=',
  PlayerSearch: 'https://api.worldofwarships.{0}/wows/account/list/?application_id=' + AppKey + '&search=',
  PlayerOnline: 'https://api.worldoftanks.{0}/wgn/servers/info/?application_id=' + AppKey + '&fields=players_online&game=wows',
  // Clan
  PlayerClan: 'https://api.worldofwarships.{0}/wows/clans/accountinfo/?application_id=' + AppKey + '&extra=clan&fields=clan.tag&account_id=',
  ClanInfo: 'https://api.worldofwarships.{0}/wows/clans/info/?application_id=' + AppKey + '&extra=members&fields=-members_ids&clan_id=',
  ClanSearch: 'https://api.worldofwarships.{0}/wows/clans/list/?application_id=' + AppKey + '&fields=clan_id%2Ctag&search=',
  // Rank
  RankInfo: 'https://api.worldofwarships.{0}/wows/seasons/accountinfo/?application_id=' + AppKey + '&fields=seasons.rank_solo.damage_dealt%2Cseasons.rank_solo.wins%2Cseasons.rank_solo.battles%2Cseasons.rank_info&account_id=',
  CurrRankInfo: 'https://api.worldofwarships.{0}/wows/seasons/accountinfo/?application_id=' + AppKey +'&fields=seasons.rank_info.rank&account_id=',
  RankShipInfo: 'https://api.worldofwarships.{0}/wows/seasons/shipstats/?application_id=' + AppKey + '&fields=ship_id%2Cseasons.rank_solo&account_id=',
  // Ship
  ShipInfo: 'https://api.worldofwarships.{0}/wows/ships/stats/?application_id=' + AppKey + '&fields=pvp.max_planes_killed%2Cpvp.damage_dealt%2Cpvp.wins%2Cpvp.max_damage_dealt%2Cpvp.ramming%2Cpvp.torpedoes%2Cpvp.aircraft%2Cpvp.frags%2Cpvp.battles%2Cpvp.max_xp%2Cpvp.survived_battles%2Cship_id%2Cpvp.max_frags_battle%2Cpvp.main_battery%2Cpvp.second_battery%2Cpvp.xp&account_id=',
  ShipWiki: 'https://api.worldofwarships.{0}/wows/encyclopedia/ships/?application_id=' + AppKey + '&ship_id={1}',
  ShipModule: 'https://api.worldofwarships.{0}/wows/encyclopedia/shipprofile/?application_id=' + AppKey + '&ship_id={1}',
}