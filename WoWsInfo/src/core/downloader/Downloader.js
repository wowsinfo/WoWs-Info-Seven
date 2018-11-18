import { WoWsAPI } from "../../value/api";
import { SERVER } from "../../value/data";
import { SafeFetch } from '../';

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
    this.getVersion();
  }

  /**
   * Get game server version of WoWs
   */
  async getVersion() {
    let json = await SafeFetch.get(WoWsAPI.GameVersion, this.server);
    if (json) {
      // Json data is valid
      console.log(json);
    }
  }
}

export { Downloader };
