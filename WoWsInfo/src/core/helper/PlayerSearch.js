import { API } from '../../constant/value';
import { ServerManager } from '../';


class PlayerSearch {
  constructor(index, input) {
    var format = require('string-format');
    this.api = format(API.PlayerSearch, ServerManager.domainName(index)) + input
  }

  async Search() {
    try {
      let response = await fetch(this.api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        for (key in json.data) {
          let curr = json.data[key];
          // Save server inndex, id and name
          curr.server = server;
          curr.id = curr.account_id; delete curr.account_id;
          curr.name = curr.nickname; delete curr.nickname;
        }
        return json.data;
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export { PlayerSearch };