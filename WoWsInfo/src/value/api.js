import { AppKey } from './key';

// This part is for getting player information (rank, ship, clan and achievement) and some wiki ship
export const WoWsAPI = {
  GameVersion: `https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=${AppKey}&fields=game_version`,
  // Player
  PlayerInfo: `https://api.worldofwarships.{0}/wows/account/info/?application_id=${AppKey}&account_id=`,
  CreatedAt: `https://api.worldoftanks.{0}/wgn/account/list/?application_id=${AppKey}&fields=created_at&search=`,
  PlayerAchievement: `https://api.worldofwarships.{0}/wows/account/achievements/?application_id=${AppKey}&language=en&fields=battle&account_id=`,
  PlayerSearch: `https://api.worldofwarships.{0}/wows/account/list/?application_id=${AppKey}&search=`,
  PlayerOnline: `https://api.worldoftanks.{0}/wgn/servers/info/?application_id=${AppKey}&fields=players_online&game=wows`,
  // Clan
  PlayerClan: `https://api.worldofwarships.{0}/wows/clans/accountinfo/?application_id=${AppKey}&extra=clan&fields=clan.tag&account_id=`,
  ClanInfo: `https://api.worldofwarships.{0}/wows/clans/info/?application_id=${AppKey}&extra=members&fields=-members_ids&clan_id=`,
  ClanSearch: `https://api.worldofwarships.{0}/wows/clans/list/?application_id=${AppKey}&fields=clan_id%2Ctag&search=`,
  // Rank
  RankInfo: `https://api.worldofwarships.{0}/wows/seasons/accountinfo/?application_id=${AppKey}&fields=seasons.rank_solo.damage_dealt%2Cseasons.rank_solo.wins%2Cseasons.rank_solo.battles%2Cseasons.rank_info&account_id=`,
  CurrRankInfo: `https://api.worldofwarships.{0}/wows/seasons/accountinfo/?application_id=${AppKey}&fields=seasons.rank_info.rank&account_id=`,
  RankShipInfo: `https://api.worldofwarships.{0}/wows/seasons/shipstats/?application_id=${AppKey}&fields=ship_id%2Cseasons.rank_solo&account_id=`,
  // Ships
  ShipInfo: `https://api.worldofwarships.{0}/wows/ships/stats/?application_id=${AppKey}&fields=pvp.max_planes_killed%2Cpvp.damage_dealt%2Cpvp.wins%2Cpvp.max_damage_dealt%2Cpvp.ramming%2Cpvp.torpedoes%2Cpvp.aircraft%2Cpvp.frags%2Cpvp.battles%2Cpvp.max_xp%2Cpvp.survived_battles%2Cship_id%2Cpvp.max_frags_battle%2Cpvp.main_battery%2Cpvp.second_battery%2Cpvp.xp&account_id=`,
  ShipWiki: `https://api.worldofwarships.{0}/wows/encyclopedia/ships/?application_id=${AppKey}&ship_id={1}`,
  ShipModule: `https://api.worldofwarships.{0}/wows/encyclopedia/shipprofile/?application_id=${AppKey}&ship_id={1}`,
}

// This part is mainly for Wiki
export const WikiAPI = {
  // Personal rating and ship model
  PersonalRating: 'https://wows-numbers.com/personal/rating/expected/json/',
  // TODO: update this link when I remove this branch
  ShipModel: 'https://raw.githubusercontent.com/HenryQuan/WoWs-Info-Ultra/API/json/model.json',
  // Wiki
  Achievement: `https://api.worldofwarships.{0}/wows/encyclopedia/achievements/?application_id=${AppKey}&fields=battle.hidden%2Cbattle.achievement_id%2Cbattle.name%2Cbattle.image%2Cbattle.image_inactive%2Cbattle.description`,
  Warship: `https://api.worldofwarships.{0}/wows/encyclopedia/ships/?application_id=${AppKey}&fields=name%2Cnation%2Ctype%2Ctier%2Cship_id%2Cship_id_str%2Cimages.small%2Cis_premium%2Cis_special`,
  CommanderSkill: `https://api.worldofwarships.{0}/wows/encyclopedia/crewskills/?application_id=${AppKey}&fields=icon%2Cname%2Ctier%2Cperks.description`,
  GameMap: `https://api.worldofwarships.{0}/wows/encyclopedia/battlearenas/?application_id=${AppKey}&fields=name%2Cicon%2Cdescription`,
  // Flags, camouflages and upgrades
  Consumable: `https://api.worldofwarships.{0}/wows/encyclopedia/consumables/?application_id=${AppKey}&fields=type%2Cconsumable_id%2Cdescription%2Cname%2Cimage%2Cprice_credit%2Cprice_gold%2Cprofile.description`,
  Collection: `https://api.worldofwarships.{0}/wows/encyclopedia/collections/?application_id=${AppKey}&fields=-card_cost%2C-tag`,
  CollectionItem: `https://api.worldofwarships.{0}/wows/encyclopedia/collectioncards/?application_id=${AppKey}&fields=images.small%2Ccard_id%2Ccollection_id%2Cdescription%2Cname`,
  // Extra info for wiki
  Language: `https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=${AppKey}&fields=languages`,
  Encyclopedia: `https://api.worldofwarships.{0}/wows/encyclopedia/info/?application_id=${AppKey}&fields=ship_nations%2Cship_modules%2Cship_types`,
  // Additional data collected by me
  // Currently support model
  Github_Model: 'https://raw.githubusercontent.com/HenryQuan/WoWs-Info-Ultra/API/json/model.json',
  Github_Slot: 'https://raw.githubusercontent.com/HenryQuan/WoWs-Info-Ultra/API/json/slot.json'
}
