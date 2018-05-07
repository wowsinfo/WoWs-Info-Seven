import { ServerManager } from '../../core';
import { API } from '../../constant/value';

class ClanSearch {
  constructor(server, input) {
    this.server = server;
    var format = require('string-format');
    this.api = format(API.ClanSearch, ServerManager.domainName(server)) + input;
  }

  async Search() {
    try {
      let response = await fetch(this.api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        for (var i = 0; i < json.data.length; i++) {
          let curr = json.data[i];
          curr.server = this.server;
          curr.id = curr.clan_id; delete curr.clan_id;
          curr.name = curr.tag; delete curr.tag;
        }
        return json.data;
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export { ClanSearch };