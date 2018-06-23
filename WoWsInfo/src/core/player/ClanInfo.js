import { ServerManager, DateCalculator } from '../../core';
import { API } from '../../constant/value';

class ClanInfo {
  constructor(name, id, server) {
    // clanStr -> FFD|2000008934|3
    this.server = server;    
    this.id = id;
    this.name = server;
    var format = require('string-format');
    this.api = format(API.ClanInfo, ServerManager.domainName(this.server)) + this.id;
  }

  async Search() {
    try {
      console.log(this.api);
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

  static getInfoFrom(data, id) {
    if (data != null && data[id] != null) {
      let clanInfo = data[id];
      clanInfo.id = clanInfo.clan_id; delete clanInfo.clan_id;
      clanInfo.count = clanInfo.members_count; delete clanInfo.members_count;
      clanInfo.text = clanInfo.description; delete clanInfo.description;
      delete clanInfo.creator_id; delete clanInfo.creator_name; 
      delete clanInfo.updated_at; delete clanInfo.leader_id;
      return clanInfo;
    }
  }
}

export {ClanInfo};