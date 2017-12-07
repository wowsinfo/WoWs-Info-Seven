import { DataAPI, savedDataName } from '../../constant/value';
import { Language } from '../util/';
import store from 'react-native-simple-store';

class CommanderSkill {
  // Save ship nations, api languages, ship types and ship modules
  static async saveCommanderSkill() {
    var format = require('string-format');
    let api = format(DataAPI.CommanderSkill, global.serverName) + Language.getApiLangStr();
    console.log('CommanderSkillData\n' + api);
    try {
      let response = await fetch(api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        let data = json.data;
        console.log(data);
        global.commanderSkillData = data;
        await store.update(savedDataName.commanderSkill, data);
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export {CommanderSkill};