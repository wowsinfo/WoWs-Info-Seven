import { DataAPI, savedDataName } from '../../constant/value';
import { Language } from '../util/';
import store from 'react-native-simple-store';

class Consumable {
  // Save ship nations, api languages, ship types and ship modules
  static async saveConsumable() {
    var format = require('string-format');
    let api = format(DataAPI.Consumable, global.serverName) + Language.getApiLangStr();
    console.log('ConsumableData\n' + api);
    try {
      let response = await fetch(api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        var data = json.data;
        for (var i = 2; i <= json.meta.page_total; i++) {
          let new_api = api + '&page_no=' + i;
          console.log(new_api);
          let response = await fetch(api + '&page_no=' + i);
          let json = await response.json();
          if (json != null && json.status == 'ok') {
            data = Object.assign({}, data, json.data);
          }
        }
        console.log(data);
        global.consumableData = data;
        await store.update(savedDataName.consumable, data);
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export {Consumable};