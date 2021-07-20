import {WoWsAPI, WikiAPI} from '../../value/api';
import {
  APP,
  LOCAL,
  SAVED,
  langStr,
  getCurrDomain,
  getAPILanguage,
  updateCurrData,
  shouldUpdateWithCycle,
  getCurrDate,
} from '../../value/data';
import {SafeFetch, Guard, SafeStorage} from '../';
import {lang} from '../../value/lang';

class Downloader {
  constructor(server) {
    // Convert server index to string
    this.domain = getCurrDomain();
    this.language = langStr();

    // To prevent when first launch, everything is new and too many dots
    this.new = !DATA[LOCAL.firstLaunch];
    console.log(this.new);

    console.log(`Downloader\nYou server is '${this.domain}'`);
  }

  /**
   * check if there is an update
   * @param {*} previous this is the version we have
   * @param {*} current this is the version from API
   */
  checkVersionUpdate(previous, current) {
    // Simply check if they are different
    return previous !== current;
    // pList = previous.split('.');
    // cList = current.split('.');

    // for (i = 0; i < pList.length; i++) {
    //   // If one digit is larger, we need to update here
    //   if (Number(current[i]) > Number(previous[i])) {
    //     console.log('Should update');
    //     return true;
    //   }
    // }

    // return false;
  }

  /**
   * Show random review and share to users
   */
  reviewOrShareIfLucky() {}

  /**
   * Update current date and check if lastUpdate has been a week
   */
  checkUpdateCycle() {
    // update curr data first
    updateCurrData();
    const shouldUpdate = shouldUpdateWithCycle();
    console.log(shouldUpdate);
    return shouldUpdate;
  }

  /**
   * Update all data if there is a new version except for force mode
   * @param {Boolean} force
   */
  async updateAll(force = false) {
    // Get server version
    console.log('Downloader\nChecking for new version');
    let log = 'Getting gameVersion\n';
    try {
      let gameVersion = await this.getVersion();
      log += `gameVersion - ${gameVersion}\n`;
      // Do not continue if we cannot get current game version
      if (gameVersion == null) return this.makeObj(false, log);
      let currVersion = DATA[LOCAL.gameVersion];
      console.log(`Current: ${currVersion}\nAPI: ${gameVersion}`);
      let appVersion = await SafeStorage.get(LOCAL.appVersion, '1.0.4.2');
      log += `appVersion - ${appVersion}\n`;
      console.log(`Current app version: ${appVersion}\nLatest: ${APP.Version}`);
      // Check for update cycle, game update, force mode or app update
      if (
        this.checkUpdateCycle() ||
        this.checkVersionUpdate(currVersion, gameVersion) ||
        force ||
        appVersion !== APP.Version
      ) {
        // Update all data
        log += 'Updating Data\n';
        console.log('Downloader\nUpdating all data from API');
        // Download language
        DATA[SAVED.language] = await this.getLanguage();
        log += `${lang.setting_api_language}\n`;
        // Download ship type, nation and module names for Wiki
        DATA[SAVED.encyclopedia] = await this.getEncyclopedia();
        log += `${lang.wiki_section_title}\n`;

        // Wiki
        DATA[SAVED.warship] = await this.getWarship();
        log += `${lang.wiki_warships}\n`;

        DATA[SAVED.achievement] = await this.getAchievement();
        log += `${lang.wiki_achievement}\n`;

        DATA[SAVED.collection] = await this.getCollectionAndItem();
        log += `${lang.wiki_collections}\n`;

        DATA[SAVED.commanderSkill] = await this.getCommanderSkill();
        log += `${lang.wiki_skills}\n`;

        DATA[SAVED.consumable] = await this.getConsumable();
        log += `${lang.wiki_upgrades}\n`;

        DATA[SAVED.map] = await this.getMap();
        log += `${lang.wiki_maps}\n`;

        DATA[SAVED.pr] = await this.getPR();
        log += `${lang.rating_title}\n`;

        let PR = DATA[SAVED.pr];
        if (PR == null || Object.keys(PR).length < 10) {
          // Get data from the mirror
          DATA[SAVED.pr] = await this.getPRMirror();
          log += `${lang.rating_title} - mirror\n`;
          PR = DATA[SAVED.pr];
          // Check if the mirror is ok
          if (PR == null || Object.keys(PR).length < 10) {
            log += `${lang.error_pr_corruption}\n`;
            log += ` ${lang.rating_title} - ${JSON.stringify(PR)}\n`;
            return this.makeObj(false, log);
          }
        }

        // Uncomment this line to log everything
        // console.log(DATA);

        // Make sure it is also great than current version
        // Update this value only if all data are saved correctly
        SafeStorage.set(LOCAL.gameVersion, gameVersion);
        SafeStorage.set(LOCAL.appVersion, APP.Version);
        // Save last update as well
        SafeStorage.set(LOCAL.lastUpdate, getCurrDate());
      }
      return this.makeObj(true, log);
    } catch (err) {
      // Note: it might fail even if data are loaded correctly
      log += err;
      return this.makeObj(false, log);
    }
  }

