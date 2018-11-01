import { ServerManager, PersonalRating } from '../../core';
import { API } from '../../constant/value';

class ShipInfo {
  constructor(id, server) {
    let format = require('string-format');
    this.api = format(API.ShipInfo, ServerManager.domainName(server)) + id;
    this.id = String(id).includes('&') ? id.split('&')[0] : id;
  }

  async getShipInfo(rank) {
    try {
      var ships = [];
      if (rank != null) ships = rank;
      else {
        let response = await fetch(this.api);
        let json = await response.json();
        if (json != null && json.status == 'ok') {
          if (json.meta.hidden == null) ships = json.data[this.id];
          console.log(json);
        }
      }

      console.log(ships);
      // For personal rating for all ships
      var totalDamage = 0, totalWin = 0, totalFrag = 0, expectedDamage = 0, expectedWin = 0, expectedFrag = 0;
      let prJson = data.personal_rating; 
      let playerShip = [];
      if (ships) {
        for (var i = 0; i < ships.length; i++) {
          // Calculate rating for each ship and for all ships
          let currShip = Object.assign({}, ships[i]);
          const { ship_id } = currShip;
          const { battles, damage_dealt, wins, frags } = currShip.pvp;
          // Accumulate total info
          let shipData = data.warship[ship_id];
          if (battles > 0) { 
            let shipRatingInfo = prJson[ship_id];
            // Ignore new ship until wows numbers provide information
            if (shipRatingInfo != null && shipRatingInfo.win_rate != null) {
              currShip.battles = battles;
              let avg_damage = damage_dealt / battles;
              totalDamage += avg_damage;
              currShip.avg_damage = Math.round(avg_damage);
              let win_rate = Math.round(wins * 10000 / battles) / 100;
              totalWin += win_rate;
              currShip.win_rate = win_rate;
              let avg_frag = Math.round(frags * 100 / battles) / 100;
              totalFrag += avg_frag;
              currShip.avg_frag = avg_frag;
              expectedDamage += shipRatingInfo.average_damage_dealt;
              expectedWin += shipRatingInfo.win_rate;
              expectedFrag += shipRatingInfo.average_frags;
              // Calculate PR
              let rating = new PersonalRating(ship_id, battles, damage_dealt, wins, frags);
              let pr = rating.getRating();
              let index = PersonalRating.getIndex(pr);
              currShip.pr = pr;
              currShip.ap = rating.getAbilityPoint();
              currShip.index = index;
              playerShip.push(currShip);
            }
          }
        }
      }
      // Calculate overall pr
      let overall = PersonalRating.getTotalRating(totalDamage, expectedDamage, totalWin, expectedWin, totalFrag, expectedFrag);
      playerShip.overall = PersonalRating.getIndex(overall);
      return playerShip;
    } catch (error) {
      console.error(error);
    }
  }
}

export { ShipInfo };