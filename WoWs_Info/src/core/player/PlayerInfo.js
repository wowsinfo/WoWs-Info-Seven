import { ServerManager, DateCalculator } from '../../core';
import { API } from '../../constant/value';
import strings from '../../localization';

class PlayerInfo {
  constructor(playerStr) {
    // playerStr -> HenryQuan|2011774448|3
    let player = playerStr.split('|');
    var format = require('string-format');
    this.api = format(API.PlayerInfo, ServerManager.getDomainFrom(player[2])) + player[1];
    this.server = player[2];    
    this.id = player[1];
    this.name = player[0];
  }

  async Search() {
    try {
      let response = await fetch(this.api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        // This player is not hidden       
        if (json.meta.hidden == null) return json.data;
        else return null;
      }
    } catch (error) {
      console.error(error);
    }
  }

  getBasic8Info(json) {
    if (json != null) {
      let player = json[this.id];
      let pvp = player.statistics.pvp;
      return PlayerInfo.calBasic8CellInfo(pvp.battles, pvp.damage_dealt, pvp.wins, pvp.xp, 
        pvp.main_battery.hits, pvp.main_battery.shots, pvp.survived_battles, pvp.frags);
    }
  }

  async getPlayerBasicInfo(json) {
    if (json != null) {
      let player = json[this.id];
      let info = {};
      info.level = player.leveling_tier;
      var format = require('string-format');      
      let api = format(API.CreatedAt, ServerManager.getDomainFrom(this.server)) + this.name;
      // Get created at xxx
      try {
        let response = await fetch(api);
        let json = await response.json();
        if (json != null && json.status == 'ok') {
          let created = json.data[0].created_at;
          let now = Math.floor(Date.now() / 1000);
          let diff = (now - created) / (3600 * 24);
          info.created = DateCalculator.diffToString(diff);
          return info;
        }
      } catch (error) {
        console.error(error);
      }
    }
  }

  getRecordWeaponInfo(json) {
    if (json != null) {
      var recordWeapon = [];
      var ship; let shipJson = global.warshipJson;
      let pvp = json[this.id].statistics.pvp;
      // console.log(pvp);
      let infoList = [pvp.main_battery, pvp.second_battery, pvp.torpedoes, pvp.ramming, pvp.aircraft];
      let titleList = [strings.max_main_battery, strings.max_secondary, strings.max_torpedo, strings.max_ramming, strings.max_aircraft]
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
            entry.image = ship.images.small;
            entry.number = info.frags;
            recordWeapon.push(entry);
          }
        }
      }
      return recordWeapon;
    }
  }

  getRecordInfo(json) {
    if (json != null) {
      var record = []; 
      var ship; let shipJson = global.warshipJson;
      let pvp = json[this.id].statistics.pvp;

      let titleList = [strings.max_damage, strings.max_exp, strings.max_kill, strings.max_plane];
      let infoList = [pvp.max_damage_dealt_ship_id, pvp.max_xp_ship_id, pvp.max_frags_ship_id, pvp.max_planes_killed_ship_id];
      let dataList = [pvp.max_damage_dealt, pvp.max_xp, pvp.max_frags_battle, pvp.max_planes_killed];
      for (var i = 0; i < titleList.length; i++) {
        var info = {};
        info.title = titleList[i];
        ship = shipJson[infoList[i]];
        if (ship != null) {
          info.name = ship.name;
          info.image = ship.images.small;
          info.number = dataList[i];
          record.push(info);
        }
      }
      return record;
    }
  }

  static calBasic8CellInfo(battle, damage, win, exp, hit, shot, survival, kill) {
    let info = {battle: battle, winrate: 0, killdeath: 0, damage: 0, hitratio: 0, survival: 0, frag: 0, exp: 0};
    if (battle > 0) {
      info.damage = Math.round(damage / battle);
      info.winrate = Math.round(win * 10000 / battle) / 100;
      info.exp = Math.round(exp / battle);
      info.hitratio = Math.round(hit * 10000 / shot) / 100;
      info.survival = Math.round(survival * 10000 / battle) / 100;
      let death = battle - survival;
      info.killdeath = Math.round(kill * 100 / death) / 100;
      info.frag = Math.round(kill * 100 / battle) / 100;
    }
    return info;
  }
}

export {PlayerInfo};