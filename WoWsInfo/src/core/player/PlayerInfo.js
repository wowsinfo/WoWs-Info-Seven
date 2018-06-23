import { ServerManager, DateCalculator } from '../../core';
import { API } from '../../constant/value';
import language from '../../constant/language';

class PlayerInfo {
  constructor(name, id, server) {
    // playerStr -> HenryQuan|2011774448|3
    var format = require('string-format');
    this.api = format(API.PlayerInfo, ServerManager.domainName(server)) + id;
    this.clan = format(API.PlayerClan, ServerManager.domainName(server)) + id;
    this.server = server;
    this.id = id;
    this.name = name;
  }

  /**
   * Search for player information
   */
  async Search() {
    try {
      var response = await fetch(this.api);
      var json = await response.json();
      if (json != null && json.status == 'ok') {
        // This player is not hidden  
        if (json.meta.hidden == null) {
          let player = json.data[this.id];
          // Get player clan tag
          response = await fetch(this.clan);
          json = await response.json();
          if (json != null && json.status == 'ok') {
            if (json.data[this.id] != null) player.clan = json.data[this.id].clan.tag;
            return player;
          }
        }
      }
    } catch (error) {
      console.error(error);
    }
  }

  /**
   * Get player basic8cell information
   * @param {*} json 
   */
  getBasic8Info(json) {
    if (json != null) {
      let pvp = json.statistics.pvp;
      return PlayerInfo.calBasic8CellInfo(pvp);
    }
  }

  /**
   * Get basic information for player
   * @param {*} json 
   */
  async getPlayerBasicInfo(json) {
    if (json != null) {
      let info = {};
      info.clan = json.clan;
      info.level = json.leveling_tier;
      info.last_battle = new Date(json.last_battle_time * 1000).toLocaleString();
      var format = require('string-format');      
      let createdAtApi = format(API.CreatedAt, ServerManager.domainName(this.server)) + this.name;
      let currRankApi = format(API.CurrRankInfo, ServerManager.domainName(this.server)) + this.id;
      // Get created at xxx
      try {
        var response = await fetch(createdAtApi);
        var json = await response.json();
        if (json != null && json.status == 'ok') {
          let created = json.data[0].created_at;
          info.created_at = created;
          let now = Math.floor(Date.now() / 1000);
          let diff = (now - created) / (3600 * 24);
          info.created = DateCalculator.diffToString(diff);
        }
        response = await fetch(currRankApi);
        json = await response.json();
        if (json != null && json.status == 'ok') {
          let data = json.data[this.id];
          if (data != null) {
            let currRank = data.seasons;
            var lastest = 0;
            for (key in currRank) {
              let season = parseInt(key);
              if (season > lastest) lastest = season;
            }
            info.rank = currRank[lastest].rank_info.rank;
          } else info.rank = 0;
        }
        return info;
      } catch (error) {
        console.error(error);
      }
    }
  }

  /**
   * Get player weapon information
   * @param {*} json 
   */
  getRecordWeaponInfo(json) {
    if (json != null) {
      var recordWeapon = [];
      var ship; let shipJson = data.warship;
      const { main_battery, second_battery, torpedoes, ramming, aircraft } = json.statistics.pvp;
      // console.log(pvp);
      let infoList = [main_battery, second_battery, torpedoes, ramming, aircraft];
      let titleList = [language.player_max_main_battery, language.player_max_secondary, language.player_max_torpedo, language.player_max_ramming, language.player_max_aircraft];
      for (var i = 0; i < infoList.length; i++) {
        let info = infoList[i];
        if (info.frags > 0) {
          // It is pointless if it is zero!
          ship = shipJson[info.max_frags_ship_id];
          if (ship != null) {
            // This ship is legit
            var entry = {};
            entry.title = titleList[i];
            entry.name = ship.name;
            entry.image = ship.icon;
            entry.number = info.frags;
            recordWeapon.push(entry);
          }
        }
      }
      return recordWeapon;
    }
  }

  /**
   * Get player record
   * @param {*} json 
   */
  getRecordInfo(json) {
    if (json != null) {
      var record = []; 
      var ship; let shipJson = data.warship;
      const { max_damage_dealt_ship_id, max_xp_ship_id, max_frags_ship_id, max_planes_killed_ship_id,
        max_damage_dealt, max_xp, max_frags_battle, max_planes_killed } = json.statistics.pvp;

      let titleList = [language.player_max_damage_dealt, language.player_max_xp, language.player_max_kill, language.player_max_plane];
      let infoList = [max_damage_dealt_ship_id, max_xp_ship_id, max_frags_ship_id, max_planes_killed_ship_id];
      let dataList = [max_damage_dealt, max_xp, max_frags_battle, max_planes_killed];
      for (var i = 0; i < titleList.length; i++) {
        var info = {};
        info.title = titleList[i];
        ship = shipJson[infoList[i]];
        if (ship != null) {
          info.name = ship.name;
          info.image = ship.icon;
          info.number = dataList[i];
          record.push(info);
        }
      }
      return record;
    }
  }

  /**
   * Calculate player basic8cell data
   * @param {*} pvp 
   */
  static calBasic8CellInfo(pvp) {
    const { battles, damage_dealt, wins, xp, main_battery, survived_battles, frags } = pvp;
    let info = {battle: battles, winrate: 0, killdeath: 0, damage: 0, hitratio: 0, survival: 0, frag: 0, exp: 0};
    if (battles > 0) {
      info.damage = Math.round(damage_dealt / battles);
      info.winrate = Math.round(wins * 10000 / battles) / 100;
      info.exp = Math.round(xp / battles);
      info.hitratio = Math.round(main_battery.hits * 10000 / main_battery.shots) / 100;
      info.survival = Math.round(survived_battles * 10000 / battles) / 100;
      let death = battles - survived_battles;
      info.killdeath = Math.round(frags * 100 / death) / 100;
      info.frag = Math.round(frags * 100 / battles) / 100;
    }
    return info;
  }
}

export { PlayerInfo };