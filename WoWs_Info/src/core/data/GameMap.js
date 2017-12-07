import { DataAPI, savedDataName } from '../../constant/value';
import { Language } from '../util/';
import store from 'react-native-simple-store';

class GameMap {
  // Save ship nations, api languages, ship types and ship modules
  static async saveGameMap() {
    var format = require('string-format');
    let api = format(DataAPI.GameMap, global.serverName) + Language.getApiLangStr();
    console.log('GameMapData\n' + api);
    try {
      let response = await fetch(api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        let data = json.data;
        console.log(data);
        global.gameMapData = data;
        await store.update(savedDataName.gameMap, data);
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export {GameMap};