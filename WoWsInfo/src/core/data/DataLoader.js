/**
 * Load all saved data to global
 */
import { SafeStorage } from '../util/SafeStorage';
import { LOCAL, SAVED, APP } from '../../value/data';
import { BLUE } from 'react-native-material-color';
import { lang } from '../../value/lang';

class DataLoader {
  /**
   * Load all data from storage
   * Return an object with all data
   */
  static async loadAll() {
    // For debugging only
    // SafeStorage.clear();

    let local = await this.loadLocal();
    let saved = await this.loadSaved();
    return Object.assign(local, saved);
  }

  /**
   * Load all local data, no Internet is required
   * @param {*} data 
   */
  static async loadLocal() {
    const { apiLanguage, appVersion, gameVersion, firstLaunch, friendList, userData, noImageMode, proVersion,
      userInfo, userServer, lastUpdate, theme, darkMode, date, swapButton, userLanguage, rsIP, lastLocation } = LOCAL;

    let data = {};
    // Manully setting up SAVED section (they are all different)
    this.loadEntry(data, apiLanguage, 'en');
    this.loadEntry(data, userLanguage, lang.getLanguage());
    this.loadEntry(data, swapButton, false);
    this.loadEntry(data, appVersion, APP.Version);
    this.loadEntry(data, gameVersion, APP.GameVersion);
    this.loadEntry(data, firstLaunch, true);
    this.loadEntry(data, rsIP, '');
    this.loadEntry(data, lastLocation, '');
    this.loadEntry(data, proVersion, false);

    // Add support to save clans as well
    let list = {
      clan: {
        2000008934: {tag: 'FFD', clan_id: '2000008934', server: 3}
      },
      player: {
        2011774448: {nickname: 'HenryQuan', account_id: '2011774448', server: 3}
      }
    };

    this.loadEntry(data, friendList, list).then(() => {
      let info = data[friendList];
      if (info.player == null) {
        // Previously, it was all players
        let saved = {clan: {}, player: {}};
        info.forEach(v => saved.player[v.id] = this.formatConverter(v));
        data[friendList] = saved;
        SafeStorage.set(friendList, saved);
      }
    });

    this.loadEntry(data, userData, {});
    this.loadEntry(data, userInfo, {nickname: '', account_id: '', server: 3}).then(() => {
      // Update format
      let info = data[userInfo];
      if (info.nickname == null) {
        let formatted = this.formatConverter(info);
        data[userInfo] = formatted;
        SafeStorage.set(userInfo, formatted);
      }
    });
    this.loadEntry(data, userServer, 3);
    this.loadEntry(data, lastUpdate, new Date().toDateString());
    this.loadEntry(data, theme, BLUE);
    this.loadEntry(data, darkMode, false);
    this.loadEntry(data, noImageMode, false);
    this.loadEntry(data, date, new Date().toDateString());
    return data;
  }

  /**
   * Convert old format to new format
   * @param {*} obj 
   */
  static formatConverter(obj) {
    if (obj.name != null) {
      obj.nickname = obj.name;
      delete obj.name;
    }

    if (obj.id != null) {
      obj.account_id = obj.id;
      delete obj.id;
    }

    return obj;
  }

  /**
   * Load all saved data, Internet connection is required
   * @param {*} data 
   */
  static async loadSaved() {
    let data = {};
    // SAVED section is about the same
    for (let key in SAVED) {
      const curr = SAVED[key];
      // Get it from storage
      data[curr] = await SafeStorage.get(curr, {});
    }
    return data;
  }

  /**
   * Load and setup entries
   * @param {object} data 
   * @param {string} key 
   * @param {any} value 
   */
  static async loadEntry(data, key, value) {
    data[key] = await SafeStorage.get(key, value);
  }
}

export { DataLoader };
