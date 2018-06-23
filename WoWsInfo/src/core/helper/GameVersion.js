import { API, LocalData } from '../../constant/value';
import store from 'react-native-simple-store';

// Get current game version from api
class GameVersion {
  static async getCurrVersion() {
    var format = require('string-format');
    let api = format(API.GameVersion, global.domain);
    try {
      // console.log('GameVersion\n' + api);
      let response = await fetch(api);
      let json = await response.json();
      if (json != null && json.status == 'ok') return json.data.game_version;
    } catch (error) {
      console.error(error);
    }
  }
}

export { GameVersion };