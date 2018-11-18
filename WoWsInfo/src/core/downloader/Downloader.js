import { WoWsAPI } from "../../value/api";
import { SERVER, APP, LOCAL } from "../../value/data";
import { SafeFetch } from '../';
import { Guard } from "../util/SafeGuard";

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
      console.log('Downloader\nUpdating all data from API')
    }
  }

  /**
   * Get game server version of WoWs
   */
  async getVersion() {
    let json = await SafeFetch.get(WoWsAPI.GameVersion, this.server);
    // Guard ensures that there is always a value returned
    return Guard(json, 'data.game_version', APP.GameVersion);
  }
}

export { Downloader };