  makeObj(status, log) {
    return {status, log};
  }

  /**
   * Get game server version of WoWs
   */
  async getVersion() {
    let json = await SafeFetch.get(WoWsAPI.GameVersion, this.domain);
    // Guard ensures that there is always a value returned
    return Guard(json, 'data.game_version', APP.GameVersion);
  }

  /**
   * Get all supported languages locally
   */
  async getLanguage() {
    let json = await SafeFetch.get(WikiAPI.Language, this.domain);
    let data = Guard(json, 'data.languages', {});
    // Save data
    await SafeStorage.set(SAVED.language, data);
    return data;
  }

  /**
   * Get ship types, nations and module names
   */

  async getEncyclopedia() {
    let json = await SafeFetch.get(
      WikiAPI.Encyclopedia,
      this.domain,
      this.language,
    );
    let data = Guard(json, 'data', {});
    await SafeStorage.set(SAVED.encyclopedia, data);
    return data;
  }

  ///
  //  UPDATE API to my unique data format
  //
  //  icon -> This is the icon the list will use
  //  description -> This is used under the icon
  //  name -> ship name, consumable name...
  //  new -> if this entry is new
  //
  ///

  async getWarship() {
    let pageTotal = 1;
    let page = 0;
    let all = {};

    // Download data from Github
    const model3D = await SafeFetch.normal(WikiAPI.Github_Model);

    // For Chinese and Japanese users only
    let JapaneseShips = null;
    let currLang = getAPILanguage();
    if (currLang.includes('zh') || currLang.includes('ja')) {
      JapaneseShips = await SafeFetch.normal(WikiAPI.Github_Alias);
    }

    while (page < pageTotal) {
      // page + 1 to get actually page not index
      let json = await SafeFetch.get(
        WikiAPI.Warship,
        this.domain,
        `&page_no=${page + 1}&${this.language}`,
      );
      pageTotal = Guard(json, 'meta.page_total', 1);
      let data = Guard(json, 'data', {});

      for (let id in data) {
        let curr = data[id];
        if (curr.name.includes('[')) {
          delete data[id];
        } else {
          // curr.icon = Guard(curr, 'images.small', '');
          curr.icon = curr.images.small;
          delete curr.images;
          // Orange name or not
          curr.premium = curr.is_premium || curr.is_special;
          delete curr.is_premium;
          delete curr.is_special;
          // If it is undefined then it is new
          if (this.new === true) {
            let isOld = Guard(DATA[SAVED.warship], `${id}`, true);
            curr.new = isOld ? false : true;
          }
          // If it has some extra data
          if (model3D != null && model3D[id] != null) {
            curr.model = model3D[id].model;
          }

          if (JapaneseShips != null) {
            const entry = JapaneseShips[id];
            if (entry != null) {
              curr.name = entry.alias;
            }
          }
        }
      }

      // Add to all
      Object.assign(all, data);
      page++;
    }

    await SafeStorage.set(SAVED.warship, all);
    return all;
  }

