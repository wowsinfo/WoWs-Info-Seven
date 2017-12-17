import { ServerManager } from './';
import { API } from '../constant/value';

class PlayerOnline {
  static async getPlayerOnline() {
    var serverInfo = {server: []};
    var total = 0;
    try {
      for (var i = 0; i < 4; i++) {
        // We have 4 servers >_<
        var format = require('string-format');
        let api = format(API.PlayerOnline, ServerManager.getDomainFrom(i));
        // console.log(api);
        let response = await fetch(api);
        let json = await response.json();
        if (json != null && json.status == 'ok') {
          let online = json.data.wows[0].players_online;
          if (online != null) {
            // It might be null when that server is now under maintenance
            // console.log(online);
            serverInfo.server.push(online);
            total += online;
          } else serverInfo.server.push(0);
        }
      }
    } catch (error) {
      console.error(error);
    }
    serverInfo.total = total;
    return serverInfo;
  }
}

export {PlayerOnline};