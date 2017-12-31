import { DataAPI, savedDataName } from '../../constant/value';
import { Language } from '../';
import store from 'react-native-simple-store';

class DataManager {
  // Update everything from server
  static async updateLocalData() {
    // Language has to be saved in order to load other data correctly
    await DataManager.saveData(DataAPI.Language, savedDataName.language);
    await DataManager.saveData(DataAPI.Encyclopedia, savedDataName.encyclopedia);    
    await DataManager.saveData(DataAPI.ShipType, savedDataName.shipType);    
    await DataManager.saveData(DataAPI.Achievement, savedDataName.achievement);
    await DataManager.saveData(DataAPI.CommanderSkill, savedDataName.commanderSkill);
    await DataManager.saveData(DataAPI.GameMap, savedDataName.gameMap);
    await DataManager.saveData(DataAPI.Consumable, savedDataName.consumable);
    await DataManager.saveData(DataAPI.Warship, savedDataName.warship);
    await DataManager.saveData(DataAPI.Collection, savedDataName.collection);
    await DataManager.saveData(DataAPI.CollectionItem, savedDataName.collectionItem);
    // Additional information
    await DataManager.saveAlias();
    // Personal Rating
    await DataManager.savePersonalRating();
  }

  static async savePersonalRating() {
    try {
      let response = await fetch('https://wows-numbers.com/personal/rating/expected/json/')
      data = await response.json();
      if (data != null) data = data.data;
      // console.log(data);
      global.personalRatingJson = data;
      await store.update(savedDataName.personalRating, data);
    } catch (error) {
      console.error(error);
    }
  }

  static async saveAlias() {
    try {
      let response = await fetch('http://xvm.qingcdn.com/wows/scripts/ships.js')
      let text = await response.text();
      // Make it readable
      var formatted = text.replace('var shipDict=', '').replace('}};', '}}');
      let data = JSON.parse(formatted);
      for (key in data) {
        let ship = data[key];
        if (ship.country == 'japan') {
          // Only Japanese ships
          var name = ship.alias;
          if (name == 'HSF 春風') name = 'HSF 晴风';
          data[key] = name;
        } else {
          // We dont need it
          delete data[key];
        }
      }
      // console.log(json);
      global.aliasJson = data;
      await store.update(savedDataName.alias, data);
    } catch (error) {
      console.error(error);
    }
  }

  static async saveData(dataAPIName, savedName) {
    var format = require('string-format');
    var api = format(dataAPIName, global.serverName);
    if (dataAPIName != DataAPI.ShipType) api += Language.getApiLangStr();
    // console.log(savedName + '\n' + api);
    try {
      let response = await fetch(api);
      let json = await response.json();
      if (json != null && json.status == 'ok') {
        var data = json.data;
        // There might be more data
        let page = json.meta.page_total;
        if (page != null) {
          for (var i = 2; i <= page; i++) {
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
        // Simplify data
        switch (savedName) {
          case savedDataName.achievement: 
            data = data.battle;
            for (key in data) {
              let curr = data[key];
              curr.key = key;
              curr.text = curr.description; delete curr.description;
              curr.icon = curr.image; delete curr.image;
              curr.icon_inactive = curr.image_inactive; delete curr.image_inactive;
            }
            global.achievementJson = data; break;
          case savedDataName.commanderSkill: 
            for (key in data) {
              let curr = data[key];
              curr.key = key;
              var text = '';
              for (var i = 0; i < curr.perks.length; i++) {
                text += curr.perks[i].description + '\n';
              }
              curr.text = text; delete curr.perks;
            }
            global.commanderSkillJson = data; break;
          case savedDataName.consumable: 
            for (key in data) {
              let curr = data[key];
              curr.key = key;
              curr.icon = curr.image; delete curr.image;
              var text = curr.description + '\n\n'; delete curr.description;
              for (info in curr.profile) {
                text += curr.profile[info].description + '\n';
              }
              curr.text = text; delete curr.profile; 
              delete curr.price_gold; delete curr.price_credit;     
            }
            global.consumableJson = data; break;
          case savedDataName.encyclopedia: global.encyclopediaJson = data; break;
          case savedDataName.shipType: 
            data = data.ship_types;
            global.shipTypeJson = data; break;
          case savedDataName.gameMap: global.gameMapJson = data; break;
          case savedDataName.language: 
            data = data.languages;
            global.languageJson = data; break;
          case savedDataName.warship: 
            for (key in data) {
              let curr = data[key];
              curr.icon = curr.images.small; delete curr.images;              
            }
            global.warshipJson = data; break;
          case savedDataName.collection: 
            for (key in data) {
              let curr = data[key];
              curr.key = curr.collection_id; delete curr.collection_id;
              curr.text = curr.description; delete curr.description;
              curr.icon = curr.image; delete curr.image;
            }
            global.collectionJson = data; break;
          case savedDataName.collectionItem: 
            for (key in data) {
              let curr = data[key];
              curr.key = curr.card_id; delete curr.card_id;
              curr.text = curr.description; delete curr.description;
              curr.icon = curr.images.small; delete curr.images;
              curr.collection = curr.collection_id; delete curr.collection_id;
            }
            global.collectionItemJson = data; break;
        }
        // console.log(data);
        await store.update(savedName, data);
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export {DataManager};