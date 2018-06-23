import { ServerManager } from '../';
import { API } from '../../constant/value';

class PlayerOnline {
  static async getPlayerOnline() {
    try {
      var format = require('string-format');
      let api = format(API.PlayerOnline, ServerManager.domainName(server));
      // console.log(api);
      let response = await fetch(api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        let online = json.data.wows[0].players_online;
        if (online != null) {
          // console.log(online);
          return online;
        }
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export { PlayerOnline };