  async getAchievement() {
    let json = await SafeFetch.get(
      WikiAPI.Achievement,
      this.domain,
      `${this.language}`,
    );
    let data = Guard(json, 'data.battle', {});
    if (this.new === true) {
      for (let id in data) {
        let curr = data[id];
        curr.new = DATA[SAVED.achievement][id] ? false : true;
      }
    }
    await SafeStorage.set(SAVED.achievement, data);
    return data;
  }

  async getCollectionAndItem() {
    let all = {};

    let collection = await SafeFetch.get(
      WikiAPI.Collection,
      this.domain,
      `${this.language}`,
    );
    let item = await SafeFetch.get(
      WikiAPI.CollectionItem,
      this.domain,
      `${this.language}`,
    );

    collection = Guard(collection, 'data', {});
    item = Guard(item, 'data', {});

    for (let id in item) {
      let curr = item[id];
      curr.image = curr.images.small;
      delete curr.images;
    }

    if (this.new === true) {
      for (let id in collection) {
        let curr = collection[id];
        let isOld = Guard(DATA[SAVED.collection], `collection.${id}`, true);
        curr.new = isOld ? false : true;
      }
    }

    all['collection'] = collection;
    all['item'] = item;

    await SafeStorage.set(SAVED.collection, all);
    return all;
  }

  async getCommanderSkill() {
    let json = await SafeFetch.get(
      WikiAPI.CommanderSkill,
      this.domain,
      `${this.language}`,
    );

    let skill = Guard(json, 'data', []);
    let data = Object.keys(skill).map(k => skill[k]);
    data.sort((a, b) => a.tier - b.tier);

    await SafeStorage.set(SAVED.commanderSkill, data);
    return data;
  }

  async getConsumable() {
    let pageTotal = 1;
    let page = 0;
    let all = {};

    while (page < pageTotal) {
      // page + 1 to get actually page not index
      let json = await SafeFetch.get(
        WikiAPI.Consumable,
        this.domain,
        `&page_no=${page + 1}&${this.language}`,
      );
      pageTotal = Guard(json, 'meta.page_total', 1);
      let data = Guard(json, 'data', {});

      for (let id in data) {
        let curr = data[id];
        if (this.new === true) {
          curr.new = DATA[SAVED.consumable][id] ? false : true;
        }

        if (curr.type === 'Modernization') {
          // Calculate their slots
          let price = curr.price_credit;
          let slot = 1;
          while (price > 125000) {
            price /= 2;
            slot += 1;
          }

          // Legendary upgrades
          if (slot > 6) continue;
          curr.slot = slot;
        }
      }

      // Add to all
      Object.assign(all, data);
      page++;
    }

    await SafeStorage.set(SAVED.consumable, all);
    return all;
  }

  async getMap() {
    let json = await SafeFetch.get(
      WikiAPI.GameMap,
      this.domain,
      `${this.language}`,
    );

    let map = Guard(json, 'data', []);
    let data = Object.keys(map).map(k => map[k]);

    await SafeStorage.set(SAVED.map, data);
    return data;
  }

  async getPR() {
    let res = await SafeFetch.normal(WikiAPI.PersonalRating);
    let json = Guard(res, 'data', {});
    // Cleanup empty key
    for (let key in json) {
      let curr = json[key];
      if (curr.length === 0) {
        delete json[key];
      }
    }

    await SafeStorage.set(SAVED.pr, json);
    return json;
  }

  async getPRMirror() {
    let res = await SafeFetch.normal(WikiAPI.PersonalRatingMirror);
    let json = Guard(res, 'data', {});
    // Cleanup empty key
    for (let key in json) {
      let curr = json[key];
      if (curr.length === 0) {
        delete json[key];
      }
    }

    await SafeStorage.set(SAVED.pr, json);
    return json;
  }
}

export {Downloader};
