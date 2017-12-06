import { API, localDataName } from '../../constant/value';
import store from 'react-native-simple-store';

// Get current game version from api
class GameVersion {
  static getCurrVersion() {
    return new Promise((success, failure) => {
      var format = require('string-format');
      let api = format(API.GameVersion, global.serverName);
      console.log('GameVersion\n' + api);
      fetch(api).then((response) => response.json()).then((json) => {
        if (json != null && json.status == 'ok') {
          success(json.data.game_version);
        }
      }).catch((error) => {
        console.error(error);
        failure(error);
      })
    })
  }
}

export {GameVersion};