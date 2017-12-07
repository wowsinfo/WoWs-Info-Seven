import { DataAPI, savedDataName } from '../../constant/value';
import store from 'react-native-simple-store';

class Language {
  // Save ship nations, api languages, ship types and ship modules
  static async saveLanguage() {
    var format = require('string-format');
    let api = format(DataAPI.Language, global.serverName);
    console.log('Language\n' + api);
    try {
      let response = await fetch(api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        let data = json.data.languages;
        console.log(data);
        global.languageJson = data;
        await store.update(savedDataName.language, data);
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export {Language};