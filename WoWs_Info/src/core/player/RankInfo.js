import { API } from '../../constant/value';
import { ServerManager } from '../../core';

class RankInfo {
  constructor(id, server) {
    let format = require('string-format');    
    let server = ServerManager.getDomainFrom(server);
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
    }
  }

  async getRankShipInfo() {
    let response = await fetch(this.rankShipInfoApi);
    let json = await response.json();
    if (json != null && json.status == 'ok') {

    }
  }
}

export {RankInfo};