import { DataAPI, savedDataName } from '../../constant/value';
import { Language } from '../util/';
import store from 'react-native-simple-store';

class Warship {
  // Save ship nations, api languages, ship types and ship modules
  static async saveWarship() {
    var format = require('string-format');
    let api = format(DataAPI.Warship, global.serverName) + Language.getApiLangStr();
    console.log('WarshipData\n' + api);
    try {
      let response = await fetch(api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        let data = json.data;
        for (var i = 2; i <= json.meta.page_total; i++) {
          let new_api = api + '&page_no=' + i;
          console.log(new_api);
          let response = await fetch(new_api);
          let json = await response.json();
          if (json != null && json.status == 'ok') {
            data = Object.assign({}, data, json.data);
          }
        }
        console.log(data);
        global.warshipData = data;
        await store.update(savedDataName.warship, data);
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export {Warship};