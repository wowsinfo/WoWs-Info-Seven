import { ServerManager } from '../../core';
import { API } from '../../constant/value';

class PlayerSearch {
  constructor(server, input) {
    var format = require('string-format');
    this.api = format(API.PlayerSearch, ServerManager.getDomainFrom(server)) + input
  }

  async Search() {
    try {
      let response = await fetch(this.api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        return json.data;
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export {PlayerSearch};