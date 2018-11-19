import { WoWsAPI, WikiAPI } from '../../value/api';
import { SERVER, APP, LOCAL, SAVED } from '../../value/data';
import { SafeFetch, Guard, SafeStorage, langStr } from '../';

class Downloader {
  constructor(server) {
    // Convert server index to string
    this.server = SERVER[server];
    this.language = langStr();
    console.log(`Downloader\nYou server is '${this.server}'`);
  }
  /**
   * Update all data if there is a new version except for force mode
   * @param {Boolean} force 
   */
  async updateAll(force=false) {
    // Get server version
    console.log('Downloader\nChecking for new version');
    let gameVersion = await this.getVersion();
    let currVersion = DATA[LOCAL.gameVersion];
    console.log(`Current: ${currVersion}\nAPI: ${gameVersion}`);
    if (gameVersion > currVersion || force) {
      // Update all data
      console.log('Downloader\nUpdating all data from API');
      // Download language
      DATA[SAVED.language] = await this.getLanguage();
      // Download ship type, nation and module names for Wiki
      DATA[SAVED.encyclopedia] = await this.getEncyclopedia();

      // Wiki
      await this.getWarship();
      await this.getAchievement();
      await this.getCollectionAndItem();
      await this.getCommanderSkill();
      await this.getConsumable();
      await this.getMap();
      await this.getPR();

      console.log(DATA);
    }
    // Update this value only if all data are saved correctly
    SafeStorage.set(LOCAL.gameVersion, gameVersion);
  }

  /**
   * Get game server version of WoWs
   */
  async getVersion() {
    let json = await SafeFetch.get(WoWsAPI.GameVersion, this.server);
    // Guard ensures that there is always a value returned
    return Guard(json, 'data.game_version', APP.GameVersion);
  }

  /**
   * Get all supported languages locally
   */
  async getLanguage() {
    let json = await SafeFetch.get(WikiAPI.Language, this.server);
    let valid = Guard(json, 'data.languages', {});
    // Save data
    await SafeStorage.set(SAVED.language, valid);
    return valid; 
  }
  
  /**
   * Get ship types, nations and module names
   */

  async getEncyclopedia() {
    let json = await SafeFetch.get(WikiAPI.Encyclopedia, this.server, this.language);
    let valid = Guard(json, 'data', {});
    await SafeStorage.set(SAVED.encyclopedia, valid);
    return valid;
  }

  async getWarship() {

  }

  async getAchievement() {

  }

  async getCollectionAndItem() {
    
  }

  async getCommanderSkill() {
    
  }

  async getConsumable() {
    
  }

  async getMap() {
    
  }

  async getPR() {
    
  }
}

export { Downloader };
