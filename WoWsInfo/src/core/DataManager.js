import { DataAPI, SavedData } from '../constant/value';
import { Language } from './';
import store from 'react-native-simple-store';

class DataManager {
  // Update everything from server
  static async UpdateLocalData(updateText) {
    // Language has to be saved in order to load other data correctly
    await DataManager.saveData(DataAPI.Language, SavedData.language);
    updateText(".");
    // Personal Rating
    await DataManager.savePersonalRating();
    updateText("..");    
    await DataManager.saveData(DataAPI.Encyclopedia, SavedData.encyclopedia);
    updateText("...");    
    await DataManager.saveData(DataAPI.ShipType, SavedData.ship_type);    
    updateText("....");    
    await DataManager.saveData(DataAPI.Achievement, SavedData.achievement);
    updateText(".....");    
    await DataManager.saveData(DataAPI.CommanderSkill, SavedData.commander_skill);
    updateText("......");    
    await DataManager.saveData(DataAPI.GameMap, SavedData.map);
    updateText(".......");    
    await DataManager.saveData(DataAPI.Consumable, SavedData.consumable);
    updateText("........");    
    await DataManager.saveData(DataAPI.Warship, SavedData.warship);
    updateText(".........");    
    // Additional information
    await DataManager.saveData(DataAPI.Collection, SavedData.collection);
    updateText("App is ready");    
    await DataManager.saveData(DataAPI.CollectionItem, SavedData.collection_item);
  }

  /**
   * Download new personal rating json file from server
   */
  static async savePersonalRating() {
    try {
      let response = await fetch(DataAPI.PersonalRating);
      let data = await response.json();
      if (data != null) data = data.data;
      // console.log(data);
      global.data.personal_rating = data;
      await store.save(SavedData.personal_rating, data);
    } catch (error) {
      console.error(error);
    }
  }

  /**
   * Save data depending on name
   * @param {*} dataAPI 
   * @param {*} saved 
   */
  static async saveData(dataAPI, saved) {
    var format = require('string-format');
    var api = format(dataAPI, global.domain) + Language.getApiLangStr();
    console.log(api);
    // console.log(saved + '\n' + api);
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
        switch (saved) {
          case SavedData.achievement: 
            data = data.battle;
            for (key in data) {
              let curr = data[key];
              curr.key = key;
              curr.text = curr.description; delete curr.description;
              curr.icon = curr.image; delete curr.image;
              curr.icon_inactive = curr.image_inactive; delete curr.image_inactive;
            }
            global.data.achievement = data; break;
          case SavedData.commander_skill: 
            for (key in data) {
              let curr = data[key];
              curr.key = key;
              var text = '';
              for (var i = 0; i < curr.perks.length; i++) {
                text += curr.perks[i].description + '\n';
              }
              curr.text = text; delete curr.perks;
            }
            global.data.commander = data; break;
          case SavedData.consumable: 
            for (key in data) {
              let curr = data[key];
              curr.key = key;
              curr.icon = curr.image; delete curr.image;
              var text = curr.description + '\n\n'; delete curr.description;
              for (info in curr.profile) {
                text += curr.profile[info].description + '\n';
              }
              curr.text = text; delete curr.profile;    
            }
            global.data.consumable = data; break;
          case SavedData.encyclopedia: global.data.encyclopedia = data; break;
          case SavedData.ship_type: 
            data = data.ship_types;
            global.data.ship_type = data; break;
          case SavedData.map: global.data.map = data; break;
          case SavedData.language: 
            data = data.languages;
            global.data.language = data; break;
          case SavedData.warship: 
            for (key in data) {
              let curr = data[key];
              curr.icon = curr.images.small; delete curr.images;
            }
            global.data.warship = data; break;
          case SavedData.collection: 
            for (key in data) {
              let curr = data[key];
              curr.key = curr.collection_id; delete curr.collection_id;
              curr.text = curr.description; delete curr.description;
              curr.icon = curr.image; delete curr.image;
            }
            global.data.collection = data; break;
          case SavedData.collection_item: 
            for (key in data) {
              let curr = data[key];
              curr.key = curr.card_id; delete curr.card_id;
              curr.text = curr.description; delete curr.description;
              if (curr.text.includes('<')) {
                // Remove HTML styling
                curr.text = curr.text.replace(/\<.*?>/gi, '');
              }
              curr.icon = curr.images.small; delete curr.images;
              curr.collection = curr.collection_id; delete curr.collection_id;
            }
            global.data.collection_item = data; break;
        }
        // console.log(data);
        await store.save(saved, data);
      }
    } catch (error) {
      console.error(error);
    }
  }
}

export { DataManager };