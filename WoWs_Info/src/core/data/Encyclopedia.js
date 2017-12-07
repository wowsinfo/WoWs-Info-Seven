import { DataAPI, savedDataName } from '../../constant/value';
import { Language } from '../util/';
import store from 'react-native-simple-store';

class Encyclopedia {
  // Save ship nations, api languages, ship types and ship modules
  static async saveEncyclopedia() {
    var format = require('string-format');
    let api = format(DataAPI.Encyclopedia, global.serverName) + Language.getApiLangStr();
    console.log('EncyclopediaData\n' + api);
    try {
      let response = await fetch(api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        let data = json.data;
        console.log(data);
        global.encyclopediaJson = data;
        await store.update(savedDataName.encyclopedia, data);
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export {Encyclopedia};