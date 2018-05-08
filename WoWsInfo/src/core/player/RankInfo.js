import { API } from '../../constant/value';
import { ServerManager, PersonalRating } from '../../core';

class RankInfo {
  constructor(id, index) {
    let format = require('string-format');    
    let server = ServerManager.domainName(index);
    this.rankInfoApi = format(API.RankInfo, server) + id;
    this.rankShipInfoApi = format(API.RankShipInfo, server) + id;
    this.id = id;
  }

  async getRankInfo() {
    try {
      let response = await fetch(this.rankInfoApi);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        let data = json.data[this.id];
        if (data != null){
          let info = data.seasons;
          var rank = [];
          for (key in info) {
            let curr = info[key];
            // Player did not play any battles during this season
            if (curr.rank_solo == null) continue;
            curr.season = key;
            rank.push(curr);
          }
          // Sort by season
          rank.sort(function(a, b) { return b.season - a.season })
          return rank;
        }
      }
    } catch (error) {
      console.error(error);
    }
  }

  async getRankShipInfo() {
    try {
      let response = await fetch(this.rankShipInfoApi);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        let info = json.data[this.id]; 
        if (info == null) return;
        var shipData = [];     
        for (var i = 0; i < info.length; i++) {
          let data = info[i].seasons;
          let ship_id = info[i].ship_id;
          for (key in data) {
            var curr = {ship_id: ship_id};
            let ship = data[key];
            curr.pvp = ship.rank_solo; delete curr.seasons;
            curr.season = key;            
            shipData.push(curr);          
          }
        }
        // console.log(shipData);
        return shipData;       
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export { RankInfo };