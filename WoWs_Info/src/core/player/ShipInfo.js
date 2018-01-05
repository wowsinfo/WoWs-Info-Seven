import { API } from '../../constant/value';
import { ServerManager, PersonalRating } from '../../core';

class ShipInfo {
  constructor(id, server) {
    let format = require('string-format');
    this.api = format(API.ShipInfo, ServerManager.getDomainFrom(server)) + id;
    this.id = id;
  }

  async getShipInfo() {
    try {
      let response = await fetch(this.api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        if (json.meta.hidden == null) {
          // This account is not hidden
          let ships = json.data[this.id];
          // For personal rating for all ships
          var totalDamage = 0, totalWin = 0, totalFrag = 0, expectedDamage = 0, expectedWin = 0, expectedFrag = 0;
          let prJson = global.personalRatingJson;
          for (var i = 0; i < ships.length; i++) {
            // Calculate rating for each ship and for all ships
            let currShip = ships[i];
            // All needed info for now
            let shipID = currShip.ship_id;      
            let battle = currShip.pvp.battles;
            let damage = currShip.pvp.damage_dealt;
            let win = currShip.pvp.wins;
            let frag = currShip.pvp.frags;
            // Accumulate total info
            let shipData = global.warshipJson[shipID];
            if (battle > 0) {           
              let shipRatingInfo = prJson[shipID];
              if (shipRatingInfo != null) {
                currShip.battle = battle;
                let avg_damage = damage / battle;
                totalDamage += avg_damage;
                currShip.avg_damage = Math.round(avg_damage);
                let win_rate = Math.round(win * 10000 / battle) / 100;
                totalWin += win_rate;
                currShip.win_rate = win_rate;
                let avg_frag = Math.round(frag * 100 / battle) / 100;
                totalFrag += avg_frag;
                currShip.avg_frag = avg_frag;
                expectedDamage += shipRatingInfo.average_damage_dealt;
                expectedWin += shipRatingInfo.win_rate;
                expectedFrag += shipRatingInfo.average_frags;
                // Calculate PR
                let rating = new PersonalRating(shipID, battle, damage, win, frag);
                let pr = rating.getRating();
                let index = PersonalRating.getIndex(pr);
                currShip.pr = pr;
                currShip.index = index;
              }
            }
          }
          // Calculate overall pr
          let overall = PersonalRating.getTotalRating(totalDamage, expectedDamage, totalWin, expectedWin, totalFrag, expectedFrag);
          ships.overall = PersonalRating.getIndex(overall);
          return ships;
        } else return null;
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export {ShipInfo};