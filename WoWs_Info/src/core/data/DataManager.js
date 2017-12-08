import { DataAPI, savedDataName } from '../../constant/value';
import { Language } from '../util/';
import store from 'react-native-simple-store';

class DataManager {
  // Update everything from server
  static async updateLocalData() {
    // Language has to be saved in order to load other data correctly
    await DataManager.saveData(DataAPI.Language, global.languageJson, savedDataName.language);
    await DataManager.saveData(DataAPI.Encyclopedia, global.encyclopediaJson, savedDataName.encyclopedia);    
    await DataManager.saveData(DataAPI.Achievement, global.achievementJson, savedDataName.achievement);
    await DataManager.saveData(DataAPI.CommanderSkill, global.commanderSkillJson, savedDataName.commanderSkill);
    await DataManager.saveData(DataAPI.GameMap, global.gameMapJson, savedDataName.gameMap);
    await DataManager.saveData(DataAPI.Consumable, global.consumableJson, savedDataName.consumable);
    await DataManager.saveData(DataAPI.Warship, global.warshipJson, savedDataName.warship);
  }

  static async saveData(dataAPIName, globalData, savedName) {
    var format = require('string-format');
    let api = format(dataAPIName, global.serverName) + Language.getApiLangStr();
    // console.log(savedName + '\n' + api);
    try {
      let response = await fetch(api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        var data = json.data;
        // There might be more data
        let page = json.meta.page_total;
        if (page != null) {
          for (var i = 2; i <= json.meta.page_total; i++) {
            let new_api = api + '&page_no=' + i;
            // console.log(new_api);
            let response = await fetch(new_api);
            let json = await response.json();
            if (json != null && json.status == 'ok') {
              // Merge data here
              data = Object.assign({}, data, json.data);
            }
          }
        }
        // Achievement and Language have a special path
        if (savedName == savedDataName.achievement) data = data.battle;
        if (savedName == savedDataName.language) data = data.languages;
         console.log(data);
        globalData = await data;
        await store.update(savedName, data);
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export {DataManager};