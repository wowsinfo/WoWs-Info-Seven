import { WoWsAPI, WikiAPI } from '../../value/api';
import { SERVER, APP, LOCAL, SAVED } from '../../value/data';
import { SafeFetch } from '../';
import { Guard } from '../util/SafeGuard';
import { SafeStorage } from '../util/SafeStorage';

class Downloader {
  constructor(server) {
    // Convert server index to string
    this.server = SERVER[server];
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
      await this.getLanguage();

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
    // I dont think they gonna update this anytime soon
    DATA[SAVED.language] = {
      'ru': 'Русский',
      'fr': 'Français',
      'en': 'English',
      'zh-tw': '繁體中文',
      'de': 'Deutsch',
      'tr': 'Türkçe',
      'es-mx': 'Español (México)',
      'zh-cn': '中文',
      'pt-br': 'Português do Brasil',
      'pl': 'Polski',
      'th': 'ไทย',
      'cs': 'Čeština',
      'ja': '日本語',
      'es': 'Español'
    }
  }
}

export { Downloader };
