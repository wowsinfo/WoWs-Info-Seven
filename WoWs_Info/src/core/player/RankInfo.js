import { API } from '../../constant/value';
import { ServerManager } from '../../core';

class RankInfo {
  constructor(id, index) {
    let format = require('string-format');    
    let server = ServerManager.getDomainFrom(index);
    this.rankInfoApi = format(API.RankInfo, server) + id;
    this.rankShipInfoApi = format(API.RankShipInfo, server) + id;
    this.id = id;
  }

  async getRankInfo() {
    let response = await fetch(this.rankInfoApi);
    let json = await response.json();
    if (json != null && json.status == 'ok') {
      let info = json.data[this.id].seasons;
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

  async getRankShipInfo() {
    let response = await fetch(this.rankShipInfoApi);
    let json = await response.json();
    if (json != null && json.status == 'ok') {
      let info = json.data[this.id];
      for (var i = 0; i < info.length; i++) {
        let curr = info[i];
        let data = curr.seasons;
        let key = Object.keys(data)[0];
        curr.season = key;
        curr.rank_solo = data[key].rank_solo;
        delete curr.seasons;
      }     
      return info;      
    }
  }
}

export {RankInfo};